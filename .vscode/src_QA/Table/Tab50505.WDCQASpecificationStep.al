table 50505 "WDC-QA Specification Step"
{
    CaptionML = ENU = 'Specification Step', FRA = 'Configuration spécification';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Specification Steps";
    DataCaptionFields = "Document No.", "Version No.", "Line No.";
    fields
    {
        field(1; "Document Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            ValuesAllowed = 0, 1;
        }
        field(2; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            TableRelation = "WDC-QA Specification Header"."No." WHERE("Document Type" = FIELD("Document Type"), "Version No." = FIELD("Version No."));
        }
        field(3; "Version No."; Code[20])
        {
            CaptionML = ENU = 'Version No.', FRA = 'N° version';
        }
        field(4; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
            TableRelation = "WDC-QA Specification Line"."Line No." WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Version No." = FIELD("Version No."));
            Editable = false;
        }
        field(5; "Step Line No."; Integer)
        {
            CaptionML = ENU = 'Step Line No.', FRA = 'N° ligne étappe';
        }
        field(6; "Method Line No."; Integer)
        {
            CaptionML = ENU = 'Method Line No.', FRA = 'N° ligne méthode';
        }
        field(7; "Column No."; Code[10])
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
            Editable = false;
        }
        field(8; "Measurement Code"; Code[10])
        {
            CaptionML = ENU = 'Measurement Code', FRA = 'Code mesure';
            Editable = false;
            TableRelation = "WDC-QA Measurement";
        }
        field(9; Description; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            Editable = false;
        }
        field(10; "Equipment Group"; Code[20])
        {
            CaptionML = ENU = 'Equipment Group', FRA = 'Code groupe équipement';
            TableRelation = "WDC-QA Equipment Group";
            trigger OnValidate()
            var
                CalibrationHeader: Record "WDC-QA Specification Header";
            begin
                CalibrationHeader.GET("Document Type", "Document No.", "Version No.");
                CalibrationHeader.TESTFIELD(Status, CalibrationHeader.Status::Open);
            end;
        }

        field(12; "Type Of Measure"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Type Of Measure', FRA = 'Type de mesure';
            Editable = false;
            ValuesAllowed = 1, 2;
        }
        field(13; "Value UOM"; Code[10])
        {
            CaptionML = ENU = 'Value UOM', FRA = 'Unité valeur';
            TableRelation = "Unit of Measure";
            Editable = false;

        }
        field(14; Sample; Boolean)
        {
            CaptionML = ENU = 'Sample', FRA = 'Échantillon';
            Editable = false;
        }
        field(15; "Method Remark"; Text[80])
        {
            CaptionML = ENU = 'Method Remark', FRA = 'Remarque méthode';
            Editable = false;
            NotBlank = false;
        }
        field(16; "Result Option"; Boolean)
        {
            CaptionML = ENU = 'Result Option', FRA = 'Option résultat';
            Editable = false;
        }
        field(17; "Method No."; Code[20])
        {
            CaptionML = ENU = 'Method No.', FRA = 'N° Méthode';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Version No.", "Line No.", "Step Line No.")
        {
            Clustered = true;
        }
    }
}
