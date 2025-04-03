table 50514 "WDC-QA Variety"
{
    CaptionML = ENU = 'Variety', FRA = 'Variété';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Variety";
    fields
    {
        field(1; Variety; Code[30])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
        }
    }
    keys
    {
        key(PK; Variety)
        {
            Clustered = true;
        }
    }
}
