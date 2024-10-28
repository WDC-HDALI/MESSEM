tableextension 50511 "WDC-QA Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(50500; QC; Boolean)
        {
            CaptionML = ENU = 'QC', FRA = 'CQ';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50501; "Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'Inspection Status', FRA = 'Statut d''inspection';
            DataClassification = ToBeClassified;
            TableRelation = "WDC-QA Inspection Status";
            Editable = false;
            trigger OnValidate()
            var
                InspectionStatus: Record "WDC-QA Inspection Status";
            begin
                IF InspectionStatus.GET("Inspection Status") THEN
                    QC := InspectionStatus.QC;
            end;
        }
        field(50502; "Vendor Lot No."; Code[20])
        {
            CaptionML = ENU = 'Vendor Lot No.', FRA = 'N° lot fournisseur';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        // field(50503; "Item Category Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        //     TableRelation = "Item Category";
        // }
        field(50504; "Next Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'Next Inspection Status', FRA = 'Statut d''inspection suivant';
            TableRelation = "WDC-QA Inspection Status";
        }
        field(50505; "Date Second Inspection Status"; Date)
        {
            CaptionML = ENU = 'Date Next Inspection Status', FRA = 'Date statut d''inspection suivant';
            Editable = false;
        }
        field(50506; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''éxpiration';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                //IF "Expiration Date" <> 0D THEN
                //"Days until Expiration" := "Expiration Date" - WORKDATE;

                // IF Item.GET("Item No.") THEN
                // IF (FORMAT(Item."Maximum BBD Sales") <> '') AND ("Expiration Date" <> 0D) THEN BEGIN
                //     "Maximum BBD Sales (days)" := CALCDATE(FORMAT(Item."Maximum BBD Sales"), WORKDATE()) - WORKDATE();
                //     VALIDATE("Sales Expiration date", CALCDATE('-' + FORMAT(Item."Maximum BBD Sales"), "Expiration Date"));
                // END;
            end;
        }
        field(50507; "Warranty Date"; Date)
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                IF "Warranty Date" > xRec."Warranty Date" THEN
                    "Warranty Passed" := FALSE;
            end;
        }
        field(50508; "Warranty Passed"; Boolean)
        {
            CaptionML = ENU = 'Warranty Passed', FRA = 'Garantie passée';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50509; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
            DataClassification = ToBeClassified;
        }
        field(50510; "Buy-from Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(50511; "Date Last QC"; Date)
        {
            CaptionML = ENU = 'Date Last QC', FRA = 'Date dernier CQ';
            Editable = false;
        }

    }
}
