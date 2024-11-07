table 50002 "WDC Packaging Group"
{
    CaptionML = ENU = 'Packaging Group', FRA = 'Groupes emballage';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; "Type"; Enum "WDC Packaging Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
    }
    keys
    {
        key(PK; "code")
        {
            Clustered = true;
        }
    }
}
