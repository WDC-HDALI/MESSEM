table 50012 "WDC Item Rebate Group"
{

    Caption = 'Item Rebate Group';
    LookupPageID = "WDC Item Rebate Groups";

    fields
    {
        field(1; Type; enum "WDC Code Rebate type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(3; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

