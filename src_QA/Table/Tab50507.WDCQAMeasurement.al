table 50507 "WDC-QA Measurement"
{
    CaptionML = ENU = 'Measurement', FRA = 'Mesure';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Measurement";
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
