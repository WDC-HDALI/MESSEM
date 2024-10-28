table 50511 "WDC-QA Method Header"
{
    CaptionML = ENU = 'Method Header', FRA = 'En-tête méthode';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA Methods";

    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    QualityControlSetup.GET;
                    NoSeriesMgt.TestManual(QualityControlSetup."Method Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; "Result Type"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Result Type', FRA = 'Type résultat';
            trigger OnValidate()
            var
                MethodLine: Record "WDC-QA Method Line";
            begin
                IF "Result Type" = "Result Type"::Option THEN BEGIN
                    "Result UOM" := '';
                    Formula := '';
                END ELSE BEGIN
                    MethodLine.SETFILTER("Document No.", "No.");
                    MethodLine.SETRANGE("Type of Measure", MethodLine."Type of Measure"::Option);
                    IF NOT MethodLine.ISEMPTY THEN
                        MethodLine.MODIFYALL(Result, FALSE);
                END;
            end;
        }
        field(4; Formula; Code[80])
        {
            CaptionML = ENU = 'Formula', FRA = 'Formule';
            trigger OnValidate()
            begin
                TESTFIELD("Result Type", "Result Type"::Value);
                CheckFormula;
                EvaluateExpression(Formula);
            end;
        }
        field(5; "Sample Quantity"; Decimal)
        {
            CaptionML = ENU = 'Sample Quantity', FRA = 'Quantité échantillon';
        }
        field(6; "Sample UOM"; Code[10])
        {
            CaptionML = ENU = 'Sample UOM', FRA = 'Unité  échantillon';
            TableRelation = "Unit of Measure";
        }
        field(7; "Result UOM"; Code[10])
        {
            CaptionML = ENU = 'Result UOM', FRA = 'Unité résultat';
            TableRelation = "Unit of Measure";
            trigger OnValidate()
            begin
                TESTFIELD("Result Type", "Result Type"::Value);
            end;
        }
        field(8; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            QualityControlSetup.GET;
            QualityControlSetup.TESTFIELD(QualityControlSetup."Method Nos.");
            NoSeriesMgt.InitSeries(QualityControlSetup."Method Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            //NoSeriesMgt.GetNextNo(QualityControlSetup."Method Nos.", 0D, true);
        END;
    end;

    trigger OnDelete()
    var
        MethodLine: Record "WDC-QA Method Line";
    begin
        CheckCoupledToParameter(TRUE);
        MethodLine.SETFILTER("Document No.", "No.");
        IF NOT MethodLine.ISEMPTY THEN
            MethodLine.DELETEALL;
    end;

    procedure AssistEdit(OldMethodHeader: Record "WDC-QA Method Header"): Boolean
    begin
        MethodHeader := Rec;
        QualityControlSetup.GET;
        QualityControlSetup.TESTFIELD("Method Nos.");
        IF NoSeriesMgt.SelectSeries(QualityControlSetup."Method Nos.", OldMethodHeader."No. Series", "No. Series") THEN BEGIN
            QualityControlSetup.GET;
            QualityControlSetup.TESTFIELD("Method Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec := MethodHeader;
            EXIT(TRUE);
        END;
    end;

    procedure CheckFormula()
    var
        i: Integer;
        ParenthesesLevel: Integer;
        HasOperator: Boolean;
    begin
        ParenthesesLevel := 0;
        FOR i := 1 TO STRLEN(Formula) DO BEGIN
            IF Formula[i] = '(' THEN
                ParenthesesLevel := ParenthesesLevel + 1
            ELSE
                IF Formula[i] = ')' THEN
                    ParenthesesLevel := ParenthesesLevel - 1;
            IF ParenthesesLevel < 0 THEN
                ERROR(Text001, i);
            IF Formula[i] IN ['+', '-', '*', '/', '^'] THEN BEGIN
                IF HasOperator THEN
                    ERROR(Text002, i)
                ELSE
                    HasOperator := TRUE;
                IF i = STRLEN(Formula) THEN
                    ERROR(Text003, i)
                ELSE
                    IF Formula[i + 1] = ')' THEN
                        ERROR(Text003, i);
            END ELSE
                HasOperator := FALSE;
        END;
        IF ParenthesesLevel > 0 THEN
            ERROR(Text004)
        ELSE
            IF ParenthesesLevel < 0 THEN
                ERROR(Text005);
    end;

    local procedure EvaluateExpression(Expression: Text[80]): Decimal
    var
        Result: Decimal;
        Parantheses: Integer;
        Operator: Char;
        LeftOperand: Text[80];
        RightOperand: text[80];
        LeftResult: Decimal;
        RightResult: Decimal;
        i: Integer;
        IsExpression: Boolean;
        IsFilter: Boolean;
        Operators: Text[8];
        OperatorNo: Integer;
        CallLevel: Integer;
        DivisionError: Boolean;
        MethodLine: record "WDC-QA Method Line";
    begin
        Result := 0;

        CallLevel := CallLevel + 1;
        IF CallLevel > 25 THEN
            ERROR(Text008);

        Expression := DELCHR(Expression, '<>', ' ');
        IF STRLEN(Expression) > 0 THEN BEGIN
            Parantheses := 0;
            IsExpression := FALSE;
            Operators := '+-*/^';
            OperatorNo := 1;
            REPEAT
                i := STRLEN(Expression);
                REPEAT
                    IF Expression[i] = '(' THEN
                        Parantheses := Parantheses + 1
                    ELSE
                        IF Expression[i] = ')' THEN
                            Parantheses := Parantheses - 1;
                    IF (Parantheses = 0) AND (Expression[i] = Operators[OperatorNo]) THEN
                        IsExpression := TRUE
                    ELSE
                        i := i - 1;
                UNTIL IsExpression OR (i <= 0);
                IF NOT IsExpression THEN
                    OperatorNo := OperatorNo + 1;
            UNTIL (OperatorNo > STRLEN(Operators)) OR IsExpression;
            IF IsExpression THEN BEGIN
                IF i > 1 THEN
                    LeftOperand := COPYSTR(Expression, 1, i - 1)
                ELSE
                    LeftOperand := '';
                IF i < STRLEN(Expression) THEN
                    RightOperand := COPYSTR(Expression, i + 1)
                ELSE
                    RightOperand := '';
                Operator := Expression[i];
                LeftResult := EvaluateExpression(LeftOperand);
                RightResult := EvaluateExpression(RightOperand);
                CASE Operator OF
                    '^':
                        Result := POWER(LeftResult, RightResult);
                    '*':
                        Result := LeftResult * RightResult;
                    '/':
                        IF RightResult = 0 THEN BEGIN
                            Result := 0;
                            DivisionError := TRUE;
                        END ELSE
                            Result := LeftResult / RightResult;
                    '+':
                        Result := LeftResult + RightResult;
                    '-':
                        Result := LeftResult - RightResult;
                END;
            END ELSE
                IF (Expression[1] = '(') AND (Expression[STRLEN(Expression)] = ')') THEN
                    Result := EvaluateExpression(COPYSTR(Expression, 2, STRLEN(Expression) - 2))
                ELSE BEGIN
                    IsFilter := (STRPOS(Expression, '..') + STRPOS(Expression, '|') + STRPOS(Expression, '<') + STRPOS(Expression, '>') + STRPOS(Expression, '&') + STRPOS(Expression, '=') > 0);
                    IF (STRLEN(Expression) > 10) AND (NOT IsFilter) THEN
                        EVALUATE(Result, Expression)
                    ELSE
                        MethodLine.SETFILTER("Document No.", "No.");
                    MethodLine.SETRANGE("Column No.", Expression);
                    IF MethodLine.ISEMPTY THEN
                        IF IsFilter OR (NOT EVALUATE(Result, Expression)) THEN
                            ERROR(Text007, Expression);
                END;

        END;
        CallLevel := CallLevel - 1;
        EXIT(Result);
    end;

    procedure CheckCoupledToParameter(ShowError: Boolean): Boolean
    var
        Parameter: Record "WDC-QA Parameter";
    begin
        Parameter.SETRANGE("Method No.", "No.");
        IF NOT Parameter.ISEMPTY THEN BEGIN
            IF ShowError THEN
                ERROR(TextSI000, TextSI001, "No.", TextSI002);
            EXIT(TRUE);
        END;
    end;

    var
        QualityControlSetup: Record "WDC-QA Quality Control Setup";
        MethodHeader: Record "WDC-QA Method Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //NoSeriesMgt: Codeunit "No. Series";
        Text001: TextConst ENU = 'The parenthesis at position %1 is misplaced.', FRA = 'Position %1. La parenthèse est mal placée.';
        Text002: TextConst ENU = 'You cannot have two consecutive operators. The error occurred at position %1.', FRA = 'Position %1. Vous ne pouvez pas avoir deux opérateurs consécutifs.';
        Text003: TextConst ENU = 'There is an operand missing after position %1.', FRA = 'Il manque un opérateur après la position %1.';
        Text004: TextConst ENU = 'There are more left parentheses than right parentheses.', FRA = 'Il y a plus de parenthèses ouvrantes que de parenthèses fermantes.';
        Text005: TextConst ENU = 'There are more right parentheses than left parentheses.', FRA = 'Il y a plus de parenthèses fermantes que de parenthèses ouvrantes.';
        Text007: TextConst ENU = 'You have entered an illegal value or a nonexistent column number (%1).', FRA = 'Vous avez enregistré une valeur non-permis ou un numéro de colonne non-existante (%1).';
        Text008: TextConst ENU = 'Because of circular references, Navision cannot calculate a formula.', FRA = 'A cause de références circulaires, Navision ne peut pas calculé une formule.';
        TextSI000: TextConst ENU = 'You can not delete %1 %2, because there is at least one %3 for this %1.', FRA = 'Vous ne pouvez pas supprimer %1 %2, car il existe au moins une %3 pour ce %1.';
        TextSI001: TextConst ENU = 'QC-Method', FRA = 'Méthode CQ';
        TextSI002: TextConst ENU = 'QC-Parameter', FRA = 'Paramètre CQ';

}
