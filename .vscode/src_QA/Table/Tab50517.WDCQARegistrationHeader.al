table 50517 "WDC-QA Registration Header"
{
    CaptionML = ENU = 'Registration Header', FRA = 'En-tête enregistrement';
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
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    QualityControlSetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
            end;
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
            trigger OnValidate()
            begin
                ChangeStatus;
            end;
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
            trigger OnValidate()
            begin
                IF "Lot No." <> '' THEN BEGIN
                    ConfirmDeleteLines(FIELDCAPTION("Lot No."));
                    LotNoInformation.RESET;
                    LotNoInformation.SETFILTER("Lot No.", "Lot No.");
                    LotNoInformation.SETFILTER("Item No.", "Item No.");
                    IF LotNoInformation.COUNT > 1 THEN
                        ERROR(Text008);
                    IF LotNoInformation.FINDFIRST THEN
                        VALIDATE("Item No.", LotNoInformation."Item No.");

                    "Variant Code" := LotNoInformation."Variant Code";
                    "Production Date" := LotNoInformation."Creation Date";
                    RegistrationHeader.RESET;
                    RegistrationHeader.SETRANGE("Lot No.", "Lot No.");
                    IF RegistrationHeader.FINDFIRST THEN BEGIN
                        "Expiration Date" := RegistrationHeader."Expiration Date";
                    END;
                    "Warranty Date" := LotNoInformation."Warranty Date";
                    "Inspection Status" := LotNoInformation."Inspection Status";
                    "Buy-from Vendor No." := LotNoInformation."Buy-from Vendor No.";
                    "Vendor Lot No." := LotNoInformation."Vendor Lot No.";
                END;
            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                LotNoInformation.RESET;
                IF "Item No." <> '' THEN
                    LotNoInformation.SETRANGE("Item No.", "Item No.");

                IF LotNoInformation.GET("Item No.", "Variant Code", "Lot No.") THEN;

                CLEAR(LotNoInformationList);
                LotNoInformationList.SETTABLEVIEW(LotNoInformation);
                LotNoInformationList.LOOKUPMODE(TRUE);
                IF LotNoInformationList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    LotNoInformationList.GETRECORD(LotNoInformation);
                    "Lot No." := LotNoInformation."Lot No.";
                    VALIDATE("Item No.", LotNoInformation."Item No.");
                    "Variant Code" := LotNoInformation."Variant Code";
                    "Production Date" := LotNoInformation."Creation Date";
                    "Expiration Date" := LotNoInformation."Expiration Date";
                    "Warranty Date" := LotNoInformation."Warranty Date";
                    "Inspection Status" := LotNoInformation."Inspection Status";
                    "Buy-from Vendor No." := LotNoInformation."Buy-from Vendor No.";
                    "Vendor Lot No." := LotNoInformation."Vendor Lot No.";
                END;
            end;
        }
        field(10; "Serial/Container No."; Code[20])
        {
            CaptionML = ENU = 'Serial/Container No.', FRA = 'N° série/conteneur';
        }
        field(11; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
            trigger OnValidate()
            var
                ProductionOrder: Record "Production Order";
            begin
                IF "Item No." <> xRec."Item No." THEN BEGIN
                    ConfirmDeleteLines(FIELDCAPTION("Item No."));

                    "Item Description" := '';
                    "Production Line Code" := '';
                    IF NOT Item.GET("Item No.") THEN
                        Item.INIT;
                    "Item Description" := Item.Description;
                    //"Production Line Code" := Item."Production Line";
                    "Item Category Code" := Item."Item Category Code";
                    IF ("Lot No." <> '') AND ("Item No." <> '') THEN BEGIN
                        LotNoInformation.RESET;
                        LotNoInformation.SETFILTER("Lot No.", "Lot No.");
                        LotNoInformation.SETFILTER("Item No.", "Item No.");
                        IF LotNoInformation.ISEMPTY THEN BEGIN
                            VALIDATE("Lot No.", '');
                            VALIDATE("Variant Code", '');
                        END;
                    END ELSE BEGIN
                        VALIDATE("Lot No.", '');
                        VALIDATE("Variant Code", '');
                    END;
                    IF ("Production Order No." <> '') AND ("Item No." <> '') THEN BEGIN
                        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
                        ProductionOrder.SETRANGE("Source No.", "Item No.");
                        ProductionOrder.SETRANGE("Source Type", ProductionOrder."Source Type"::Item);
                        IF ProductionOrder.ISEMPTY THEN
                            "Production Order No." := '';
                    END ELSE BEGIN
                        "Production Order No." := '';
                    END;
                END;
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
            trigger OnValidate()
            begin
                IF "Check Point Code" <> xRec."Check Point Code" THEN
                    ConfirmDeleteLines(FIELDCAPTION("Check Point Code"));
            end;
        }
        field(14; Specific; Enum "WDC-QA Specific")
        {
            CaptionML = ENU = 'Specific', FRA = 'Spécifique';
            trigger OnValidate()
            begin
                IF Specific <> xRec.Specific THEN BEGIN
                    VALIDATE("Source No.", '');
                    Name := '';
                END;
            end;
        }
        field(15; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF (Specific = CONST(Customer)) Customer ELSE IF (Specific = CONST(Vendor)) Vendor;
            trigger OnValidate()
            var
                CustomerRec: Record Customer;
                VendorRec: Record Vendor;
            begin
                IF "Source No." <> xRec."Source No." THEN
                    ConfirmDeleteLines(FIELDCAPTION("Source No."));

                CASE Specific OF
                    Specific::Customer:
                        IF CustomerRec.GET("Source No.") THEN
                            Name := CustomerRec.Name;
                    Specific::Vendor:
                        IF VendorRec.GET("Source No.") THEN
                            Name := VendorRec.Name;
                    ELSE
                        Name := '';
                END;
            end;
        }
        field(16; "Name"; Text[50])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            Editable = false;
        }
        field(17; "Production Line Code"; Code[20])
        {
            CaptionML = ENU = 'Production Line Code', FRA = 'Code ligne de production';
            //TableRelation = "WDC-QA Production Line";
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
        field(24; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(25; "Production Order No."; Code[10])
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
        field(30; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souche de N°';
            TableRelation = "No. Series";
        }
        field(31; "Return Order Type"; Enum "WDC-QA Return Order Type")
        {
            CaptionML = ENU = 'Return Order Type', FRA = 'Type ordre retour';
            Editable = false;
        }

        field(32; "Return Order No."; Code[20])
        {
            CaptionML = ENU = 'Return Order No.', FRA = 'N° retour';
            Editable = false;
            TableRelation = IF ("Return Order Type" = CONST(Sales)) "Sales Header"."No." WHERE("Document Type" = CONST("Return Order")) ELSE IF ("Return Order Type" = CONST(Purchase)) "Purchase Header"."No." WHERE("Document Type" = CONST("Return Order"));
        }
        field(33; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
            TableRelation = "Item Category";
            trigger OnValidate()
            begin
                IF xRec."Item Category Code" <> "Item Category Code" THEN BEGIN
                    ConfirmDeleteLines(FIELDCAPTION("Item Category Code"));
                    "Lot No." := '';
                    VALIDATE("Item No.", '');
                END
            end;
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
        key(Key3; "Return Order Type", "Return Order No.")
        { }
        key(Key4; Status, "Item No.", "Lot No.", "Check Point Code", "Buy-from Vendor No.")
        { }
        key(Key5; "No.", "QC Date")
        { }
    }
    trigger OnInsert()
    begin
        QualityControlSetup.GET;

        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "No.", "No. Series");
            //NoSeriesMgt.GetNextNo(GetNoSeriesCode, 0D, true);
        END;

        "QC Date" := TODAY;
        "QC Time" := TIME;
        "Created By" := USERID;
        Gline := 10000;
        CLEAR(GCommentCOA);
        IF GCommentCOA.FINDFIRST THEN
            REPEAT
                Gline := Gline + 1000;
                GRegistCommentLine.INIT;
                GRegistCommentLine."Document Type" := "Document Type";
                GRegistCommentLine."No." := "No.";
                GRegistCommentLine."Line No." := Gline;
                GRegistCommentLine.Date := "QC Date";
                GRegistCommentLine.Code := '';
                GRegistCommentLine.Comment := GCommentCOA."Commentaire COA";
                GRegistCommentLine.Display := FALSE;
                GRegistCommentLine.INSERT(TRUE);
            UNTIL GCommentCOA.NEXT = 0;
    end;

    trigger OnDelete()
    var
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
        KindOfQCRegistrationAction: Option Release,Delete,Close;
    begin
        RegistrationLine.SETRANGE("Document Type", "Document Type");
        RegistrationLine.SETFILTER("Document No.", "No.");
        IF NOT RegistrationLine.ISEMPTY THEN
            RegistrationLine.DELETEALL(TRUE);

        CASE "Return Order Type" OF
            "Return Order Type"::Sales:
                BEGIN
                    // SalesHeader.SETCURRENTKEY("Registration Header Type", "Registration Header No.");
                    // SalesHeader.SETRANGE("Registration Header Type", "Document Type");
                    // SalesHeader.SETRANGE("Registration Header No.", "No.");
                    // IF SalesHeader.FINDFIRST THEN BEGIN
                    //     SalesHeader."Registration Header Type" := 0;
                    //     SalesHeader."Registration Header No." := '';
                    //     SalesHeader.MODIFY;
                    // END;
                END;
            "Return Order Type"::Purchase:
                BEGIN
                    // PurchaseHeader.SETCURRENTKEY("Registration Header Type", "Registration Header No.");
                    // PurchaseHeader.SETRANGE("Registration Header Type", "Document Type");
                    // PurchaseHeader.SETRANGE("Registration Header No.", "No.");
                    // IF PurchaseHeader.FINDFIRST THEN BEGIN
                    //     PurchaseHeader."Registration Header Type" := 0;
                    //     PurchaseHeader."Registration Header No." := '';
                    //     PurchaseHeader.MODIFY;
                    // END;
                END;
        END;

        QualityControlMgt.DeletefromQCRegistration(Rec, KindOfQCRegistrationAction::Delete);
        CLEAR(GRegistCommentLine);
        GRegistCommentLine.SETRANGE("Document Type", "Document Type");
        GRegistCommentLine.SETRANGE("No.", "No.");
        IF GRegistCommentLine.FINDFIRST THEN
            GRegistCommentLine.DELETEALL;
    end;

    procedure AssistEdit(OldRegistrationHeader: Record "WDC-QA Registration Header"): Boolean
    begin
        RegistrationHeader := Rec;
        QualityControlSetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldRegistrationHeader."No. Series", "No. Series") THEN BEGIN
            QualityControlSetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            Rec := RegistrationHeader;
            EXIT(TRUE);
        END;
    end;

    local procedure TestNoSeries(): Boolean
    begin
        CASE "Document Type" OF
            "Document Type"::Calibration:
                QualityControlSetup.TESTFIELD("Calibration Reg. Nos.");
            "Document Type"::QC:
                QualityControlSetup.TESTFIELD("QC Registration Nos.");
            "Document Type"::CoA:
                QualityControlSetup.TESTFIELD("CoA Registration Nos.");
        END;
    end;

    local procedure GetNoSeriesCode(): Code[10]
    begin
        CASE "Document Type" OF
            "Document Type"::Calibration:
                EXIT(QualityControlSetup."Calibration Reg. Nos.");
            "Document Type"::QC:
                EXIT(QualityControlSetup."QC Registration Nos.");
            "Document Type"::CoA:
                EXIT(QualityControlSetup."CoA Registration Nos.");
        END;
    end;

    procedure ChangeStatus()
    var
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
    begin
        IF Status = Status::Closed THEN BEGIN
            RegistrationLine.SETRANGE("Document Type", "Document Type");
            RegistrationLine.SETRANGE("Document No.", "No.");
            IF RegistrationLine.ISEMPTY THEN
                ERROR(Text001, "Document Type");

            IF NOT CONFIRM(STRSUBSTNO(Text002, "Document Type"), TRUE) THEN
                ERROR('');

            CopyDuplicataRegistrationCQ(Rec);

            // IF "Document Type" = "Document Type"::Calibration THEN
            //     IF Equipment.GET("Equipment No.") THEN BEGIN
            //         Equipment.VALIDATE("Date Last Calibration", WORKDATE);
            //         Equipment.MODIFY(TRUE);
            //     END;
        END;
    end;

    procedure CreateNonConformance()
    var
        //CustomerNonConformance:Page Customer Non Conformance;
        //VendorNonConformance:Page Vendor Non Conformance;
        //InternalNonConformance:Page Internal Non Conformance;
        //NonConformance: Record NonConformance;
        NCType: Option "Customer","Vendor","Internal";
        Selection: Integer;
        QuestionNC: Text[300];
    begin
        Selection := STRMENU(Text005);
        CASE Selection OF
            0:
                EXIT;
            1:
                NCType := NCType::Customer;
            2:
                NCType := NCType::Vendor;
            3:
                NCType := NCType::Internal;
        END;
        // NonConformance.SETCURRENTKEY("Item No.", "Lot No.");
        // NonConformance.SETRANGE("Item No.", "Item No.");
        // NonConformance.SETRANGE("Lot No.", "Lot No.");
        // NonConformance.SETRANGE(Type, NCType);
        // IF NonConformance.FINDFIRST THEN BEGIN
        //     QuestionNC := Text003 + ' ' + NonConformance."No." + ' ' + Text004;
        //     IF NOT CONFIRM(QuestionNC) THEN
        //         EXIT;
        // END ELSE BEGIN
        //     NonConformance.VALIDATE("Item No.", "Item No.");
        //     NonConformance.Type := NCType;
        //     NonConformance."Lot No." := "Lot No.";
        //     NonConformance."Expiration Date" := "Warranty Date";
        //     NonConformance."Receipt Date" := WORKDATE;
        //     NonConformance.INSERT(TRUE);
        // END;

        CASE Selection OF
        //    1:
        // BEGIN
        //     IF Specific = Specific::Customer THEN BEGIN
        //         NonConformance.VALIDATE("Customer No.", "Source No.");
        //         NonConformance."Reference Sales Document Type" := NonConformance."Reference Sales Document Type"::Shipment;
        //         NonConformance.MODIFY(TRUE);
        //     END;
        //     CLEAR(CustomerNonConformance2);
        //     CustomerNonConformance2.SETRECORD(NonConformance);
        //     CustomerNonConformance2.RUN;
        //     //
        // END;
        //    2:
        // BEGIN
        //     IF Specific = Specific::Vendor THEN
        //         NonConformance.VALIDATE("Vendor No.", "Source No.");
        //     LotNoInformation.SETCURRENTKEY("Item No.", "Lot No.");
        //     LotNoInformation.SETRANGE("Item No.", "Item No.");
        //     LotNoInformation.SETRANGE("Lot No.", "Lot No.");
        //     IF LotNoInformation.FINDFIRST THEN
        //         NonConformance."Vendor Lot No." := LotNoInformation."Vendor Lot No.";
        //     NonConformance.VALIDATE("Vendor No.", "Buy-from Vendor No.");
        //     NonConformance."Reference Purch. Document Type" := NonConformance."Reference Purch. Document Type"::Receipt;
        //     NonConformance.MODIFY(TRUE);
        //     CLEAR(VendorNonConformance2);
        //     VendorNonConformance2.SETRECORD(NonConformance);
        //     VendorNonConformance2.RUN;
        //     //
        // END;
        //    3:
        // BEGIN
        //     CLEAR(InternalNonConformance2);
        //     InternalNonConformance2.SETRECORD(NonConformance);
        //     InternalNonConformance2.RUN;
        // END;
        END;

    end;

    procedure ConfirmDeleteLines(ChangedFieldName: Text[100])
    begin
        RegistrationLine.SETRANGE("Document Type", "Document Type");
        RegistrationLine.SETFILTER("Document No.", "No.");
        IF RegistrationLine.ISEMPTY THEN EXIT;

        IF CONFIRM(Text006 + Text007, TRUE, ChangedFieldName, "Document Type") THEN
            RegistrationLine.DELETEALL(TRUE)
        ELSE
            Rec := xRec;
    end;

    procedure GetBuyfromVendorName(Vendor: Record Vendor): Text[50]
    begin
        IF "Buy-from Vendor No." <> '' THEN
            IF Vendor.GET("Buy-from Vendor No.") THEN
                EXIT(Vendor.Name)
    end;

    procedure CopyDuplicataRegistrationCQ(RegHeader: Record "WDC-QA Registration Header")
    var
    //RegistrationHeadeCopy:Record RegistrationHeadeCopy;
    //RegistrationHeadeLine:Record 
    //RegistrationStep:Record Registration Step;

    begin
        // RegistrationHeadeCopy.RESET;
        // RegistrationHeadeCopy.SETRANGE("No.", RegHeader."No.");
        // RegistrationHeadeCopy.SETRANGE("Document Type", RegHeader."Document Type");
        // RegistrationHeadeCopy.DELETEALL;
        // //

        // RegistrationLineCopy.RESET;
        // RegistrationLineCopy.SETRANGE("Document No.", RegHeader."No.");
        // RegistrationLineCopy.SETRANGE("Document Type", RegHeader."Document Type");
        // RegistrationLineCopy.DELETEALL;
        // //
        // RegistrationStepCopy.RESET;
        // RegistrationStepCopy.SETRANGE("Document No.", RegHeader."No.");
        // RegistrationStepCopy.SETRANGE("Document Type", RegHeader."Document Type");
        // RegistrationStepCopy.DELETEALL;
        // //
        // RegistrationHeadeCopy.INIT;
        // RegistrationHeadeCopy.TRANSFERFIELDS(RegHeader);
        // IF RegistrationHeadeCopy.INSERT THEN;

        // RegistrationLine.RESET;
        // RegistrationLine.SETRANGE("Document Type", RegHeader."Document Type");
        // RegistrationLine.SETRANGE("Document No.", RegHeader."No.");
        // IF RegistrationLine.FINDSET THEN
        //     REPEAT
        //         RegistrationLineCopy.INIT;
        //         RegistrationLineCopy.TRANSFERFIELDS(RegistrationLine);
        //         IF RegistrationLineCopy.INSERT THEN;

        //         RegistrationStep.RESET;
        //         RegistrationStep.SETRANGE("Document Type", RegistrationLine."Document Type");
        //         RegistrationStep.SETRANGE("Document No.", RegistrationLine."Document No.");
        //         RegistrationStep.SETRANGE("Line No.", RegistrationLine."Line No.");
        //         IF RegistrationStep.FINDSET THEN
        //             REPEAT
        //                 RegistrationStepCopy.INIT;
        //                 RegistrationStepCopy.TRANSFERFIELDS(RegistrationStep);
        //                 IF RegistrationStepCopy.INSERT THEN;

        //             UNTIL RegistrationStep.NEXT = 0;

        //     UNTIL RegistrationLine.NEXT = 0;
    end;

    procedure ReleaseWhseDocument()
    var
        Action: Option Release,Delete;
    begin
        CASE "Source Document Type" OF
            "Source Document Type"::"Inventory Pick":
                BEGIN
                    QualityControlMgt.UpdateInvtPickHeader(Rec, Action::Release);
                    QualityControlMgt.UpdateInvtPickLine(Rec, Action::Release);
                END;
            "Source Document Type"::"Warehouse Shipment":
                BEGIN
                    QualityControlMgt.UpdateWhseShipmentHeader(Rec, Action::Release);
                    QualityControlMgt.UpdateWhseShipmentLine(Rec, Action::Release);
                END;
            "Source Document Type"::"Inventory Put-away":
                BEGIN
                    QualityControlMgt.UpdateInvtPutAwayHeader(Rec, Action::Release);
                    QualityControlMgt.UpdateInvtPutAwayLine(Rec, Action::Release);
                END;
            "Source Document Type"::"Warehouse Receipt":
                BEGIN
                    QualityControlMgt.UpdateWhseReceiptHeader(Rec, Action::Release);
                    QualityControlMgt.UpdateWhseReceiptLine(Rec, Action::Release);
                END;
        END;
    end;

    procedure GetStepCounts(ModifiedStepCount: Integer; MaxStepCount: Integer)
    var
        RegistrationStep: Record "WDC-QA Registration Step";
    begin
        RegistrationStep.SETRANGE("Document Type", "Document Type");
        RegistrationStep.SETRANGE("Document No.", "No.");

        MaxStepCount := RegistrationStep.COUNT;

        RegistrationStep.SETRANGE(Modified, TRUE);
        ModifiedStepCount := RegistrationStep.COUNT;
    end;

    procedure HasBeenCalculated(): Boolean
    var
        RegistrationLine: record "WDC-QA Registration Line";
    begin
        RegistrationLine.SETRANGE("Document Type", "Document Type");
        RegistrationLine.SETRANGE("Document No.", "No.");
        IF RegistrationLine.ISEMPTY THEN
            EXIT(TRUE);

        RegistrationLine.SETRANGE("Conclusion Result", RegistrationLine."Conclusion Result"::" ");
        EXIT(RegistrationLine.ISEMPTY);
    end;

    var
        Gline: Integer;
        QualityControlSetup: Record "WDC-QA Quality Control Setup";
        RegistrationHeader: Record "WDC-QA Registration Header";
        RegistrationLine: Record "WDC-QA Registration Line";
        LotNoInformation: Record "Lot No. Information";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        GCommentCOA: Record "WDC-QA Commentaire COA";
        GRegistCommentLine: Record "WDC-QA RegistrationCommentLine";

        Item: Record Item;
        LotNoInformationList: Page "Lot No. Information List";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //NoSeriesMgt: Codeunit "No. Series";
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
        Text001: TextConst ENU = 'Status can not be closed, because there are no %1 Registration Lines.', FRA = 'Statut ne peut pas être terminé,parce qu''il n''y a pas %1 lignes d''enregistrement.';
        Text002: TextConst ENU = 'Do you want to close this %1 Registration?', FRA = 'Voulez-vous clôturer cet enregistrement %1?';
        Text003: TextConst ENU = 'Non Conformance', FRA = 'Non conformité';
        Text004: TextConst ENU = 'has already been created for this item/lotnumber\Do you want to open this NC?', FRA = 'a déjà été créé pour cet article/numéro lot\Voulez-vous ouvrir cette NC ?';
        Text005: TextConst ENU = '&Customer, &Vendor, &Internal', FRA = '&Client, &Fournisseur, &Interne';
        Text006: TextConst ENU = 'If you change %1, the existing %2 lines will be deleted.\\', FRA = 'Si vous changez %1, les %2 lignes existantes seront supprimées.\\';
        Text007: TextConst ENU = 'Do you want to change %1?', FRA = 'Souhaitez-vous modifier la valeur du champ %1 ?';
        Text008: TextConst ENU = 'More than 1 record found. Please select by Lookup.', FRA = 'Plus qu''un enregistrement trouvé. Svp sélectionné en consultant la table.';
        CannotReleaseErr: TextConst ENU = 'The document cannot be released, because not all results have been determined yet.', FRA = '';
}
