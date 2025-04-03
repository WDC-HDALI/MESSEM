table 50523 "WDC-QARegistration Line Copy"
{
    CaptionML = ENU = 'Registration Line', FRA = 'Ligne enregistrement';
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
        }
        field(4; "Parameter Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Code', FRA = 'Code paramètre';
            TableRelation = IF ("Document Type" = CONST(Calibration)) "WDC-QA Parameter".Code WHERE(Type = CONST(Calibration))
            ELSE IF ("Document Type" = CONST(QC)) "WDC-QA Parameter".Code WHERE(Type = filter('QC-specification'))
            ELSE IF ("Document Type" = CONST(CoA), Type = CONST(Parameter)) "WDC-QA Parameter".Code WHERE(Type = filter('QC-specification'));
        }
        field(5; "Parameter Description"; Text[50])
        {
            CaptionML = ENU = 'Parameter Description', FRA = 'Déscription paramètre';
            Editable = false;
        }
        field(6; "Parameter Group Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Group Code', FRA = 'Code groupe paramètre';
            Editable = false;
            TableRelation = "WDC-QA Parameter Group";
        }
        field(7; "Method No."; Code[20])
        {
            CaptionML = ENU = 'Method No.', FRA = 'Code méthode';
            TableRelation = "WDC-QA Method Header";
        }
        field(8; "Method Description"; Text[100])
        {
            CaptionML = ENU = 'Method Description', FRA = 'Déscription méthode';
            Editable = false;
        }
        field(9; "Specification Remark"; Text[80])
        {
            CaptionML = ENU = 'Specification Remark', FRA = 'Remarque spécification';
        }
        field(10; "Measure No."; Integer)
        {
            CaptionML = ENU = 'Measure No.', FRA = 'N° mesure';
        }
        field(11; "Sample Quantity"; Decimal)
        {
            CaptionML = ENU = 'Sample Quantity', FRA = 'Quantité échantillon';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(12; "Sample UOM"; Code[20])
        {
            CaptionML = ENU = 'Sample UOM', FRA = 'Unité  échantillon';
            Editable = false;
        }
        field(13; "Lower Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Limit', FRA = 'Limite inférieure';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Lower Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Warning Limit', FRA = 'Limite d''avertissement inférieure';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Target Result value"; Decimal)
        {
            CaptionML = ENU = 'Target Result value', FRA = 'Valeur résultat cible';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Upper Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Warning Limit', FRA = 'Limite d''avertissement supérieure';
            DecimalPlaces = 0 : 5;
        }
        field(17; "Upper Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Limit', FRA = 'Limite supérieure';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Result Option"; Enum "WDC-QA Result Option")
        {
            CaptionML = ENU = 'Result Option', FRA = 'Option résultat';
        }
        field(19; "Average Result Option"; Enum "WDC-QA RegistratResultOption")
        {
            CaptionML = ENU = 'Average Result Option', FRA = 'Option résultat moyen';
            Editable = false;
        }
        field(20; "Result Value"; Decimal)
        {
            CaptionML = ENU = 'Result Value', FRA = 'Valeur résultat';
            DecimalPlaces = 0 : 5;
        }
        field(21; "Result Value UOM"; Code[20])
        {
            CaptionML = ENU = 'Result Value UOM', FRA = 'Unité valeur résultat';
            Editable = false;
        }
        field(22; "Average Result Value"; Decimal)
        {
            CaptionML = ENU = 'Average Result Value', FRA = 'Valeur résultat moyen';
            DecimalPlaces = 0 : 5;
        }
        field(23; "Conclusion Result"; Enum "WDC-QA Conclusion Result")
        {
            CaptionML = ENU = 'Conclusion Result', FRA = 'Conclusion résultat';
            Editable = false;
        }
        field(24; "Conclusion Average Result"; Enum "WDC-QA Conclusion Result")
        {
            CaptionML = ENU = 'Conclusion Average Result', FRA = 'Conclusion résultat moyen';
            Editable = false;
        }
        field(25; "QC Date"; Date)
        {
            CaptionML = ENU = 'QC Date', FRA = 'Date CQ';
        }
        field(26; "QC Time"; Time)
        {
            CaptionML = ENU = 'QC Time', FRA = 'Heure CQ';
        }
        field(27; "Sample Temperature"; Decimal)
        {
            CaptionML = ENU = 'Sample Temperature', FRA = 'Température échantillon';
            DecimalPlaces = 0 : 5;
        }
        field(28; "Controller"; Code[20])
        {
            CaptionML = ENU = 'Controller', FRA = 'Controleur';
            TableRelation = "WDC-QA QC Controller";
        }
        field(29; "Specification Line No."; Integer)
        {
            CaptionML = ENU = 'Specification Line No.', FRA = 'N° ligne spécification';
        }
        field(30; "Specification No."; Code[20])
        {
            CaptionML = ENU = 'Specification No.', FRA = 'N° spécification';
            TableRelation = "WDC-QA Specification Header"."No." WHERE("Document Type" = FIELD("Specification Type"), "Version No." = FIELD("Specification Version No."));
        }
        field(31; "Specification Version No."; Code[20])
        {
            CaptionML = ENU = 'Specification Version No.', FRA = 'N° version spécification';
            Editable = false;
        }
        field(32; "Target Result Option"; Enum "WDC-QA Result Option")
        {
            CaptionML = ENU = 'Target Result Option', FRA = 'Option résultat cible';
        }
        field(33; "Type of Result"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Type of Result', FRA = 'Type de résultat';
        }
        field(34; "Formula"; Code[80])
        {
            CaptionML = ENU = 'Formula', FRA = 'Formule';
            Editable = false;
        }
        field(35; "Specification Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Specification Type', FRA = 'Type spécificaton';
            ValuesAllowed = 0, 1;
        }
        field(36; "Item No. EP"; Code[20])
        {
            CaptionML = ENU = 'Item No. EP', FRA = 'N° article PF';
            TableRelation = Item;
        }
        field(37; "Lot No. EP"; Code[20])
        {
            CaptionML = ENU = 'Lot No. EP', FRA = 'N° lot PF';
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(38; "Item No. HF"; Code[20])
        {
            CaptionML = ENU = 'Item No. HF', FRA = 'N° article PSF';
            TableRelation = Item;
            Editable = false;
        }
        field(39; "Lot No. HF"; Code[20])
        {
            CaptionML = ENU = 'Lot No. HF', FRA = 'N° lot PSF';
            TableRelation = "Lot No. Information"."Lot No.";
            Editable = false;
        }
        field(40; "Check Point Code"; Code[20])
        {
            CaptionML = ENU = 'Check Point Code', FRA = 'Code point de contrôle';
            TableRelation = "WDC-QA Check Point";
        }
        field(41; Type; Enum "WDC-QA Registration Line Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(42; "Text Description"; Text[80])
        {
            CaptionML = ENU = 'Text Description', FRA = 'Description texte';
        }
        field(43; "CoA Type Value"; Enum "WDC-QA CoA Type Value")
        {
            CaptionML = ENU = 'CoA Type Value', FRA = 'Type Valeur Certificat d''analyse';
            Editable = false;
        }
        field(44; "Date CQ"; Date)
        {
            CaptionML = ENU = 'QC Date', FRA = 'Date CQ';
            FieldClass = FlowField;
            CalcFormula = Lookup("WDC-QA Registration Header"."QC Date" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("Document No.")));
        }
        field(45; Variety; Text[30])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            TableRelation = "WDC-QA Variety";
        }
        field(46; Size; Text[30])
        {
            CaptionML = ENU = 'Size', FRA = 'Calibre';
            TableRelation = "WDC-QA Size";
        }
        field(47; "Imprimable"; Option)
        {
            CaptionML = ENU = 'Imprimable', FRA = 'Imprimable';
            OptionMembers = Oui,Non;
            OptionCaptionML = ENU = 'Yes,No', FRA = 'Oui,Non';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key1; "Parameter Code")
        { }
        key(Key2; "Measure No.")
        { }
    }
}
