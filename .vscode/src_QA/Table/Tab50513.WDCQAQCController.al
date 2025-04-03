table 50513 "WDC-QA QC Controller"
{
    CaptionML = ENU = 'QC Controller', FRA = 'Contrôlleur CQ';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA QC Controllers";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
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
