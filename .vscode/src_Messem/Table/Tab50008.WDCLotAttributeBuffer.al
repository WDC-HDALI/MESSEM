table 50008 "WDC Lot Attribute Buffer"
{

    Caption = 'Lot Attribute Buffer';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'No. Article';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Variant Code"; code[20])
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variant';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(3; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'No. Lot';
            NotBlank = true;
        }
        field(4; "Source Type"; Integer)
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
        }
        field(5; "Source Subtype"; Enum "WDC Lot Attribute Src Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';

        }
        field(6; "Source ID"; Code[20])
        {
            CaptionML = ENU = 'Source ID', FRA = 'ID origine';
        }
        field(7; "Source Batch Name"; Code[20])
        {
            CaptionML = ENU = 'Source Batch Name', FRA = 'Nom feuille origine';
        }
        field(8; "Source Prod. Order Line"; Integer)
        {
            CaptionML = ENU = 'Source Prod. Order Line', FRA = 'Ligne O.F. origine';
        }
        field(9; "Source Ref. No."; Integer)
        {
            CaptionML = ENU = 'Source Ref. No.', FRA = 'N° réf. origine';
        }
        field(10; "Lot Attribute 1"; code[20])
        {
            CaptionClass = '13,1,1';
            Caption = 'Lot Attribute 1';
            TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"1"));
        }
        field(11; "Lot Attribute 2"; code[20])
        {
            CaptionClass = '13,1,2';
            Caption = 'Lot Attribute 2';
            TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"2"));
        }
        field(12; "Lot Attribute 3"; code[20])
        {
            CaptionClass = '13,1,3';
            Caption = 'Lot Attribute 3';
            TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"3"));
        }
        field(13; "Lot Attribute 4"; code[20])
        {
            CaptionClass = '13,1,4';
            Caption = 'Lot Attribute 4';
            TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"4"));
        }
        field(14; "Lot Attribute 5"; code[20])
        {
            CaptionClass = '13,1,5';
            Caption = 'Lot Attribute 5';
            TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"5"));
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Lot No.", "Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.")
        {
            Clustered = true;
        }
    }


}

