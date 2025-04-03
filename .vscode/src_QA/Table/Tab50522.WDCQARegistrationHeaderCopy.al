table 50522 "WDC-QARegistration Header Copy"
{
    CaptionML = ENU = 'Registration Header', FRA = 'En-tête enregistrement', NLD = 'Registratiekop';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.";
    LookupPageId = "WDC-QA Registration List";

    fields
    {
        field(1; "Document Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }

        field(3; "QC Date"; Date)
        {
            CaptionML = ENU = 'QC Date', FRA = 'Date CQ';
            Editable = false;
        }
        field(4; "QC Time"; Time)
        {
            CaptionML = ENU = 'QC Time', FRA = 'Heure CQ';
            Editable = false;
        }
        field(5; "Sample Temperature"; Decimal)
        {
            CaptionML = ENU = 'Sample Temperature', FRA = 'Température échantillon';
        }

        field(6; Status; enum "WDC-QA Specification Status")
        {
            CaptionML = ENU = 'Status', FRA = 'Status';
            ValuesAllowed = 0, 2;
        }
        field(7; "Internal Reference No."; Code[20])
        {
            CaptionML = ENU = 'Internal Reference No.', FRA = 'N° référence interne';
        }
        field(8; "Sample No."; Code[20])
        {
            CaptionML = ENU = 'Sample No.', FRA = 'N° échantillon';
        }
        field(9; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
            TableRelation = IF ("Item No." = FILTER(<> '')) "Lot No. Information"."Lot No." WHERE("Item No." = FIELD("Item No."));
        }
        field(10; "Serial/Container No."; Code[20])
        {
            CaptionML = ENU = 'Serial/Container No.', FRA = 'N° série/conteneur';
        }
        field(11; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
        }
        field(12; "Item Description"; text[50])
        {
            CaptionML = ENU = 'Item Description', FRA = 'Désignation article';
            Editable = false;
            FieldClass = Normal;
        }
        field(13; "Check Point Code"; Code[20])
        {
            CaptionML = ENU = 'Check Point Code', FRA = 'Code point de contrôle';
            TableRelation = "WDC-QA Check Point";
        }
        field(14; Specific; Enum "WDC-QA Specific")
        {
            CaptionML = ENU = 'Specific', FRA = 'Spécifique';
        }
        field(15; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF (Specific = CONST(Customer)) Customer ELSE IF (Specific = CONST(Vendor)) Vendor;
        }
        field(16; "Name"; Text[50])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            Editable = false;
        }
        field(18; "Production Date"; Date)
        {
            CaptionML = ENU = 'Production Date', FRA = 'Date production';
        }
        field(19; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        field(20; "Warranty Date"; Date)
        {
            CaptionML = ENU = 'Warranty Date', FRA = 'Date garantie';
            Editable = false;
        }
        field(21; "Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'Inspection Status', FRA = 'Statut d''inspection';
            Editable = false;
        }
        field(22; "Control Reason"; Code[20])
        {
            CaptionML = ENU = 'Control Reason', FRA = 'Motif contrôle';
            TableRelation = "Reason Code";
        }

        field(23; Comment; Boolean)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("WDC-QA RegistrationCommentLine" WHERE("Document Type" = FIELD("Document Type"), "No." = FIELD("No.")));
        }
        field(24; "Variant Code"; Code[20])
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(25; "Production Order No."; Code[20])
        {
            CaptionML = ENU = 'Production Order No.', FRA = 'N° O.F.';
            TableRelation = "Production Order"."No." WHERE("Source Type" = CONST(Item), "Source No." = FIELD("Item No."), Status = CONST(Released));
        }
        field(26; "Customer No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Customer No. Filter', FRA = 'Filtre n° client';
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(27; "Created By"; Code[50])
        {
            CaptionML = ENU = 'Created By', FRA = 'Créé par';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(28; "Buy-from Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
            Editable = false;
            TableRelation = Vendor;
        }
        field(29; "Vendor Lot No."; Code[20])
        {
            CaptionML = ENU = 'Vendor Lot No.', FRA = 'N° lot fournisseur';
        }
        field(30; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souche de N°';
            TableRelation = "No. Series";
        }
        // field(31; "Return Order Type"; Enum "WDC-QA Return Order Type")
        // {
        //     CaptionML = ENU = 'Return Order Type', FRA = 'Type ordre retour';
        //     Editable = false;
        // }

        // field(32; "Return Order No."; Code[20])
        // {
        //     CaptionML = ENU = 'Return Order No.', FRA = 'N° retour';
        //     Editable = false;
        //     TableRelation = IF ("Return Order Type" = CONST(Sales)) "Sales Header"."No." WHERE("Document Type" = CONST("Return Order")) ELSE IF ("Return Order Type" = CONST(Purchase)) "Purchase Header"."No." WHERE("Document Type" = CONST("Return Order"));
        // }
        field(33; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
            TableRelation = "Item Category";
        }
        field(34; "Lot No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Lot No. Filter', FRA = 'Filtre n° lot';
            FieldClass = FlowFilter;
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(35; "Source Document Type"; Enum "WDC-QA Source Document Type")
        {
            CaptionML = ENU = 'Source Document Type', FRA = 'Type document entrepôt';
            InitValue = Manual;
            Editable = false;
        }
        field(36; "Item No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Item No. Filter', FRA = 'Filtre n° article';
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(37; "Source Document No."; Code[20])
        {
            CaptionML = ENU = 'Source Document No.', FRA = 'N° document entrepôt';
            TableRelation = IF ("Source Document Type" = filter('Warehouse Shipment')) "Warehouse Shipment Header"."No." WHERE("No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Inventory Pick')) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Pick"), "No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Warehouse Receipt')) "Warehouse Receipt Header"."No." WHERE("No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Inventory Put-away')) "Warehouse Activity Header"."No." WHERE(Type = CONST("Invt. Put-away"), "No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Machine Center')) "Machine Center"."No." WHERE("No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Work Center')) "Work Center"."No." WHERE("No." = FIELD("Source Document No."))
            //ELSE IF ("Source Document Type" = filter('Production Line')) "WDC-QA Production Line"."No." WHERE("No." = FIELD("Source Document No."))
            ELSE IF ("Source Document Type" = filter('Production Order')) "Production Order"."No." WHERE(Status = FILTER(< Finished), "No." = FIELD("Source Document No."));
        }
        field(38; "Source Document Line No."; Integer)
        {
            CaptionML = ENU = 'Source Document Line No.', FRA = 'N° ligne doc. entrepôt';
            Editable = false;
        }
        field(39; "Reference Source No."; Code[20])
        {
            CaptionML = ENU = 'Reference Source No.', FRA = 'N° réf. origine';
            Editable = false;
        }
        field(40; "Item Description2"; text[100])
        {
            CaptionML = ENU = 'Item Description2', FRA = 'Désignation article';
            fieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            editable = False;
        }
        field(41; Controller; Code[20])
        {
            CaptionML = ENU = 'Controller', FRA = 'Controleur';
            TableRelation = "WDC-QA QC Controller";
        }
        field(42; Variety; Text[30])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            TableRelation = "WDC-QA Variety";
        }
        field(43; Size; Text[30])
        {
            CaptionML = ENU = 'Size', FRA = 'Calibre';
            TableRelation = "WDC-QA Size";
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key1; "Item No.", "Check Point Code")
        { }
        key(Key2; "Lot No.", "Item No.", "Variant Code")
        { }
        // key(Key3; "Return Order Type", "Return Order No.")
        // { }
        key(Key4; Status, "Item No.", "Lot No.", "Check Point Code", "Buy-from Vendor No.")
        { }
        key(Key5; "No.", "QC Date")
        { }
    }
}
