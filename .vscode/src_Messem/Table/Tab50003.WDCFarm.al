table 50003 "WDC Farm"
{

    CaptionML = ENU = 'Farm', FRA = 'Ferme';
    DrillDownPageID = 50000;
    LookupPageID = 50000;

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            TableRelation = Vendor;
        }
        field(3; "Farm No."; Code[20])
        {
            CaptionML = ENU = '=Farm No.', FRA = 'N° ferme';
        }
        field(4; "Parcel No."; Code[20])
        {
            CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';
        }
        field(5; "Désignation"; Text[100])
        {
            captionml = ENU = 'Description', FRA = 'Désignation';
        }
    }

    keys
    {
        key(Key1; "Code", "Vendor No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

