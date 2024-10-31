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
        field(50512; "Qty Shipm.Units per Shipm.Cont"; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipment Units per Shipment Container', FRA = 'Qté d''unités d''expédition par support logistique';
            InitValue = 1;
            MinValue = 0;
            Editable = false;
        }
        field(50513; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
            TableRelation = "Item Category";
        }
        field(50514; "Days until Expiration"; Decimal)
        {
            CaptionML = ENU = 'Period until Sales Expiration date (days)', FRA = 'Période pour vente (jours)';
            Editable = false;
        }
        field(50515; "Age (days)"; Decimal)
        {
            CaptionML = ENU = 'Age (days)', FRA = 'Age (jours)';
            Editable = false;
        }
        field(50516; "Qty. on Purch. Order"; Decimal)
        {
            CaptionML = ENU = 'Qty. on Purch. Order', FRA = 'Qté sur commande achat';
            FieldClass = FlowField;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"), "Lot No." = FIELD("Lot No."), "Source Type" = CONST(39), "Source Subtype" = CONST(1), "Location Code" = FIELD("Location Filter")));
            Editable = false;
        }
        field(50517; "Qty. on Prod. Order"; Decimal)
        {
            CaptionML = ENU = 'Qty. on Prod. Order', FRA = 'Qté sur ordre fabrication';
            FieldClass = FlowField;
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code"), "Lot No." = FIELD("Lot No."), "Source Type" = CONST(5406), "Source Subtype" = FILTER(1 .. 3), "Location Code" = FIELD("Location Filter")));
            Editable = false;
        }
    }
    procedure GetParentLotNo(): Code[20]
    var
    //SubLot:Record SubLot;
    begin
        // SubLot.SETFILTER("Sub Lot No.", "Lot No.");
        // IF SubLot.FIND('-') THEN
        //     EXIT(SubLot."Lot No.")
        // ELSE
        //     EXIT;
    end;
}
