table 50008 "WDC Lot Attribute Buffer"
{

    Caption = 'Lot Attribute Buffer';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Variant Code"; code[20])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(3; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            NotBlank = true;
        }
        field(4; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(5; "Source Subtype"; Enum "WDC Lot Attribute Src Subtype")
        {
            Caption = 'Source Subtype';

        }
        field(6; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
        }
        field(7; "Source Batch Name"; Code[20])
        {
            Caption = 'Source Batch Name';
        }
        field(8; "Source Prod. Order Line"; Integer)
        {
            Caption = 'Source Prod. Order Line';
        }
        field(9; "Source Ref. No."; Integer)
        {
            Caption = 'Source Ref. No.';
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

    fieldgroups
    {
    }
}

