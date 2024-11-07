table 50015 "WDC Notify Party"
{

    Caption = 'Notify Party';
    DrillDownPageID = "WDC Notify Party";
    LookupPageID = "WDC Notify Party";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; harbor; Code[20])
        {
            CaptionML = ENU = 'Harbor', FRA = 'Port';
            TableRelation = "WDC Harbor";
        }
        field(3; "Désignation"; Text[30])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(4; Adress; Text[50])
        {
            CaptionML = ENU = 'Adress', FRA = 'Adresse';
        }
        field(5; "Phone No."; Text[30])
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
            ExtendedDatatype = None;
        }
        field(6; "Mobile No."; Text[30])
        {
            CaptionML = ENU = 'Mobile No', FRA = 'N° portable';
            ExtendedDatatype = None;
        }
        field(7; "E-mail"; Text[50])
        {
            CaptionML = ENU = 'E-mail', FRA = 'E-mail';
            ExtendedDatatype = None;
        }
        field(8; City; Text[30])
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            TableRelation = "Post Code".City;
        }
        field(9; "Country/Region Code"; Code[10])
        {
            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région', NLD = 'Land-/regiocode';
            TableRelation = "Country/Region";
        }
        field(10; "Primary Contact No."; Code[20])
        {
            CaptionML = ENU = 'Primary Contact No.', FRA = 'N° contact principal', NLD = 'Nr. primair contact';
            TableRelation = Contact."No.";

        }
    }

    keys
    {
        key(Key1; "Code", harbor)
        {
            Clustered = true;
        }
    }
}

