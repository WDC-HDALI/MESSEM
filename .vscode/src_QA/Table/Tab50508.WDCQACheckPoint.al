table 50508 "WDC-QA Check Point"
{
    CaptionML = ENU = 'WDC-QA Check Point', FRA = 'Point de contrôle';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Check Points";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Déscription';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
