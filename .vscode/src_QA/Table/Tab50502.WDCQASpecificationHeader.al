table 50502 "WDC-QA Specification Header"
{
    CaptionML = ENU = 'Specification Header', FRA = 'En-tête Spécification';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA QC Specification List";

    fields
    {
        field(1; "Document Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            ValuesAllowed = 0, 1;
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    QualityControlSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
        }
        field(3; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(4; "Version No."; Code[20])
        {
            CaptionML = ENU = 'Version No.', FRA = 'N° version';
            Editable = false;
        }
        field(5; "Version Date"; Date)
        {
            CaptionML = ENU = 'Version Date', FRA = 'Date version';
            Editable = false;
        }
        field(6; "Revised By"; code[50])
        {
            CaptionML = ENU = 'Revised By', FRA = 'Révisé par';
            TableRelation = User."User Name";
            Editable = false;
        }
        field(7; "Date Closed"; Date)
        {
            CaptionML = ENU = 'Date Closed', FRA = 'Date cloture';
            Editable = false;
        }
        field(8; Status; Enum "WDC-QA Specification Status")
        {
            CaptionML = ENU = 'Status', FRA = 'Statut';
            trigger OnValidate()
            begin
                IF Status IN [Status::Certified, Status::Closed] THEN
                    CheckOnbeforeChangeStatus;
                CheckUniqueSpecification;
                CheckLines;
                IF Status = Status::Closed THEN BEGIN
                    IF CONFIRM(STRSUBSTNO(Text004, "Document Type"), TRUE) THEN BEGIN
                        "Date Closed" := WORKDATE;
                    END ELSE
                        ERROR('');
                END;
            end;
        }
        field(9; "Item No."; Code[50])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);

                CheckUniqueSpecification;

                //CheckBasicSpecification;

                IF "Item No." <> xRec."Item No." THEN BEGIN
                    IF Item.GET("Item No.") THEN;
                    "Item Description" := Item.Description;
                    "Item Category Code" := Item."Item Category Code";
                end;
            end;

            trigger OnLookup()
            var
                ItemList: Page "Item List";
            begin
                ItemList.SETTABLEVIEW(Item);
                ItemList.LOOKUPMODE(TRUE);
                IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    ItemList.GETRECORD(Item);
                    VALIDATE("Item No.", Item."No.");
                END;
            end;
        }
        field(10; "Item Description"; Text[50])
        {
            CaptionML = ENU = 'Item Description', FRA = 'Désignation article';
            FieldClass = Normal;
            Editable = false;
        }
        field(11; "Check Point Code"; Code[20])
        {
            CaptionML = ENU = 'Check Point Code', FRA = 'Code point de contrôle';
            TableRelation = "WDC-QA Check Point";
            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);

                CheckUniqueSpecification;
                //"Process Control Frequency" := 0;
            end;
        }
        field(12; Specific; Enum "WDC-QA Specific")
        {
            CaptionML = ENU = 'Specific', FRA = 'Spécifique';
            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);

                IF Specific <> xRec.Specific THEN BEGIN
                    "Source No." := '';
                    Name := '';
                END;

                CheckUniqueSpecification;
            end;
        }
        field(13; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF (Specific = CONST(Customer)) Customer
            ELSE IF (Specific = CONST(Vendor)) Vendor;
            //ELSE IF (Specific = CONST("Customer Attribute")) "Customer Attribute 1" 
            //ELSE IF (Specific=CONST("Vendor Attribute")) "Vendor Attribute 1";
            trigger OnValidate()
            begin
                TESTFIELD(Status, Status::Open);

                CheckUniqueSpecification;

                CASE Specific OF
                    Specific::Customer:
                        BEGIN
                            IF Customer.GET("Source No.") THEN;
                            Name := Customer.Name;
                        END;
                    Specific::Vendor:
                        BEGIN
                            IF Vendor.GET("Source No.") THEN;
                            Name := Vendor.Name;
                        END;
                END;
            end;
        }
        field(14; Name; text[50])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de N°';
            TableRelation = "No. Series";
        }
        field(16; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
            TableRelation = "Item Category";
            trigger OnValidate()
            begin
                //CheckBasicSpecification;
                IF xRec."Item Category Code" <> "Item Category Code" THEN
                    "Item No." := '';
            end;
        }
        field(17; "Process Description"; Text[250])
        {
            CaptionML = ENU = 'Process Description', FRA = 'Déscription du process';
        }
        field(28; "Chemical Standard"; Text[250])
        {
            Caption = 'Chemical Standard';
            //CaptionML = ENU = 'Chemical Standard', FRA = 'Normes chimiques';
        }
        field(19; "Sampling Frequency PSF"; Decimal)
        {
            CaptionML = ENU = 'Sampling Frequency PSF', FRA = 'Fréquence d''échantillonnage PSF';
        }
        field(20; "Sampling Frequency PF"; Decimal)
        {
            CaptionML = ENU = 'Sampling Frequency PF', FRA = 'Fréquence d''échantillonnage PF';
        }
        field(21; "Item Description2"; Text[100])
        {
            CaptionML = ENU = 'Item Description2', FRA = 'Désignation article';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
        }
        field(22; "Pallet Control Frequency 1/"; Integer)
        {
            CaptionML = ENU = 'Pallet Control Frequency 1/', FRA = 'Fréquence contrôle palette 1/';
            trigger OnValidate()
            var
                lRegistrationLine: Record "WDC-QA Registration Line";
            begin
                lRegistrationLine.RESET;
            end;
        }
        field(23; "Reason for Modification"; Text[100])
        {
            CaptionML = ENU = 'Reason for Modification', FRA = 'Raison pour modification';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Version No.")
        {
            Clustered = true;
        }

    }
    trigger OnInsert()
    var
        QualityControlSetup: Record "WDC-QA Quality Control Setup";
    begin
        QualityControlSetup.GET;

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            "No." := NoSeriesMgt.GetNextNo(GetNoSeriesCode, 0D, true);
        END;

        "Version Date" := WORKDATE;
        IF "Revised By" = '' THEN
            "Revised By" := USERID;
    end;

    trigger OnDelete()
    var
        SpecificationLine: Record "WDC-QA Specification Line";
    begin
        SpecificationLine.SETRANGE("Document Type", "Document Type");
        SpecificationLine.SETFILTER("Document No.", "No.");
        SpecificationLine.SETFILTER("Version No.", "Version No.");
        IF NOT SpecificationLine.ISEMPTY THEN
            SpecificationLine.DELETEALL(TRUE);
    end;

    procedure AssistEdit(OldSpecificationHeader: Record "WDC-QA Specification Header"): Boolean
    begin
        SpecificationHeader := Rec;
        QualityControlSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.LookupRelatedNoSeries(GetNoSeriesCode, OldSpecificationHeader."No. Series", "No. Series") THEN BEGIN
            QualityControlSetup.GET;
            TestNoSeries;
            NoSeriesMgt.GetNextNo("No.");
            Rec := SpecificationHeader;
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        CASE "Document Type" OF
            "Document Type"::Calibration:
                QualityControlSetup.TESTFIELD("Calibration Spec.Nos.");
            "Document Type"::QC:
                QualityControlSetup.TESTFIELD("QC Specification Nos.");
        END;
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        CASE "Document Type" OF
            "Document Type"::Calibration:
                EXIT(QualityControlSetup."Calibration Spec.Nos.");
            "Document Type"::QC:
                EXIT(QualityControlSetup."QC Specification Nos.");
        END;
    end;

    procedure InitVersion(): Code[20]
    begin
        QualityControlSetup.GET;
        CASE "Document Type" OF
            "Document Type"::Calibration:
                BEGIN
                    QualityControlSetup.TESTFIELD("Initial Calibration Version");
                    EXIT(QualityControlSetup."Initial Calibration Version");
                END;
            "Document Type"::QC:
                BEGIN
                    QualityControlSetup.TESTFIELD("Initial QC Spec. Version");
                    EXIT(QualityControlSetup."Initial QC Spec. Version");
                END;
        END;
    end;

    procedure CheckUniqueSpecification()
    begin
        CASE "Document Type" OF
            "Document Type"::Calibration:
                BEGIN
                    IF (Status = Status::Certified) THEN BEGIN
                        // SpecificationHeader.SETCURRENTKEY("Equipment No.", Status);
                        // SpecificationHeader.SETRANGE("Equipment No.", "Equipment No.");
                        SpecificationHeader.SETRANGE(Status, SpecificationHeader.Status::Certified);
                        SpecificationHeader.SETFILTER("No.", '<>%1', "No.");
                        SpecificationHeader.SETRANGE("Document Type", "Document Type");
                        IF SpecificationHeader.FINDFIRST THEN
                            //ERROR(Text001 + Text002, SpecificationHeader."No.", SpecificationHeader."Equipment No.", SpecificationHeader."Document Type");
                            ERROR(Text001 + Text002, SpecificationHeader."No.", SpecificationHeader."Document Type");
                    END;
                END;
            "Document Type"::QC:
                BEGIN
                    IF (Status = Status::Certified) THEN BEGIN
                        IF (Specific <> Specific::"Not") THEN
                            TESTFIELD("Source No.");

                        SpecificationHeader.SETCURRENTKEY("Check Point Code", "Source No.", Status, "Item Category Code", "Item No.");
                        SpecificationHeader.SETFILTER("Item No.", '%1', "Item No.");
                        SpecificationHeader.SETRANGE("Check Point Code", "Check Point Code");
                        SpecificationHeader.SETRANGE(Specific, Specific);
                        SpecificationHeader.SETRANGE("Source No.", "Source No.");
                        SpecificationHeader.SETRANGE(Status, SpecificationHeader.Status::Certified);
                        SpecificationHeader.SETFILTER("No.", '<>%1', "No.");
                        SpecificationHeader.SETRANGE("Document Type", "Document Type");
                        IF SpecificationHeader.FINDFIRST THEN
                            ERROR(Text005 + Text006, SpecificationHeader."Document Type", "No.", SpecificationHeader."No.",
                                                FIELDCAPTION("Item No."), "Item No.",
                                                FIELDCAPTION("Source No."), "Source No.",
                                                FIELDCAPTION("Check Point Code"), "Check Point Code")
                    END;
                END;
        END;
    end;

    procedure CheckLines()
    var
        SpecificationLine: Record "WDC-QA Specification Line";
    begin
        IF "Document Type" <> "Document Type"::QC THEN
            EXIT;

        IF (Status = Status::Certified) THEN BEGIN
            SpecificationLine.RESET;
            SpecificationLine.SETRANGE("Document Type", "Document Type");
            SpecificationLine.SETRANGE("Document No.", "No.");
            SpecificationLine.SETRANGE("Version No.", "Version No.");
            IF SpecificationLine.FINDSET THEN
                REPEAT
                    SpecificationLine.TESTFIELD("Parameter Code");
                UNTIL SpecificationLine.NEXT = 0;
        END;
    end;

    procedure CheckBasicSpecification()
    begin
        //IF NOT "Basic Specification" THEN
        //EXIT;

        //IF ("Item No." <> '') //OR ("Item Category Code" <> '') OR ("Item Attribute 1" <> '') OR
        //("Item Attribute 2" <> '') OR ("Item Attribute 3" <> '') OR ("Item Attribute 4" <> '') OR
        //("Item Attribute 5" <> '') OR ("Item Attribute 6" <> '') OR ("Item Attribute 7" <> '') OR
        //("Item Attribute 8" <> '') OR ("Item Attribute 9" <> '') OR ("Item Attribute 10" <> '')
        //THEN
        //ERROR(Text007);
    end;

    local procedure CheckOnbeforeChangeStatus()
    var
        SpecificationLine: Record "WDC-QA Specification Line";
    begin
        IF "Document Type" = "Document Type"::Calibration THEN
            EXIT;

        TESTFIELD("Check Point Code");

        SpecificationLine.SETRANGE("Document Type", "Document Type");
        SpecificationLine.SETRANGE("Document No.", "No.");
        SpecificationLine.SETRANGE("Version No.", "Version No.");
        IF SpecificationLine.ISEMPTY THEN
            ERROR(Text008, Status);
    end;

    var
        QualityControlSetup: Record "WDC-QA Quality Control Setup";
        SpecificationHeader: Record "WDC-QA Specification Header";
        SpecificatiobLine: Record "WDC-QA Specification Line";
        Item: Record Item;
        Customer: Record Customer;
        Vendor: Record Vendor;
        NoSeriesMgt: Codeunit "No. Series";
        //NO: Codeunit NoSeriesManagement;
        Text001: TextConst ENU = 'It is not possible to change the status to Certified,\', FRA = 'Il n''est pas possible de changer le statut en Certifié,\';
        Text002: TextConst ENU = 'because %3 Specification %1 has status Certified', FRA = 'parce que %3 spécification %1 a statut Certifié';
        Text004: TextConst ENU = 'Do you want to close this %1 Specification?', FRA = 'Voulez-vous fermer cette %1 spécification?';
        Text005: TextConst ENU = '%1 Specification %2 is not unique.\\', FRA = '%1 Spécification %2 n''est pas unique.\\';
        Text006: TextConst ENU = '%1 Specification No. %3 has the same fieldvalues,\ %4 "%5", %6 "%7", %8 "%9".', FRA = '%1 N° Spécification %3 a les mêmes valeurs de champ,\ %4 "%5", %6 "%7", %8 "%9".';
        Text007: TextConst ENU = 'Item filters are not allowed for Basic QC Specifications.', FRA = 'Les filtres article ne sont pas autorisés pour les spécifications de base.';
        Text008: TextConst ENU = 'No line exists. It is not possible to change the status to %1.', FRA = 'Aucune ligne n''existe. Il n''est pas possible de changer le statut à %1.';
        CheckPointCodeNotPeriodicalErr: TextConst ENU = 'Check Point Code %1 is not setup as periodical in a production line.', FRA = 'Le code de point de contrôle %1 n''est pas configuré comme périodique dans une ligne de production.';
}
