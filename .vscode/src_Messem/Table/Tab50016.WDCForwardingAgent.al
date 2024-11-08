table 50016 "WDC Forwarding Agent"
{
    CaptionML = ENU = 'Forwarding Agent', FRA = 'Transitaire';
    DataClassification = ToBeClassified;
    DrillDownPageID = "WDC Forwarding Agent";
    LookupPageID = "WDC Forwarding Agent";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; "Agent Name"; Text[30])
        {
            CaptionML = ENU = '=Agent Name', FRA = 'Nom transitaire';
        }
        field(3; Adress; Text[50])
        {
            CaptionML = ENU = 'Adress', FRA = 'Adresse';
        }
        field(4; "Phone No."; Text[30])
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone', NLD = 'Telefoon';
            ExtendedDatatype = None;
        }
        field(5; "Mobile No."; Text[30])
        {
            CaptionML = ENU = 'Mobile No.', FRA = 'N° portable';
            ExtendedDatatype = None;
        }
        field(6; "E-mail"; Text[50])
        {
            CaptionML = ENU = 'E-mail', FRA = 'E-mail';
            ExtendedDatatype = None;
        }
        field(7; City; Text[30])
        {
            CaptionML = ENU = 'City', FRA = 'Ville';
            TableRelation = "Post Code".City;
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
