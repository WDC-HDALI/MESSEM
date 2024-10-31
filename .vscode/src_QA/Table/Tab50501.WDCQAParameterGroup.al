table 50501 "WDC-QA Parameter Group"
{
    CaptionML = ENU = 'Parameter Group', FRA = 'Groupe de paramètres';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Parameter Group";
    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; "Order"; Integer)
        {
            CaptionML = ENU = 'Order', FRA = 'Ordre';
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
