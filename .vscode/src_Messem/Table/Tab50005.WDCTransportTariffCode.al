table 50005 "WDC Transport Tariff Code"
{
    Caption = 'Transport Tariff Code';
    LookupPageID = "WDC Transport Tariff Codes";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; "Transport Rate per"; Enum "WDC Transport Rate per Code")
        {
            Caption = 'Transport Rate per';
        }
        field(4; "Sales Cost Transport Rate 1"; Decimal)
        {
            Caption = 'Sales Cost Transport Rate 1';
            DecimalPlaces = 0 : 5;
        }
        field(5; "Sales Cost Transport Rate 2"; Decimal)
        {
            Caption = 'Sales Cost Transport Rate 2';
            DecimalPlaces = 0 : 5;
        }
        field(6; "Sales Cost Transport Rate 3"; Decimal)
        {
            Caption = 'Sales Cost Transport Rate 3';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

