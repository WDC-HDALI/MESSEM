tableextension 50013 "WDC Purchase Header " extends "Purchase Header"
{
    fields
    {
        field(50000; "Farm"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WDC Farm".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            CaptionML = ENU = 'Farm No.', FRA = 'N° ferme';
        }
        field(50001; "Parcel No."; TEXT[100])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';

        }
        // field(50020; "No. of Shipment Units"; Decimal)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Purchase Line"."Quantity Shipment Units" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                        "Document No." = FIELD("No."), "No." = field("Item No. Filter")));

        //     captionml = ENU = 'No. of Shipment Units', FRA = 'Nombre d''unités d''expédition';
        //     DecimalPlaces = 0 : 0;

        // }
        // field(50021; "No. of Shipment Containers"; Decimal)
        // {
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = Sum("Purchase Line"."Quantity Shipment Containers" WHERE("Document Type" = FIELD("Document Type"),
        //                                                                             "Document No." = FIELD("No."), "No." = field("Item No. Filter")));
        //     captionml = ENU = 'No. of Shipment Containers', FRA = 'Nbre de support logistique';
        //     DecimalPlaces = 0 : 0;

        // }
        field(50022; "Pick up City"; Text[30])
        {
            CaptionML = ENU = 'Pick up City', FRA = 'Ville chargement';
            Editable = false;

        }

        field(50023; "Pick up Post Code"; Code[20])
        {
            CaptionML = ENU = 'Pick up Post Code', FRA = 'CP enlèvement';
            NotBlank = true;
            TableRelation = "Post Code";
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookUpPostCode("Pick up City", "Pick up Post Code", DummyTxt, DummyCode, TRUE);

                IF ("Pick up Post Code" <> xRec."Pick up Post Code") OR
                   ("Pick up City" <> xRec."Pick up City") THEN
                    UpdatePurchLines(FIELDCAPTION("Pick up Post Code"), CurrFieldNo <> 0);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Pick up City", "Pick up Post Code", DummyTxt, DummyCode, CurrFieldNo = FIELDNO("Pick up Post Code"));

                IF ("Pick up Post Code" <> xRec."Pick up Post Code") OR
                   ("Pick up City" <> xRec."Pick up City") THEN
                    UpdatePurchLines(FIELDCAPTION("Pick up Post Code"), CurrFieldNo <> 0);
                //
            end;
        }
        field(50024; "Item No. Filter"; Code[20])
        {
            Caption = 'Item No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                vend: record vendor;

            begin
                vend.get("Buy-from Vendor No.");
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    "Pick up Post Code" := Vend."Post Code";
                    "Pick up City" := Vend.City;
                END;
            end;
        }





    }
    var
        PostCode: record "Post Code";
        DummyTxt: text[100];
        DummyCode: code[100];

}
