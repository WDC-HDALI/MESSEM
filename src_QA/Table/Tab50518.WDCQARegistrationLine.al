table 50518 "WDC-QA Registration Line"
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
            trigger OnValidate()
            var
                Parameter: Record "WDC-QA Parameter";
                TmpRegistrationLine: Record "WDC-QA Registration Line";
            begin
                TmpRegistrationLine := Rec;
                INIT;
                "Parameter Code" := TmpRegistrationLine."Parameter Code";
                IF "Parameter Code" = '' THEN
                    EXIT;

                IF CurrFieldNo <> FIELDNO("Parameter Code") THEN BEGIN
                    "Specification Type" := TmpRegistrationLine."Specification Type";
                    "Specification No." := TmpRegistrationLine."Specification No.";
                    "Specification Version No." := TmpRegistrationLine."Specification Version No.";
                    "Specification Line No." := TmpRegistrationLine."Specification Line No.";
                END;

                IF Parameter.GET("Document Type", "Parameter Code") THEN;
                "Parameter Description" := Parameter.Description;
                "Parameter Group Code" := Parameter."Parameter Group Code";

                IF RegistrationHeader.GET("Document Type", "Document No.") THEN
                    "Check Point Code" := RegistrationHeader."Check Point Code"
                ELSE
                    "Check Point Code" := '';

                VALIDATE("Method No.", Parameter."Method No.");
            end;
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
            trigger OnValidate()
            var
                MethodHeader: Record "WDC-QA Method Header";
            begin
                IF MethodHeader.GET("Method No.") THEN;
                "Method Description" := MethodHeader.Description;
                "Type of Result" := MethodHeader."Result Type";
                Formula := MethodHeader.Formula;
                "Sample Quantity" := MethodHeader."Sample Quantity";
                "Sample UOM" := MethodHeader."Sample UOM";
                "Result Value UOM" := MethodHeader."Result UOM";

                IF CurrFieldNo = FIELDNO("Method No.") THEN BEGIN
                    "Specification No." := '';
                    "Specification Version No." := '';
                    "Specification Line No." := 0;
                END;

                IF "Method No." <> xRec."Method No." THEN
                    DeleteRegistrationSteps;
            end;
        }
        field(8; "Method Description"; Text[30])
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
            trigger OnValidate()
            var
                RegistrationStep: Record "WDC-QA Registration Step";
            begin
                IF CurrFieldNo = FIELDNO("Measure No.") THEN BEGIN
                    RegistrationStep.SETRANGE("Document Type", "Document Type");
                    RegistrationStep.SETRANGE("Document No.", "Document No.");
                    RegistrationStep.SETRANGE("Line No.", "Line No.");
                    IF NOT RegistrationStep.ISEMPTY THEN
                        RegistrationStep.MODIFYALL("Measure No.", "Measure No.");
                END;
            end;
        }
        field(11; "Sample Quantity"; Decimal)
        {
            CaptionML = ENU = 'Sample Quantity', FRA = 'Quantité échantillon';
            Editable = false;
        }
        field(12; "Sample UOM"; Code[10])
        {
            CaptionML = ENU = 'Sample UOM', FRA = 'Unité  échantillon';
            Editable = false;
        }
        field(13; "Lower Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Limit', FRA = 'Limite inférieure';
        }
        field(14; "Lower Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Warning Limit', FRA = 'Limite d''avertissement inférieure';
        }
        field(15; "Target Result value"; Decimal)
        {
            CaptionML = ENU = 'Target Result value', FRA = 'Valeur résultat cible';
        }
        field(16; "Upper Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Warning Limit', FRA = 'Limite d''avertissement supérieure';
        }
        field(17; "Upper Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Limit', FRA = 'Limite supérieure';
        }
        field(18; "Result Option"; Enum "WDC-QA RegistratResultOption")
        {
            CaptionML = ENU = 'Result Option', FRA = 'Option résultat';
            //ValuesAllowed=1,2;
            trigger OnValidate()
            var
                lRegistrationStep: Record "WDC-QA Registration Step";
            begin
                TESTFIELD("Type of Result", "Type of Result"::Option);
                lRegistrationStep.RESET;
                lRegistrationStep.SETRANGE("Document Type", "Document Type");
                lRegistrationStep.SETRANGE("Document No.", "Document No.");
                lRegistrationStep.SETRANGE("Line No.", "Line No.");
                IF lRegistrationStep.FINDFIRST THEN BEGIN
                    lRegistrationStep.Modified := TRUE;
                    lRegistrationStep.MODIFY;
                END;
            end;
        }
        field(19; "Average Result Option"; Enum "WDC-QA RegistratResultOption")
        {
            CaptionML = ENU = 'Average Result Option', FRA = 'Option résultat moyen';
            Editable = false;
        }
        field(20; "Result Value"; Decimal)
        {
            CaptionML = ENU = 'Result Value', FRA = 'Valeur résultat';
            trigger OnValidate()
            var
                lRegistrationStep: Record "WDC-QA Registration Step";
            begin
                TESTFIELD("Type of Result", "Type of Result"::Value);
                lRegistrationStep.RESET;
                lRegistrationStep.SETRANGE("Document Type", "Document Type");
                lRegistrationStep.SETRANGE("Document No.", "Document No.");
                lRegistrationStep.SETRANGE("Line No.", "Line No.");
                IF lRegistrationStep.FINDFIRST THEN BEGIN
                    lRegistrationStep.Modified := TRUE;
                    lRegistrationStep.MODIFY;
                END;
                IF xRec."Average Result Option" <> Rec."Average Result Option" THEN BEGIN
                    "Control Date Average result" := CURRENTDATETIME;
                END;
            end;
        }
        field(21; "Result Value UOM"; Code[10])
        {
            CaptionML = ENU = 'Result Value UOM', FRA = 'Unité valeur résultat';
            Editable = false;
        }
        field(22; "Average Result Value"; Decimal)
        {
            CaptionML = ENU = 'Average Result Value', FRA = 'Valeur résultat moyen';
            trigger OnValidate()
            begin
                IF xRec."Average Result Value" <> "Average Result Value" THEN BEGIN
                    "Control Date Average result" := CURRENTDATETIME;
                END;
            end;
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
        }
        field(28; "Controller"; Code[20])
        {
            CaptionML = ENU = 'Controller', FRA = 'Controleur';
            //TableRelation="QC Controller";
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
        field(32; "Target Result Option"; Enum "WDC-QA RegistratResultOption")
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
        field(47; "Imprimable"; Boolean)
        {
            CaptionML = ENU = 'Imprimable', FRA = 'Imprimable';
        }
        field(48; "Pallet No."; Integer)
        {
            CaptionML = ENU = 'Pallet No.', FRA = 'N° palette';
        }
        field(49; "Is Second Sampling"; Boolean)
        {
            CaptionML = ENU = 'Is Second Sampling', FRA = 'Is Second Sampling';
        }
        field(52; "Control Date"; DateTime)
        {
            CaptionML = ENU = 'Control Date', FRA = 'Date de control ';
        }
        field(53; "User Code"; Code[50])
        {
            CaptionML = ENU = 'User Code', FRA = 'Code utilisateur';
            Editable = false;
        }
        field(54; "Control Date Average result"; DateTime)
        {
            CaptionML = ENU = 'Control Date Average result', FRA = 'Date résultat moyen';
            Editable = false;
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
        key(Key3; "Pallet No.")
        { }
    }
    trigger OnInsert()
    begin
        InsertRegistrationSteps;
    end;

    trigger OnModify()
    begin
        IF "Method No." <> xRec."Method No." THEN
            InsertRegistrationSteps;
        IF (xRec."Average Result Value" <> Rec."Average Result Value") THEN BEGIN
            "Control Date Average result" := CURRENTDATETIME;
        END;
        IF (xRec."Result Option" <> "Result Option") OR (xRec."Result Value" <> "Result Value") THEN BEGIN
            "Control Date" := CURRENTDATETIME;
            "User Code" := USERID;
        END;
    end;

    trigger OnDelete()
    begin
        DeleteRegistrationSteps;
    end;

    procedure InsertRegistrationSteps()
    var
        LineNumber: Integer;
    //Equipment: Record "WDC-QA Equipment";
    begin
        IF "Method No." = '' THEN
            EXIT;

        LineNumber := 10000;

        IF "Measure No." = 0 THEN
            "Measure No." := GetNextMeasureNo();

        IF "Specification No." <> '' THEN BEGIN
            SpecificationStep.SETRANGE("Document Type", "Specification Type");
            SpecificationStep.SETFILTER("Document No.", "Specification No.");
            SpecificationStep.SETFILTER("Version No.", "Specification Version No.");
            SpecificationStep.SETRANGE("Line No.", "Specification Line No.");
            IF SpecificationStep.FINDSET THEN
                REPEAT
                    RegistrationStep.INIT;
                    RegistrationStep."Document Type" := "Document Type";
                    RegistrationStep."Document No." := "Document No.";
                    RegistrationStep."Line No." := "Line No.";
                    RegistrationStep."Step Line No." := LineNumber;

                    RegistrationStep."Measure No." := "Measure No.";
                    RegistrationStep."Method No." := SpecificationStep."Method No.";
                    RegistrationStep."Method Line No." := SpecificationStep."Method Line No.";
                    RegistrationStep."Column No." := SpecificationStep."Column No.";
                    RegistrationStep."Equipment Group Code" := SpecificationStep."Equipment Group";
                    //RegistrationStep."Equipment No." := SpecificationStep."Equipment No.";
                    // IF Equipment.GET(SpecificationStep."Equipment No.") THEN BEGIN
                    //     IF (Equipment.Blocked) THEN BEGIN
                    //         MESSAGE(Text0001, Equipment."No.");
                    //         RegistrationStep."Equipment No." := '';
                    //     END ELSE BEGIN
                    //         IF Equipment.CalibrationRequired(FALSE) THEN
                    //             MESSAGE(Text0002, Equipment."No.");
                    //     END;
                    // END;
                    RegistrationStep."Type of Measure" := SpecificationStep."Type of Measure";
                    RegistrationStep."Value UOM" := SpecificationStep."Value UOM";
                    RegistrationStep.Sample := SpecificationStep.Sample;
                    RegistrationStep."Method Remark" := SpecificationStep."Method Remark";
                    RegistrationStep."Result Option" := SpecificationStep."Result Option";
                    RegistrationStep."Measurement Code" := SpecificationStep."Measurement Code";
                    RegistrationStep."Measurement Description" := SpecificationStep.Description;
                    RegistrationStep.INSERT;

                    LineNumber += 10000;
                UNTIL SpecificationStep.NEXT <= 0;
        END ELSE BEGIN
            MethodLine.SETFILTER("Document No.", "Method No.");
            IF MethodLine.FINDSET THEN
                REPEAT
                    RegistrationStep.INIT;
                    RegistrationStep."Document Type" := "Document Type";
                    RegistrationStep."Document No." := "Document No.";
                    RegistrationStep."Line No." := "Line No.";
                    RegistrationStep."Step Line No." := LineNumber;

                    RegistrationStep."Measure No." := "Measure No.";
                    RegistrationStep."Method No." := MethodLine."Document No.";
                    RegistrationStep."Method Line No." := MethodLine."Line No.";
                    RegistrationStep."Column No." := MethodLine."Column No.";
                    RegistrationStep."Equipment Group Code" := MethodLine."Equipment Group Code";
                    RegistrationStep."Type of Measure" := MethodLine."Type of Measure";
                    RegistrationStep."Value UOM" := MethodLine."Value UOM";
                    RegistrationStep.Sample := MethodLine.Sample;
                    RegistrationStep."Method Remark" := MethodLine.Remark;
                    RegistrationStep."Result Option" := MethodLine.Result;
                    RegistrationStep."Measurement Code" := MethodLine."Measurement Code";
                    RegistrationStep."Measurement Description" := MethodLine.Description;
                    RegistrationStep.INSERT;

                    LineNumber += 10000;
                UNTIL MethodLine.NEXT <= 0;
        END;
    end;

    procedure DeleteRegistrationSteps()
    begin
        RegistrationStep.SETRANGE("Document Type", "Document Type");
        RegistrationStep.SETFILTER("Document No.", "Document No.");
        RegistrationStep.SETRANGE("Line No.", "Line No.");
        IF NOT RegistrationStep.ISEMPTY THEN
            RegistrationStep.DELETEALL;
    end;

    procedure GetNextMeasureNo(): Integer
    var
        RegistrationLine: Record "WDC-QA Registration Line";
    begin
        RegistrationLine.SETCURRENTKEY("Measure No.");
        RegistrationLine.SETRANGE("Document Type", "Document Type");
        RegistrationLine.SETRANGE("Document No.", "Document No.");
        IF RegistrationLine.FINDLAST THEN
            EXIT(RegistrationLine."Measure No." + 1)
        ELSE
            EXIT(1);
    end;

    procedure GetStepCounts(ModifiedStepCountLine: Integer; MaxStepCountLine: Integer; ModifiedStepCountHeader: Integer; MaxStepCountHeader: Integer)
    var
        RegistrationStep: Record "WDC-QA Registration Step";
        RegistrationHeader: Record "WDC-QA Registration Header";
    begin
        RegistrationStep.SETRANGE("Document Type", "Document Type");
        RegistrationStep.SETRANGE("Document No.", "Document No.");
        RegistrationStep.SETRANGE("Line No.", "Line No.");

        MaxStepCountLine := RegistrationStep.COUNT;

        RegistrationStep.SETRANGE(Modified, TRUE);
        ModifiedStepCountLine := RegistrationStep.COUNT;

        IF RegistrationHeader.GET("Document Type", "Document No.") THEN
            RegistrationHeader.GetStepCounts(ModifiedStepCountHeader, MaxStepCountHeader);
    end;

    var
        RegistrationHeader: Record "WDC-QA Registration Header";
        RegistrationStep: Record "WDC-QA Registration Step";
        SpecificationStep: Record "WDC-QA Specification Step";
        MethodLine: Record "WDC-QA Method Line";
        Text0001: TextConst ENU = 'Equipment %1 is blocked.', FRA = 'Equipement %1 est bloqué.';
        Text0002: TextConst ENU = 'Equipment %1 requires calibration.', FRA = 'Equipement %1 nécessite une calibration.';
        Text0003: TextConst ENU = '', FRA = 'Etes vous sûr de vouloir supprimer les lignes d''enregistrement CQ %1';
}
