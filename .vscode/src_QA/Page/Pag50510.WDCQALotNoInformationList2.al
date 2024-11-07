page 50510 "WDC-QA Lot No InformationList2"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lot No. Information List', FRA = 'Liste information n° lot';
    PageType = Worksheet;
    SourceTable = "Lot No. Information";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';
                field(ItemCategoryFilter; ItemCategoryFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Item Category Filter', FRA = 'Filtre catégorie article';
                    TableRelation = "Item Category";
                    trigger OnValidate()
                    begin
                        ItemCategoryFilterOnAfterValid;
                    end;
                }
                field(ItemFilter; ItemFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Item No. Filter', FRA = 'Filtre n° article';
                    TableRelation = Item;
                    trigger OnValidate()
                    begin
                        ItemFilterOnAfterValidate;
                    end;

                    trigger OnLookup(VAR Text: Text): Boolean
                    var
                        Item: Record Item;
                        ItemList: Page "Item List";
                    begin
                        ItemList.SETTABLEVIEW(Item);
                        ItemList.LOOKUPMODE(TRUE);
                        IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            ItemList.GETRECORD(Item);
                            ItemFilter := Item."No.";
                            SetFilters;
                            CurrPage.UPDATE(FALSE);
                        end;
                    end;
                }
                field(LotNoFilter; LotNoFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Lot No. Filter', FRA = 'Filtre n° lot';
                    trigger OnValidate()
                    begin
                        LotNoFilterOnAfterValidate;
                    end;

                    trigger OnLookup(VAR Text: Text): Boolean
                    var
                        LotNoInformation: Record "Lot No. Information";
                        LotNoInformationList: Page "Lot No. Information List";
                    begin
                        CLEAR(LotNoInformationList);
                        Rec.COPYFILTER("Item No.", LotNoInformation."Item No.");
                        LotNoInformationList.SETTABLEVIEW(LotNoInformation);
                        LotNoInformationList.EDITABLE(FALSE);
                        LotNoInformationList.LOOKUPMODE(TRUE);
                        IF LotNoInformationList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            LotNoInformationList.GETRECORD(LotNoInformation);
                            LotNoFilter := LotNoInformation."Lot No.";
                            ItemFilter := LotNoInformation."Item No.";
                            SetFilters;
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                field(InspectionStatusFilter; InspectionStatusFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Inspection Status Filter', FRA = 'Filtre status inspection';
                    TableRelation = "WDC-QA Inspection Status";
                    trigger OnValidate()
                    begin
                        InspectionStatusFilterOnAfterV;
                    end;
                }
                field(QCFilter; QCFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'QC Filter', FRA = 'Filtre CQ';
                    OptionCaptionML = ENU = ' ,Yes,No', FRA = ' ,Oui,Non';
                    trigger OnValidate()
                    begin
                        QCFilterOnAfterValidate;
                    end;
                }
                field(ProdDateFilterStart; ProdDateFilterStart)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Production Date from', FRA = 'Date de création de...';
                    //BlankZero = true;
                }
                field(ProdDateFilterEnd; ProdDateFilterEnd)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Production Date to', FRA = 'Date de création jusqu''à...';
                    //BlankZero=true;
                }
                field(MinDaysOldFilter; MinDaysOldFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Age (days) from', FRA = 'Age (jours) de...';
                    //BlankZero=true;
                    trigger OnValidate()
                    begin
                        MinDaysOldFilterOnAfterValidat;
                    end;
                }
                field(MaxDaysOldFilter; MaxDaysOldFilter)
                {
                    ApplicationArea = all;
                    captionML = ENU = 'Age (days) to', FRA = 'Age (jours) jusqu''à...';
                    //BlankZero=true;
                    trigger OnValidate()
                    begin
                        MaxDaysOldFilterOnAfterValidat;
                    end;
                }
                field(MinDaysUntilExpirationFilter; MinDaysUntilExpirationFilter)
                {
                    CaptionML = ENU = 'Days until Expiration from', FRA = 'Période pour vente de...';
                    //BlankZero=true;
                    trigger OnValidate()
                    begin
                        MinDaysUntilExpirationFilterOn;
                    end;
                }
                field(MaxDaysUntilExpirationFilter; MaxDaysUntilExpirationFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Days until Expiration to', FRA = 'Période pour vente jusqu''à...';
                    //BlankZero=true;
                    trigger OnValidate()
                    begin
                        MaxDaysUntilExpirationFilterOn;
                    end;
                }
            }
            repeater(Control)
            {
                Editable = false;
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Qty Shipm.Units per Shipm.Cont"; Rec."Qty Shipm.Units per Shipm.Cont")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field(GetParentLotNo; Rec.GetParentLotNo)
                {
                    ApplicationArea = all;
                }
                field("Inspection Status"; Rec."Inspection Status")
                {
                    ApplicationArea = all;
                }
                field("Vendor Lot No."; Rec."Vendor Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Certificate Number"; Rec."Certificate Number")
                {
                    ApplicationArea = all;
                }
                field("Next Inspection Status"; Rec."Next Inspection Status")
                {
                    ApplicationArea = all;
                }
                field("Date Second Inspection Status"; Rec."Date Second Inspection Status")
                {
                    ApplicationArea = all;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(QC; Rec.QC)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Funtion&s")
            {
                action("Create Sub Lot")
                {
                    CaptionML = ENU = 'Create Sub Lot', FRA = 'Créer sous-lot';
                    Image = CreateSerialNo;
                    trigger OnAction()
                    begin
                        CreateSubLot;
                    end;
                }
            }
            action("&Print")
            {
                CaptionML = ENU = '&Print', FRA = '&Imprimer';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                Ellipsis = true;
                trigger OnAction()
                var
                    LotInformationReport: Report "WDC-QA Lot Information";
                begin
                    LotNoInformation.COPYFILTERS(Rec);
                    LotInformationReport.SETTABLEVIEW(LotNoInformation);
                    LotInformationReport.RUNMODAL;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        GetFilterFields;
        SetFilters;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        myInt: Integer;
    begin
        IF Rec.FIND(Which) THEN BEGIN

            LotNoInformation := Rec;
            WHILE TRUE DO
                IF ShowRec THEN
                    EXIT(TRUE)
                ELSE
                    IF Rec.NEXT(1) = 0 THEN BEGIN

                        Rec := LotNoInformation;
                        IF Rec.FIND(Which) THEN
                            WHILE TRUE DO
                                IF ShowRec THEN
                                    EXIT(TRUE)
                                ELSE
                                    IF Rec.NEXT(-1) = 0 THEN
                                        EXIT(FALSE);
                    END;
        END;
        EXIT(FALSE);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        RealSteps: Integer;
        NextSteps: Integer;
    begin
        IF Steps = 0 THEN
            EXIT;

        LotNoInformation := Rec;
        REPEAT
            NextSteps := Rec.NEXT(Steps / ABS(Steps));
            IF ShowRec THEN BEGIN
                RealSteps := RealSteps + NextSteps;
                LotNoInformation := Rec;
            END;
        UNTIL (NextSteps = 0) OR (RealSteps = Steps);
        Rec := LotNoInformation;
        Rec.FIND;
        EXIT(RealSteps);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.RESET;
    end;

    procedure SearchInsertVendor() VendorNo: Code[20]
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Variant Code", "Lot No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
        ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
        ItemLedgerEntry.SETFILTER("Variant Code", Rec."Variant Code");
        ItemLedgerEntry.SETRANGE("Lot No.", Rec."Lot No.");
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Vendor);
        IF ItemLedgerEntry.FINDFIRST THEN
            EXIT(ItemLedgerEntry."Source No.")
        ELSE
            EXIT('');
    end;

    procedure SetFilters()
    begin
        CASE QCFilter OF
            QCFilter::Yes:
                Rec.SETRANGE(QC, TRUE);
            QCFilter::No:
                Rec.SETRANGE(QC, FALSE);
            ELSE
                Rec.SETRANGE(QC)
        END;

        IF InspectionStatusFilter = '' THEN
            Rec.SETRANGE("Inspection Status")
        ELSE
            Rec.SETFILTER("Inspection Status", InspectionStatusFilter);
        IF ItemCategoryFilter = '' THEN
            Rec.SETRANGE("Item Category Code")
        ELSE
            Rec.SETFILTER("Item Category Code", ItemCategoryFilter);

        IF ItemFilter = '' THEN
            Rec.SETRANGE("Item No.")
        ELSE
            Rec.SETFILTER("Item No.", ItemFilter);

        IF LotNoFilter = '' THEN
            Rec.SETRANGE("Lot No.")
        ELSE
            Rec.SETFILTER("Lot No.", LotNoFilter);

        IF (MinDaysUntilExpirationFilter = 0) AND (MaxDaysUntilExpirationFilter = 0) THEN
            Rec.SETRANGE("Days until Expiration")
        ELSE BEGIN
            IF (MaxDaysUntilExpirationFilter <> 0) THEN
                Rec.SETRANGE("Days until Expiration", MinDaysUntilExpirationFilter, MaxDaysUntilExpirationFilter)
            ELSE
                Rec.SETFILTER("Days until Expiration", '>=%1', MinDaysUntilExpirationFilter);
        END;

        IF ((MinDaysOldFilter = 0) AND (MaxDaysOldFilter = 0)) THEN
            Rec.SETRANGE("Age (days)")
        ELSE BEGIN
            IF (MaxDaysOldFilter <> 0) THEN
                Rec.SETRANGE("Age (days)", MinDaysOldFilter, MaxDaysOldFilter)
            ELSE
                Rec.SETFILTER("Age (days)", '>=%1', MinDaysOldFilter);
        END;

        IF (ProdDateFilterStart <> 0D) THEN
            IF (ProdDateFilterEnd <> 0D) THEN
                Rec.SETRANGE("Creation Date", ProdDateFilterStart, ProdDateFilterEnd)
            ELSE
                Rec.SETFILTER("Creation Date", '>=%1', ProdDateFilterStart)
        ELSE
            IF (ProdDateFilterEnd <> 0D) THEN
                Rec.SETFILTER("Creation Date", '<=%1', ProdDateFilterEnd)
            ELSE
                Rec.SETRANGE("Creation Date");

        IF Rec.GETFILTERS = '' THEN BEGIN
            ItemFilter := '';
            Rec.SETRANGE("Item No.", ItemFilter);
        END;
    end;

    procedure GetFilterFields()
    begin
        InspectionStatusFilter := Rec.GETFILTER("Inspection Status");
        ItemCategoryFilter := Rec.GETFILTER("Item Category Code");
        ItemFilter := Rec.GETFILTER("Item No.");
        LotNoFilter := Rec.GETFILTER("Lot No.");
    end;

    procedure CreateQCRegistration()
    var
        RegistrationHeader: Record "WDC-QA Registration Header";
        QCRegistrationType: Option " ",Lot,Filter;
    begin
        QCRegistrationType := STRMENU(Text010, 1);
        IF QCRegistrationType = 0 THEN
            EXIT;
        CASE QCRegistrationType OF
            QCRegistrationType::Lot:
                BEGIN
                    RegistrationHeader.SETCURRENTKEY("Lot No.", "Item No.", "Variant Code");
                    RegistrationHeader.SETRANGE("Lot No.", Rec."Lot No.");
                    RegistrationHeader.SETRANGE("Item No.", Rec."Item No.");
                    RegistrationHeader.SETRANGE("Variant Code", Rec."Variant Code");
                    RegistrationHeader.SETRANGE("Document Type", RegistrationHeader."Document Type"::QC);
                    RegistrationHeader.SETRANGE(Status, RegistrationHeader.Status::Open);
                    IF RegistrationHeader.FINDFIRST THEN
                        IF CONFIRM(Text009, TRUE, RegistrationHeader."Document Type", RegistrationHeader."No.") THEN BEGIN
                            PAGE.RUN(PAGE::"WDC-QA QC Registration", RegistrationHeader);
                            EXIT;
                        END;

                    RegistrationHeader.INIT;
                    RegistrationHeader."Document Type" := RegistrationHeader."Document Type"::QC;
                    RegistrationHeader."No." := '';
                    RegistrationHeader.INSERT(TRUE);

                    RegistrationHeader.VALIDATE("Item No.", Rec."Item No.");
                    RegistrationHeader.VALIDATE("Lot No.", Rec."Lot No.");
                    RegistrationHeader."Variant Code" := Rec."Variant Code";
                    RegistrationHeader."Production Date" := Rec."Creation Date";
                    RegistrationHeader."Expiration Date" := Rec."Expiration Date";
                    RegistrationHeader."Warranty Date" := Rec."Warranty Date";
                    RegistrationHeader."Inspection Status" := Rec."Inspection Status";
                    RegistrationHeader.MODIFY;
                END;
            QCRegistrationType::Filter:
                BEGIN
                    RegistrationHeader.SETRANGE("Item No.", ItemFilter);
                    RegistrationHeader.SETRANGE("Lot No.", LotNoFilter);
                    RegistrationHeader.SETRANGE("Item Category Code", ItemCategoryFilter);
                    RegistrationHeader.SETRANGE("Inspection Status", InspectionStatusFilter);
                    RegistrationHeader.SETRANGE("Document Type", RegistrationHeader."Document Type"::QC);
                    RegistrationHeader.SETRANGE(Status, RegistrationHeader.Status::Open);
                    IF RegistrationHeader.FINDFIRST THEN
                        IF CONFIRM(Text009, TRUE, RegistrationHeader."Document Type", RegistrationHeader."No.") THEN BEGIN
                            PAGE.RUN(PAGE::"WDC-QA QC Registration", RegistrationHeader);
                            EXIT;
                        END;

                    RegistrationHeader.INIT;
                    RegistrationHeader."Document Type" := RegistrationHeader."Document Type"::QC;
                    RegistrationHeader."No." := '';
                    RegistrationHeader.INSERT(TRUE);
                    RegistrationHeader."Item No." := ItemFilter;
                    RegistrationHeader."Lot No." := LotNoFilter;
                    RegistrationHeader."Item Category Code" := ItemCategoryFilter;
                    RegistrationHeader."Inspection Status" := InspectionStatusFilter;
                    RegistrationHeader.MODIFY;
                END;
        END;

        PAGE.RUN(PAGE::"WDC-QA QC Registration", RegistrationHeader);
    end;

    procedure SetSourceValues(SourceTypeIN: Option " ","Reg. Header"; SourceSubTypeIN: Option "0","1","2","3","4","5","6","7","8","9","10"; SourceNoIN: Code[20])
    begin
        SourceType := SourceTypeIN;
        SourceSubType := SourceSubTypeIN;
        SourceNo := SourceNoIN;
    end;

    procedure ShowRec(): Boolean
    begin
        Rec.CALCFIELDS(Inventory, "Qty. on Purch. Order", "Qty. on Prod. Order");
        IF (Rec.Inventory + Rec."Qty. on Purch. Order" + Rec."Qty. on Prod. Order") <= 0 THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    LOCAL procedure ItemFilterOnAfterValidate()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure QCFilterOnAfterValidate()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure ItemCategoryFilterOnAfterValid()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure InspectionStatusFilterOnAfterV()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure MinDaysOldFilterOnAfterValidat()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure MaxDaysOldFilterOnAfterValidat()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure MinDaysUntilExpirationFilterOn()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure MaxDaysUntilExpirationFilterOn()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure ProdDateFilterStartOnAfterVali()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure ProdDateFilterEndOnAfterValida()
    begin
        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    LOCAL procedure LotNoFilterOnAfterValidate()
    begin
        IF ((LotNoFilter <> '') AND (ItemFilter = '')) THEN BEGIN
            LotNoInformation.SETRANGE("Lot No.", LotNoFilter);
            IF LotNoInformation.FINDFIRST THEN
                ItemFilter := LotNoInformation."Item No.";
        END;

        SetFilters;
        CurrPage.UPDATE(FALSE);
    end;

    procedure CreateSubLot()
    begin
        Rec.TESTFIELD("Item No.");
        LotNoInformation.GET(Rec."Item No.", Rec."Variant Code", Rec."Lot No.");
        LotNoInformation.SETRECFILTER;
        //IF PAGE.RUNMODAL(PAGE::"Create Sub Lot", LotNoInformation) = ACTION::LookupOK THEN;
    end;

    var
        ItemFilter: Code[20];
        ItemCategoryFilter: Code[20];
        LotNoFilter: Code[20];
        InspectionStatusFilter: Code[20];
        QCFilter: Option " ",Yes,No;
        NCType: Option Customer,Vendor,"Internal";
        MinDaysUntilExpirationFilter: Integer;
        MaxDaysUntilExpirationFilter: Integer;
        MinDaysOldFilter: Integer;
        MaxDaysOldFilter: Integer;
        Selection: Integer;
        ProdDateFilterStart: Date;
        ProdDateFilterEnd: Date;
        SourceType: Option " ","Reg. Header";
        SourceSubType: Option "0","1","2","3","4","5","6","7","8","9","10";
        SourceNo: Code[20];
        LotNoInformation: Record "Lot No. Information";
        Text001: TextConst ENU = '&Customer,&Vendor, &Internal', FRA = '&Client,&Fournisseur, &Interne';
        Text002: TextConst ENU = 'Non Conformance ', FRA = 'Non conformité';
        Text003: TextConst ENU = 'has already been created for this item/lotnumber\Do you want to open this NC?', FRA = 'a déjà été créé pour cet article/numéro lot\Voulez-vous ouvrir cette NC ?';
        Text009: TextConst ENU = '%1-Registration No. %2 has already been created for this item/lotnumber/variant.\\Do you want to open this %1-Registration?', FRA = '%1-N° enregistrement %2 a déjà été créé pour cet article/numéro lot/variante.\\Voulez-vous ouvrir cet %1-enregistrement?';
        Text010: TextConst ENU = 'Lot,Filter', FRA = 'Lot,Filtre';
}
