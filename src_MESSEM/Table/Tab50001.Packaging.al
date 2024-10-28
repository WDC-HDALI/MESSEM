table 50001 "WDC Packaging"
{
    CaptionML = ENU = 'Packaging', FRA = 'Emballage';
    DataClassification = ToBeClassified;
    LookupPageID = 50001;
    DrillDownPageId = 50001;
    PasteIsValid = true;

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionMl = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; TEXT[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; "Surface (m2)"; Decimal)
        {
            CaptionML = ENU = 'Surface (m2)', FRA = 'Surface (m2)';
        }
        field(4; "Volume (m3)"; Decimal)
        {
            CaptionML = ENU = 'Volume (m3)', FRA = 'Volume (m3)';
        }
        field(5; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
        }
        field(7; Weight; Decimal)
        {
            CaptionML = ENU = 'Weight', FRA = 'Poids';
        }
        field(8; "Group"; Code[20])
        {
            CaptionML = ENU = 'Group', FRA = 'Groupe';
            TableRelation = "WDC Packaging Group" WHERE(Type = FIELD(Type));
        }
        field(10; "Register Balance"; Boolean)
        {
            CaptionML = ENU = 'Register Balance', FRA = 'Enregistrer solde';
            Editable = True;

        }
        field(11; "type"; Enum "WDC Packaging Type")

        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(12; "Calculate Entsorgung"; Boolean)
        {
            CaptionML = ENU = 'Calculate Entsorgung', FRA = 'Usage unique';
        }
        field(13; "SSCC Label"; Boolean)
        {
            CaptionML = ENU = 'SSCC Label', FRA = 'Etiquette SSCC';
        }
        field(14; "Type in EDI"; Code[20])
        {
            CaptionML = ENU = 'Type in EDI', FRA = 'Type en EDI';
        }
        field(15; "GRAI Box"; Boolean)
        {
            CaptionML = ENU = 'GRAI Box', FRA = 'Emballage GRAI';
        }
        field(16; "Description 2"; TEXT[100])
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
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
