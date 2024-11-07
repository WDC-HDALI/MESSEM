table 50007 "WDC Lot Attribute Value"
{
    CaptionML = ENU = 'Lot Attribute Value', FRA = 'Valeur Lot Attribue';
    DataCaptionFields = "Code";
    LookupPageID = "WDC Lot Attribute Values";

    fields
    {
        field(1; "Lot Attribute No."; Enum "WDC Lot Attribute")
        {
            CaptionML = ENU = 'Lot Attribute No.', FRA = 'Lot Attribue No.';
            NotBlank = true;
        }
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
    }

    keys
    {
        key(Key1; "Lot Attribute No.", "Code")
        {
            Clustered = true;
        }
    }
}

