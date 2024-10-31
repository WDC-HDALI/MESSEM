table 50503 "WDC-QA Specification Line"
{
    CaptionML = ENU = 'Specification Line', FRA = 'Ligne spécification';
    DataClassification = ToBeClassified;

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
            TableRelation = if ("Version No." = filter(<> '')) "WDC-QA Specification Header"."No." where("Document Type" = field("Document Type"),
                                                            "Version No." = field("Version No."))
            else
            "WDC-QA Specification Header"."No." where("Document Type" = field("Document Type"));
        }
        field(3; "Version No."; Code[20])
        {
            CaptionML = ENU = 'Version No.', FRA = 'N° version';
        }
        field(4; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        field(5; "Parameter Description"; Text[30])
        {
            CaptionML = ENU = 'Parameter Description', FRA = 'Déscription paramètre';
        }
        field(6; "Parameter Group Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Group Code', FRA = 'Code groupe paramètre';
            TableRelation = "WDC-QA Parameter Group".Code;
            Editable = false;
        }
        field(7; "Method No."; Code[20])
        {
            CaptionML = ENU = 'Method No.', FRA = 'N° méthode';
            TableRelation = "WDC-QA Method Header";
            trigger OnValidate()
            var
                MethodHeader: Record "WDC-QA Method Header";
            begin
                TestStatusOpen;
                IF MethodHeader.GET("Method No.") THEN;
                "Method Description" := MethodHeader.Description;
                VALIDATE("Type of Result", MethodHeader."Result Type");
                Formula := MethodHeader.Formula;
                "Sample Quantity" := MethodHeader."Sample Quantity";
                "Sample UOM" := MethodHeader."Sample UOM";
                "Result UOM" := MethodHeader."Result UOM";

                DeletSpecificationSteps;
                InsertSpecificationStaps;
            end;
        }
        field(8; "Method Description"; Text[30])
        {
            CaptionML = ENU = 'Method Description', FRA = 'Déscription méthode';
            Editable = false;
        }
        field(9; "Type Of Result"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Type Of Result', FRA = 'Type de résultat';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Type of Result" = "Type of Result"::Option THEN BEGIN
                    "Lower Limit" := 0;
                    "Lower Warning Limit" := 0;
                    "Target Result Value" := 0;
                    "Upper Warning Limit" := 0;
                    "Upper Limit" := 0;
                END ELSE
                    "Target Result Option" := "Target Result Option"::" ";
            end;
        }
        field(10; Formula; Code[80])
        {
            CaptionML = ENU = 'Formula', FRA = 'Formule';
            Editable = false;
        }
        field(11; "Sample Quantity"; Decimal)
        {
            CaptionML = ENU = 'Sample Quantity', FRA = 'Quantité échantillon';
            Editable = false;
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(12; "Sample UOM"; Code[10])
        {
            CaptionML = ENU = 'Sample UOM', FRA = 'Unité échantillon';
            Editable = false;
        }
        field(13; "No. Of Samples"; Integer)
        {
            CaptionML = ENU = 'No. Of Samples', FRA = 'Nombre de mesures';
            InitValue = 1;
            MinValue = 1;
            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(14; "Lower Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Limit', FRA = 'Limite inférieure';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Value);
            end;
        }
        field(15; "Lower Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Lower Warning Limit', FRA = 'Limite d''avertissement inférieure';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Value);
            end;
        }
        field(16; "Target Result Value"; Decimal)
        {
            CaptionML = ENU = 'Target Result Value', FRA = 'Valeur résultat cible';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Value);
            end;
        }
        field(17; "Upper Warning Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Warning Limit', FRA = 'Limite d''avertissement supérieure';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Value);
            end;
        }
        field(18; "Upper Limit"; Decimal)
        {
            CaptionML = ENU = 'Upper Limit', FRA = 'Limite supérieure';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Value);
            end;
        }
        field(19; "Target Result Option"; Enum "WDC-QA RegistratResultOption")
        {
            CaptionML = ENU = 'Target Result Option', FRA = 'Option résultat cible';
            trigger OnValidate()
            begin
                TestStatusOpen;
                TESTFIELD("Type of Result", "Type of Result"::Option);
            end;
        }
        field(20; "Result UOM"; Code[10])
        {
            CaptionML = ENU = 'Result UOM', FRA = 'Unité résultat';
            Editable = false;
        }
        field(21; Remark; Text[80])
        {
            CaptionML = ENU = 'Remark', FRA = 'Remarque';
            trigger OnValidate()
            begin
                TestStatusOpen;
            end;
        }
        field(22; "Parameter Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Code', FRA = 'Code paramètre';
            TableRelation = IF ("Document Type" = CONST(Calibration)) "WDC-QA Parameter".Code WHERE(Type = CONST(Calibration))
            ELSE IF ("Document Type" = CONST(QC)) "WDC-QA Parameter".Code WHERE(Type = filter('Spécification CQ'));
            trigger OnValidate()
            var
                Parameter: Record "WDC-QA Parameter";
            begin
                TestStatusOpen;
                IF Parameter.GET("Document Type", "Parameter Code") THEN;
                "Parameter Description" := Parameter.Description;
                "Parameter Group Code" := Parameter."Parameter Group Code";
                VALIDATE("Method No.", Parameter."Method No.");
            end;
        }

        field(24; "Texte Specification Option"; Text[30])
        {
            Caption = 'Texte Specification Option';
        }
        field(25; Imprimable; Option)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimable';
            OptionMembers = Oui,Non;
            OptionCaptionML = ENU = 'Yes,No', FRA = 'Oui,Non';

        }
        field(26; Type; Enum "WDC-QA Spec Line Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Version No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        TestStatusOpen;
        InsertSpecificationStaps;
    end;

    trigger OnDelete()
    begin
        TestStatusOpen;
        DeletSpecificationSteps;
    end;

    Local procedure TestStatusOpen()
    begin
        IF StatusCheckSuspended THEN
            EXIT;

        GetSpecificationHeader;
        SpecificationHeader.TESTFIELD(Status, SpecificationHeader.Status::Open);
    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        StatusCheckSuspended := Suspend;
    end;

    local procedure GetSpecificationHeader()
    begin
        TESTFIELD("Document No.");

        IF ("Document Type" <> SpecificationHeader."Document Type") OR ("Document No." <> SpecificationHeader."No.") OR
           ("Version No." <> SpecificationHeader."Version No.") THEN
            SpecificationHeader.GET("Document Type", "Document No.", "Version No.");
    end;

    procedure InsertSpecificationStaps()
    var
        LineNumber: Integer;
        MethodLine: Record "WDC-QA Method Line";
    begin
        IF "Method No." = '' THEN
            EXIT;
        LineNumber := 10000;
        MethodLine.SETFILTER("Document No.", "Method No.");
        IF MethodLine.FINDSET THEN
            REPEAT
                SpecificationStep.INIT;
                SpecificationStep."Document Type" := "Document Type";
                SpecificationStep."Document No." := "Document No.";
                SpecificationStep."Version No." := "Version No.";
                SpecificationStep."Line No." := "Line No.";
                SpecificationStep."Step Line No." := LineNumber;
                SpecificationStep."Method No." := MethodLine."Document No.";
                SpecificationStep."Method Line No." := MethodLine."Line No.";
                SpecificationStep."Column No." := MethodLine."Column No.";
                SpecificationStep."Measurement Code" := MethodLine."Measurement Code";
                SpecificationStep.Description := MethodLine.Description;
                SpecificationStep."Equipment Group" := MethodLine."Equipment Group Code";
                SpecificationStep."Type of Measure" := MethodLine."Type of Measure";
                SpecificationStep."Value UOM" := MethodLine."Value UOM";
                SpecificationStep.Sample := MethodLine.Sample;
                SpecificationStep."Method Remark" := MethodLine.Remark;
                SpecificationStep."Result Option" := MethodLine.Result;
                SpecificationStep.INSERT;

                LineNumber += 10000;
            UNTIL MethodLine.NEXT <= 0;
    end;

    procedure DeletSpecificationSteps()
    begin
        SpecificationStep.SETRANGE("Document Type", "Document Type");
        SpecificationStep.SETFILTER("Document No.", "Document No.");
        SpecificationStep.SETFILTER("Version No.", "Version No.");
        SpecificationStep.SETRANGE("Line No.", "Line No.");
        IF NOT SpecificationStep.ISEMPTY THEN
            SpecificationStep.DELETEALL;
    end;

    var
        StatusCheckSuspended: Boolean;
        MethodLine: Record "WDC-QA Method Line";
        SpecificationStep: Record "WDC-QA Specification Step";
        SpecificationHeader: Record "WDC-QA Specification Header";
}
