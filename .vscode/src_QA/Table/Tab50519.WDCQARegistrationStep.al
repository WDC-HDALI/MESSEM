table 50519 "WDC-QA Registration Step"
{
    CaptionML = ENU = 'Registration Step', FRA = 'Configuration enregistrement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
        }
        field(2; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            TableRelation = "WDC-QA Registration Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
            TableRelation = "WDC-QA Registration Line"."Line No." WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."));
        }
        field(4; "Step Line No."; Integer)
        {
            CaptionML = ENU = 'Step Line No.', FRA = 'N° ligne étappe';
        }
        field(5; "Method No."; Code[20])
        {
            CaptionML = ENU = 'Method No.', FRA = 'N° Méthode';
        }
        field(6; "Method Line No."; Integer)
        {
            CaptionML = ENU = 'Method Line No.', FRA = 'N° ligne méthode';
        }
        field(7; "Column No."; Code[20])
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
            Editable = false;
        }
        field(8; "Measure No."; Integer)
        {
            CaptionML = ENU = 'Measure No.', FRA = 'N° mesure';
            Editable = false;
        }
        field(9; "Equipment Group Code"; Code[20])
        {
            CaptionML = ENU = 'Equipment Group Code', FRA = 'Code groupe équipement';
            TableRelation = "WDC-QA Equipment Group";
            Editable = false;
        }
        field(11; "Type of Measure"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Type of Measure', FRA = 'Type de mesure';
            Editable = false;
            ValuesAllowed = 1, 2;
        }
        field(12; "Value UOM"; Code[20])
        {
            CaptionML = ENU = 'Value UOM', FRA = 'Unité valeur';
            TableRelation = "Unit of Measure";
            Editable = false;
        }
        field(13; Sample; Boolean)
        {
            CaptionML = ENU = 'Sample', FRA = 'Échantillon';
            Editable = false;
        }
        field(14; "Method Remark"; Text[80])
        {
            CaptionML = ENU = 'Method Remark', FRA = 'Remarque méthode';
            Editable = false;
        }
        field(15; "Value Measured"; Decimal)
        {
            CaptionML = ENU = 'Value Measured', FRA = 'Valeur mesuré';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                Modified := TRUE;
            end;
        }
        field(16; "Option Measured"; Enum "WDC-QA RegistratResultOption")
        {
            CaptionML = ENU = 'Option Measured', FRA = 'Option mesuré';
            trigger OnValidate()
            begin
                Modified := TRUE;
            end;
        }
        field(17; "Result Option"; Boolean)
        {
            CaptionML = ENU = 'Result Option', FRA = 'Option résultat';
            Editable = false;
        }
        field(18; "Measurement Code"; Code[20])
        {
            CaptionML = ENU = 'Measurement Code', FRA = 'Code mesure';
            TableRelation = "WDC-QA Measurement";
            Editable = false;
        }
        field(19; "Measurement Description"; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            Editable = false;
        }
        field(20; Modified; Boolean)
        {
            CaptionML = ENU = 'Modified', FRA = 'Modifié';
        }
        field(21; "Is Second Sampling"; Boolean)
        {
            CaptionML = ENU = 'Is Second Sampling', FRA = 'Is Second Sampling';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.", "Step Line No.")
        {
            Clustered = true;
        }
    }
}
