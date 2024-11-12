table 50012 "WDC Item Rebate Group"
{

    Caption = 'Item Rebate Group';
    LookupPageID = "WDC Item Rebate Groups";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
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

