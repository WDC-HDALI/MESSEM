table 50506 "WDC-QA Equipment Group"
{
    CaptionML = ENU = 'Equipment Group', FRA = 'Groupe équipement';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Equipment Groups";
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
