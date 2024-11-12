table 50014 "WDC Harbor"
{

    CaptionML = ENU = 'Harbor', FRA = 'Port';
    DrillDownPageID = "WDC Harbor";
    LookupPageID = "WDC Harbor";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; City; Text[30])
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            TableRelation = "Post Code".City;
        }
        field(4; "Notify Party"; Code[20])
        {
            CaptionML = ENU = 'Notify Party', FRA = 'Partie à informer';
            TableRelation = "WDC Notify Party".Code WHERE(harbor = FIELD(Code));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

}



