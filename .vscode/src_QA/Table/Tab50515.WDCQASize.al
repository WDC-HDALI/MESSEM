table 50515 "WDC-QA Size"
{
    CaptionML = ENU = 'Size', FRA = 'Calibre';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Size";

    fields
    {
        field(1; Size; Text[30])
        {
            CaptionML = ENU = 'Size', FRA = 'Calibre';
        }
    }
    keys
    {
        key(PK; Size)
        {
            Clustered = true;
        }
    }
}
