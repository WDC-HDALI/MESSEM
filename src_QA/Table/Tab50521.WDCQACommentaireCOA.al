table 50521 "WDC-QA Commentaire COA"
{
    Caption = 'WDC-QA Commentaire COA';
    DataClassification = ToBeClassified;
    //LookupPageId="Commentaire COA";

    fields
    {
        field(1; "Commentaire COA"; Text[50])
        {
            CaptionML = ENU = 'Commentaire COA', FRA = 'Commentaire COA';
        }
    }
    keys
    {
        key(PK; "Commentaire COA")
        {
            Clustered = true;
        }
    }
}
