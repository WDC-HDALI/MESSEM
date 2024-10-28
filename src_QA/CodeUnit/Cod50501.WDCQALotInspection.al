codeunit 50501 "WDC-QA Lot Inspection"
{
    Permissions = TableData "Item Ledger Entry" = rm, TableData "Warehouse Entry" = rm;
    procedure ModifyLotInfo(VAR LotNoInformation: Record "Lot No. Information"; ShowForm: Boolean)
    var
        RegisteredInspectionChange: record "WDC-QA Registered Inspec Chang";
        TmpRegisteredInspectionChange: Record "WDC-QA Registered Inspec Chang";
        InspectionStatus: Record "WDC-QA Inspection Status";
        WarehouseEntry: Record "Warehouse Entry";
        //ContainerLine: Record "WDC-QA Container Line";
        ReturnAction: Action;
        SampleManagement: Codeunit "WDC-QA Sample Management";
        ReservationEntry: Record "Reservation Entry";
    begin
        IF NOT (RegisteredInspectionChange.READPERMISSION AND RegisteredInspectionChange.WRITEPERMISSION) THEN BEGIN
            MESSAGE(STRSUBSTNO(Text008, RegisteredInspectionChange.TABLECAPTION));
            EXIT;
        END;

        TmpRegisteredInspectionChange.INIT;
        TmpRegisteredInspectionChange."Item No." := LotNoInformation."Item No.";
        TmpRegisteredInspectionChange."Variant Code" := LotNoInformation."Variant Code";
        TmpRegisteredInspectionChange."Lot No." := LotNoInformation."Lot No.";
        TmpRegisteredInspectionChange."Current Vendor Lot No." := LotNoInformation."Vendor Lot No.";
        TmpRegisteredInspectionChange."Current Inspection Status" := LotNoInformation."Inspection Status";
        TmpRegisteredInspectionChange."Current Expiration Date" := LotNoInformation."Expiration Date";
        TmpRegisteredInspectionChange."Current Warranty Date" := LotNoInformation."Warranty Date";
        TmpRegisteredInspectionChange."Date of Change" := WORKDATE;
        TmpRegisteredInspectionChange."Time of Change" := TIME;
        TmpRegisteredInspectionChange."User ID" := USERID;
        TmpRegisteredInspectionChange."Source Type" := SourceType;
        TmpRegisteredInspectionChange."Source Subtype" := SourceSubType;
        TmpRegisteredInspectionChange."Source No." := SourceNo;

        IF NOT ShowForm THEN BEGIN
            TmpRegisteredInspectionChange."New Inspection Status" := NewInspectionStatus;
            TmpRegisteredInspectionChange."Reason Code" := ReasonCode
        END;

        TmpRegisteredInspectionChange.INSERT;


        IF ShowForm THEN
            //ReturnAction := PAGE.RUNMODAL(PAGE::"Change Lot No. Info", TmpRegisteredInspectionChange);

            IF (NOT ShowForm) OR (ReturnAction = ACTION::LookupOK) THEN BEGIN
                IF SetDateLastQC(LotNoInformation.QC, TmpRegisteredInspectionChange."New Inspection Status") THEN
                    LotNoInformation."Date Last QC" := WORKDATE;

                TmpRegisteredInspectionChange."Current Vendor Lot No." := LotNoInformation."Vendor Lot No.";
                IF TmpRegisteredInspectionChange."New Vendor Lot No." <> '' THEN
                    LotNoInformation."Vendor Lot No." := TmpRegisteredInspectionChange."New Vendor Lot No.";
                IF TmpRegisteredInspectionChange."New Inspection Status" = '' THEN
                    LotNoInformation."Inspection Status" := TmpRegisteredInspectionChange."Current Inspection Status"
                ELSE BEGIN
                    TmpRegisteredInspectionChange."Current Inspection Status" := LotNoInformation."Inspection Status";
                    LotNoInformation."Inspection Status" := TmpRegisteredInspectionChange."New Inspection Status";
                    IF InspectionStatus.GET(TmpRegisteredInspectionChange."New Inspection Status") THEN
                        LotNoInformation.QC := InspectionStatus.QC;
                    SampleManagement.ModifyNewVendorFlag(LotNoInformation, InspectionStatus);
                END;

                TmpRegisteredInspectionChange."Current Expiration Date" := LotNoInformation."Expiration Date";
                IF TmpRegisteredInspectionChange."New Expiration Date" = 0D THEN
                    LotNoInformation.VALIDATE("Expiration Date", TmpRegisteredInspectionChange."Current Expiration Date")
                ELSE BEGIN
                    ReservationEntry.SETCURRENTKEY("Lot No.");
                    ReservationEntry.SETRANGE("Lot No.", LotNoInformation."Lot No.");
                    ReservationEntry.SETRANGE("Item No.", LotNoInformation."Item No.");
                    ReservationEntry.SETRANGE("Variant Code", LotNoInformation."Variant Code");
                    ReservationEntry.SETFILTER("Expiration Date", '<>%1', 0D);
                    IF NOT ReservationEntry.ISEMPTY THEN
                        ERROR(Text009, LotNoInformation."Lot No.");
                    IF LotNoInformation."Expiration Date" <> TmpRegisteredInspectionChange."New Expiration Date" THEN BEGIN
                        // ContainerLine.SETCURRENTKEY("Lot No.");
                        // ContainerLine.SETRANGE("Lot No.", "Lot No.");
                        // IF NOT ContainerLine.ISEMPTY THEN
                        //     ContainerLine.MODIFYALL("Expiration Date", TmpRegisteredInspectionChange."New Expiration Date");
                    END;
                    LotNoInformation.VALIDATE("Expiration Date", TmpRegisteredInspectionChange."New Expiration Date");
                END;

                TmpRegisteredInspectionChange."Current Warranty Date" := LotNoInformation."Warranty Date";
                IF TmpRegisteredInspectionChange."New Warranty Date" = 0D THEN
                    LotNoInformation.VALIDATE("Warranty Date", TmpRegisteredInspectionChange."Current Warranty Date")
                ELSE
                    LotNoInformation.VALIDATE("Warranty Date", TmpRegisteredInspectionChange."New Warranty Date");

                IF TmpRegisteredInspectionChange."Delete Second Insp. Status" THEN BEGIN
                    LotNoInformation."Next Inspection Status" := '';
                    LotNoInformation."Date Second Inspection Status" := 0D;
                END;

                WarehouseEntry.SETCURRENTKEY("Lot No.", "Item No.", "Bin Code", "Location Code");
                WarehouseEntry.SETRANGE("Lot No.", LotNoInformation."Lot No.");
                WarehouseEntry.SETRANGE("Item No.", LotNoInformation."Item No.");
                WarehouseEntry.SETRANGE("Variant Code", LotNoInformation."Variant Code");
                IF WarehouseEntry.FINDSET(TRUE) THEN
                    REPEAT
                        IF TmpRegisteredInspectionChange."New Expiration Date" = 0D THEN
                            WarehouseEntry."Expiration Date" := TmpRegisteredInspectionChange."Current Expiration Date"
                        ELSE
                            WarehouseEntry."Expiration Date" := TmpRegisteredInspectionChange."New Expiration Date";

                        IF TmpRegisteredInspectionChange."New Warranty Date" = 0D THEN
                            WarehouseEntry."Warranty Date" := TmpRegisteredInspectionChange."Current Warranty Date"
                        ELSE
                            WarehouseEntry."Warranty Date" := TmpRegisteredInspectionChange."New Warranty Date";

                        WarehouseEntry.MODIFY;
                    UNTIL WarehouseEntry.NEXT <= 0;

                LotNoInformation.MODIFY(TRUE);

                SampleManagement.UpdateOtherLotsWhenRejected(LotNoInformation."Buy-from Vendor No.");

                RegisteredInspectionChange.INIT;
                RegisteredInspectionChange.TRANSFERFIELDS(TmpRegisteredInspectionChange);
                RegisteredInspectionChange."Line No." := 0;
                RegisteredInspectionChange."Lot No." := LotNoInformation."Lot No.";
                RegisteredInspectionChange."New Lot No." := '';
                RegisteredInspectionChange."Date of Change" := WORKDATE;
                RegisteredInspectionChange."Time of Change" := TIME;
                RegisteredInspectionChange."User ID" := USERID;
                RegisteredInspectionChange.INSERT;

            END;

    END;

    procedure SetSourceValues(SourceTypeIN: Option " ","Reg. Header"; SourceSubTypeIN: Option "0","1","2","3","4","5","6","7","8","9","10"; SourceNoIN: Code[20])
    var

    begin
        SourceSubType := SourceSubTypeIN;
        SourceNo := SourceNoIN;
    end;

    procedure SetDateLastQC(QCOldInspectionStatusLot: Boolean; NewInspectionStatusCode: Code[20]): Boolean
    var
        NewInspectionStatus: Record "WDC-QA Inspection Status";
    begin
        IF NewInspectionStatus.GET(NewInspectionStatusCode) THEN
            IF (QCOldInspectionStatusLot) AND (NOT NewInspectionStatus.QC) THEN
                EXIT(TRUE);
        EXIT(FALSE)
    end;

    var
        HideMessages: Boolean;
        InspectionType: Option " ","Planning Inventory","Consumption","Sales","Pick","Purchase Invoice","Transfer From";
        SourceType: Option " ","Reg. Header";
        SourceSubType: Option "0","1","2","3","4","5","6","7","8","9","10";
        SourceNo: Code[20];
        NewInspectionStatus: Code[20];
        ReasonCode: Code[10];
        Text008: TextConst ENU = 'You do not have read and write permissions for Table %1.', FRA = 'Vous n''avez pas de permissions pour lire ou écrire dans la table %1.';
        Text009: TextConst ENU = 'Lot number %1 is used by other documents', FRA = 'N° Lot %1 est utilisé par d''autres documents';
}
