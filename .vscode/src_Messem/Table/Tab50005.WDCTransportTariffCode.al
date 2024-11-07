table 50005 "WDC Transport Tariff Code"
{
    CaptionML = ENU = 'Transport Tariff Code', FRA = 'Code tarif transport';
    ;
    LookupPageID = "WDC Transport Tariff Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        field(3; "Transport Rate per"; Enum "WDC Transport Rate per Code")
        {
            CaptionML = ENU = 'Transport Rate per', FRA = 'Tarif transport par';
        }
        field(4; "Sales Cost Transport Rate 1"; Decimal)
        {
            CaptionML = ENU = 'Sales Cost Transport Rate 1', FRA = 'Coût de ventes Tarif transport 1';
            DecimalPlaces = 0 : 5;
        }
        field(5; "Sales Cost Transport Rate 2"; Decimal)
        {
            CaptionML = ENU = 'Sales Cost Transport Rate 2', FRA = 'Coût de ventes Tarif transport 2';
            DecimalPlaces = 0 : 5;
        }
        field(6; "Sales Cost Transport Rate 3"; Decimal)
        {
            CaptionML = ENU = 'Sales Cost Transport Rate 3', FRA = 'Coût de ventes Tarif transport 3';
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

