codeunit 50500 "WDC-QC Quality Control Mgt."
{
    procedure CopySpecification(VAR SpecificationHeader: Record "WDC-QA Specification Header")
    var
        CreateSpecificationversion: Report "WDC-QACreateSpecifiVersion";
        SpecificationHeader2: Record "WDC-QA Specification Header";
    begin
        CLEAR(CreateSpecificationversion);

        SpecificationHeader2 := SpecificationHeader;
        SpecificationHeader2.SETRECFILTER;
        CreateSpecificationversion.SetParameters(SpecificationHeader2."No.");
        CreateSpecificationversion.SETTABLEVIEW(SpecificationHeader2);
        CreateSpecificationversion.RUNMODAL;
    end;

    procedure GetSpecificationLines(VAR RegistrationHeader: Record "WDC-QA Registration Header")
    var
        SpecificationHeader: Record "WDC-QA Specification Header";
        SpecificationLine: Record "WDC-QA Specification Line";
        RegistrationLine: Record "WDC-QA Registration Line";
        LineNumber: Integer;
        Counter: Integer;
        NoOfSamples: Integer;
        MeasureNo: Integer;
        lSpecificationHeader: Record "WDC-QA Specification Header";
        lCpt: Integer;
    begin
        RegistrationHeader.TESTFIELD(Status, RegistrationHeader.Status::Open);
        RegistrationLine.RESET;
        RegistrationLine.SETRANGE("Document Type", RegistrationHeader."Document Type");

        RegistrationLine.SETRANGE("Document No.", RegistrationHeader."No.");

        IF NOT RegistrationLine.ISEMPTY THEN
            IF NOT CONFIRM(Text002, FALSE) THEN
                ERROR(Text003);

        RegistrationLine.DELETEALL(TRUE);

        LineNumber := 10000;
        MeasureNo := 1;

        CASE RegistrationHeader."Document Type" OF

            RegistrationHeader."Document Type"::Calibration:
                BEGIN
                    SpecificationHeader.SETCURRENTKEY(Status);
                    SpecificationHeader.SETRANGE(Status, SpecificationHeader.Status::Certified);
                    SpecificationHeader.SETRANGE("Document Type", SpecificationHeader."Document Type"::Calibration);
                END;

            RegistrationHeader."Document Type"::QC:
                BEGIN
                    SpecificationHeader.SETCURRENTKEY("Check Point Code", "Source No.", Status, "Item Category Code", "Item No.");
                    SpecificationHeader.SETFILTER("Item Category Code", '%1|%2', '', RegistrationHeader."Item Category Code");
                    SpecificationHeader.SETFILTER("Item No.", '%1|%2', '', RegistrationHeader."Item No.");
                    SpecificationHeader.SETRANGE("Check Point Code", RegistrationHeader."Check Point Code");
                    SpecificationHeader.SETRANGE(Specific, RegistrationHeader.Specific);
                    SpecificationHeader.SETRANGE("Source No.", RegistrationHeader."Source No.");
                    SpecificationHeader.SETRANGE(Status, SpecificationHeader.Status::Certified);
                    SpecificationHeader.SETRANGE("Document Type", SpecificationHeader."Document Type"::QC);
                END;
        END;

        IF NOT SpecificationHeader.FINDSET THEN BEGIN
            IF NOT AutoCreateQC THEN
                ERROR(Text004)
            ELSE BEGIN
                SpecificationNo := '';
                EXIT;
            END;
        END;

        SpecificationNo := SpecificationHeader."No.";
        REPEAT
            SpecificationLine.SETRANGE("Document Type", SpecificationHeader."Document Type");
            SpecificationLine.SETFILTER("Document No.", SpecificationHeader."No.");
            SpecificationLine.SETFILTER("Version No.", SpecificationHeader."Version No.");
            IF SpecificationLine.FINDSET THEN
                REPEAT
                    lCpt := 1 - (SpecificationHeader."Pallet Control Frequency 1/");

                    IF SpecificationLine."No. Of Samples" <= 0 THEN
                        NoOfSamples := 1
                    ELSE
                        NoOfSamples := SpecificationLine."No. Of Samples";

                    FOR Counter := 1 TO NoOfSamples DO BEGIN
                        RegistrationLine.INIT;
                        RegistrationLine."Document No." := RegistrationHeader."No.";
                        RegistrationLine."Document Type" := RegistrationHeader."Document Type";
                        RegistrationLine."Line No." := LineNumber;

                        RegistrationLine."Specification Type" := SpecificationLine."Document Type";
                        RegistrationLine."Specification No." := SpecificationLine."Document No.";
                        RegistrationLine."Specification Version No." := SpecificationLine."Version No.";
                        RegistrationLine."Specification Line No." := SpecificationLine."Line No.";
                        RegistrationLine.VALIDATE("Parameter Code", SpecificationLine."Parameter Code");
                        RegistrationLine.VALIDATE("Method No.", SpecificationLine."Method No.");
                        RegistrationLine."Measure No." := MeasureNo;
                        RegistrationLine."Specification Remark" := SpecificationLine.Remark;
                        RegistrationLine."Lower Limit" := SpecificationLine."Lower Limit";
                        RegistrationLine."Lower Warning Limit" := SpecificationLine."Lower Warning Limit";
                        RegistrationLine."Target Result value" := SpecificationLine."Target Result Value";
                        RegistrationLine."Upper Warning Limit" := SpecificationLine."Upper Warning Limit";
                        RegistrationLine."Upper Limit" := SpecificationLine."Upper Limit";
                        RegistrationLine."QC Date" := RegistrationHeader."QC Date";
                        RegistrationLine."QC Time" := RegistrationHeader."QC Time";
                        RegistrationLine."Sample Temperature" := RegistrationHeader."Sample Temperature";
                        RegistrationLine.Controller := RegistrationHeader.Controller;
                        RegistrationLine."Target Result Option" := Enum::"WDC-QA Result Option".FromInteger(SpecificationLine."Target Result Option".AsInteger());
                        lCpt := lCpt + SpecificationHeader."Pallet Control Frequency 1/";
                        RegistrationLine."Pallet No." := lCpt;
                        RegistrationLine."Is Second Sampling" := FALSE;
                        RegistrationLine.Imprimable := SpecificationLine.Imprimable;
                        RegistrationLine.INSERT;

                        RegistrationLine.InsertRegistrationSteps;

                        LineNumber := LineNumber + 10000;

                    END;

                    MeasureNo += 1;

                UNTIL SpecificationLine.NEXT = 0;

        UNTIL SpecificationHeader.NEXT = 0;
    end;

    procedure CalculateResult(RegistrationHeader: Record "WDC-QA Registration Header")
    var
        RegistrationLine: Record "WDC-QA Registration Line";
        RegistrationStep: Record "WDC-QA Registration Step";
        Result: Option " ",Green,Orange,Red;
        ResultValue: Decimal;
    begin
        RegistrationLine.SETRANGE("Document Type", RegistrationHeader."Document Type");
        RegistrationLine.SETFILTER("Document No.", RegistrationHeader."No.");
        IF RegistrationLine.FINDSET THEN
            REPEAT

                RegistrationStep.RESET;
                RegistrationStep.SETRANGE("Document Type", RegistrationLine."Document Type");
                RegistrationStep.SETFILTER("Document No.", RegistrationLine."Document No.");
                RegistrationStep.SETRANGE("Line No.", RegistrationLine."Line No.");
                RegistrationStep.SETRANGE("Type of Measure", RegistrationLine."Type of Result");
                IF RegistrationLine."Type of Result" = RegistrationLine."Type of Result"::Option THEN
                    RegistrationStep.SETRANGE(RegistrationStep."Result Option", TRUE);
                IF RegistrationStep.FindLast() THEN BEGIN

                    IF RegistrationLine."Type of Result" = RegistrationLine."Type of Result"::Value THEN BEGIN
                        ResultValue := EvaluateExpression(RegistrationLine.Formula, RegistrationLine, RegistrationStep);

                        IF (ResultValue < RegistrationLine."Lower Limit") OR
                           (ResultValue > RegistrationLine."Upper Limit") THEN
                            Result := Result::Red;
                        IF (ResultValue >= RegistrationLine."Lower Limit") AND
                           (ResultValue <= RegistrationLine."Upper Limit") THEN
                            Result := Result::Orange;

                        IF (ResultValue >= RegistrationLine."Lower Limit") AND
                           (RegistrationLine."Upper Limit" = 0) AND
                           (RegistrationLine."Lower Limit" <> 0) THEN
                            Result := Result::Orange;


                        IF (ResultValue >= RegistrationLine."Lower Warning Limit") AND
                           (ResultValue <= RegistrationLine."Upper Warning Limit") THEN
                            Result := Result::Green;

                        IF (ResultValue >= RegistrationLine."Lower Warning Limit") AND
                           (RegistrationLine."Upper Warning Limit" = 0) AND
                           (RegistrationLine."Lower Warning Limit" <> 0) THEN
                            Result := Result::Green;

                        RegistrationLine."Result Value" := ResultValue;

                    END ELSE BEGIN
                        RegistrationLine."Result Option" := Enum::"WDC-QA Result Option".FromInteger(RegistrationStep."Option Measured".AsInteger());

                        IF (RegistrationLine."Result Option" <> RegistrationLine."Result Option"::" ") AND
                           (RegistrationLine."Target Result Option" <> RegistrationLine."Target Result Option"::" ")
                        THEN
                            IF RegistrationLine."Target Result Option" = RegistrationLine."Result Option" THEN
                                Result := Result::Green
                            ELSE
                                Result := Result::Red
                        ELSE
                            Result := Result::" ";

                    END;

                    RegistrationLine."Conclusion Result" := Enum::"WDC-QA Conclusion Result".FromInteger(Result);
                    RegistrationLine.MODIFY;

                END;

            UNTIL RegistrationLine.NEXT = 0;

        CalculateAverageResult(RegistrationHeader);
    end;

    LOCAL procedure EvaluateExpression(Expression: Text[80]; RegistrationLine: Record "WDC-QA Registration Line"; RegistrationStep: Record "WDC-QA Registration Step"): Decimal
    var
        Result: Decimal;
        Parantheses: Integer;
        Operator: Char;
        LeftOperand: Text[80];
        RightOperand: Text[80];
        LeftResult: Decimal;
        RightResult: Decimal;
        I: Integer;
        IsExpression: Boolean;
        IsFilter: Boolean;
        OperatorNo: Integer;
        Operators: text[8];
    begin
        Result := 0;

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
                LeftResult := EvaluateExpression(LeftOperand, RegistrationLine, RegistrationStep);
                RightResult := EvaluateExpression(RightOperand, RegistrationLine, RegistrationStep);
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
                    Result :=
                      EvaluateExpression(COPYSTR(Expression, 2, STRLEN(Expression) - 2),
                        RegistrationLine, RegistrationStep)
                ELSE BEGIN
                    IsFilter := (STRPOS(Expression, '..') + STRPOS(Expression, '|') + STRPOS(Expression, '<') + STRPOS(Expression, '>') + STRPOS(Expression, '&') + STRPOS(Expression, '=') > 0);
                    IF (STRLEN(Expression) > 10) AND (NOT IsFilter) THEN
                        EVALUATE(Result, Expression)
                    ELSE
                        RegistrationStep.SETRANGE("Document Type", RegistrationLine."Document Type");
                    RegistrationStep.SETFILTER("Document No.", RegistrationLine."Document No.");
                    RegistrationStep.SETRANGE("Line No.", RegistrationLine."Line No.");
                    RegistrationStep.SETRANGE("Type of Measure", RegistrationLine."Type of Result");
                    RegistrationStep.SETRANGE("Column No.", Expression);
                    IF RegistrationStep.FINDFIRST THEN BEGIN
                        Result := RegistrationStep."Value Measured"
                    END ELSE
                        IF IsFilter OR (NOT EVALUATE(Result, Expression)) THEN
                            Error(Text013, RegistrationLine, RegistrationStep);
                END;
        END;
        EXIT(Result);
    end;

    LOCAL procedure CalculateAverageResult(RegistrationHeader: Record "WDC-QA Registration Header")
    var
        RegistrationLine: Record "WDC-QA Registration Line";
        RegistrationLine2: Record "WDC-QA Registration Line";
        TotalResult: Decimal;
        ResultOption: Enum "WDC-QA RegistratResultOption";
        AvarageResult: Decimal;
        NewMeasureNo: Integer;
        OldMeasureNo: Integer;
        NumberLines: Integer;
        Result: Option " ",Green,Orange,Red;
    begin
        TotalResult := 0;
        OldMeasureNo := 9999;

        RegistrationLine.SETCURRENTKEY("Measure No.");
        RegistrationLine.SETRANGE("Document Type", RegistrationHeader."Document Type");
        RegistrationLine.SETFILTER("Document No.", RegistrationHeader."No.");
        RegistrationLine.SETFILTER("Is Second Sampling", '%1', FALSE);
        IF RegistrationLine.FINDSET THEN
            REPEAT
                NewMeasureNo := RegistrationLine."Measure No.";
                IF OldMeasureNo <> NewMeasureNo THEN BEGIN
                    TotalResult := 0;
                    AvarageResult := 0;
                    NumberLines := 0;
                    OldMeasureNo := NewMeasureNo;
                    RegistrationLine2.SETRANGE("Document Type", RegistrationLine."Document Type");
                    RegistrationLine2.SETFILTER("Document No.", RegistrationLine."Document No.");
                    RegistrationLine2.SETFILTER("Is Second Sampling", '%1', FALSE);
                    RegistrationLine2.SETFILTER("Parameter Code", '=%1', RegistrationLine."Parameter Code");
                    IF RegistrationLine2.FINDSET THEN
                        REPEAT
                            IF RegistrationLine."Type of Result" = RegistrationLine."Type of Result"::Value THEN
                                TotalResult += RegistrationLine2."Result Value";
                        UNTIL RegistrationLine2.NEXT = 0;
                    NumberLines := CountLines(RegistrationLine2);
                    IF RegistrationLine2.COUNT <> 0 THEN
                        AvarageResult := TotalResult / RegistrationLine2.COUNT;

                    IF RegistrationLine."Type of Result" = RegistrationLine."Type of Result"::Value THEN BEGIN
                        IF (AvarageResult < RegistrationLine."Lower Limit") OR
                           (AvarageResult > RegistrationLine."Upper Limit") THEN
                            Result := Result::Red;
                        IF (AvarageResult >= RegistrationLine."Lower Limit") AND
                           (AvarageResult <= RegistrationLine."Upper Limit") THEN
                            Result := Result::Orange;
                        IF (AvarageResult >= RegistrationLine."Lower Limit") AND
                           (RegistrationLine."Upper Limit" = 0) AND
                           (RegistrationLine."Lower Limit" <> 0) THEN
                            Result := Result::Orange;
                        IF (AvarageResult >= RegistrationLine."Lower Warning Limit") AND
                           (AvarageResult <= RegistrationLine."Upper Warning Limit") THEN
                            Result := Result::Green;
                        IF (AvarageResult >= RegistrationLine."Lower Warning Limit") AND
                           (RegistrationLine."Upper Warning Limit" = 0) AND
                           (RegistrationLine."Lower Warning Limit" <> 0) THEN
                            Result := Result::Green;
                    END ELSE BEGIN
                        ResultOption := ResultOption::" ";
                        Result := Result::" ";
                    END;
                END;

                IF RegistrationLine."Type of Result" = RegistrationLine."Type of Result"::Value THEN
                    RegistrationLine.VALIDATE("Average Result Value", AvarageResult)
                ELSE
                    RegistrationLine."Average Result Option" := ResultOption;

                RegistrationLine."Conclusion Average Result" := Enum::"WDC-QA Conclusion Result".FromInteger(Result);
                ;
                RegistrationLine.MODIFY;

            UNTIL RegistrationLine.NEXT <= 0;
    end;

    LOCAL procedure CountLines(pRegistrationLine: Record "WDC-QA Registration Line"): Decimal
    var
        lRegistrationStep: Record "WDC-QA Registration Step";
    begin
        lRegistrationStep.RESET;
        lRegistrationStep.SETRANGE("Document Type", pRegistrationLine."Document Type");
        lRegistrationStep.SETFILTER("Document No.", pRegistrationLine."Document No.");
        lRegistrationStep.SETRANGE(Modified, TRUE);
        lRegistrationStep.SETRANGE("Is Second Sampling", FALSE);
        EXIT(lRegistrationStep.COUNT)
    end;

    procedure GetRegistrationLines(VAR CoARegistrationHeader: Record "WDC-QA Registration Header")
    var
        QCRegistrationHeader: Record "WDC-QA Registration Header";
        CoARegistrationLine: Record "WDC-QA Registration Line";
        QCRegistrationLine: Record "WDC-QA Registration Line";
        QCRegistrationLine2: Record "WDC-QA Registration Line";
        CoARegistrationStep: Record "WDC-QA Registration Step";
        QCRegistrationStep: Record "WDC-QA Registration Step";
        CoATemplate: Record "WDC-QA CoA Template";
        NextLineNo: Integer;
        Selection: Integer;
        SearchItemNo: Code[20];
        SearchLotNo: Code[20];
    begin
        CoARegistrationHeader.TESTFIELD(Status, CoARegistrationHeader.Status::Open);
        CoARegistrationHeader.TESTFIELD("Item No.");

        Selection := STRMENU(Text001);
        IF Selection = 0 THEN EXIT;

        CoARegistrationLine.SETRANGE("Document Type", CoARegistrationHeader."Document Type");
        CoARegistrationLine.SETRANGE("Document No.", CoARegistrationHeader."No.");
        IF CoARegistrationLine.FINDLAST THEN
            NextLineNo := CoARegistrationLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;


        CoATemplate.SETRANGE("Item No.", CoARegistrationHeader."Item No.");
        IF CoATemplate.FINDSET THEN
            REPEAT

                IF CoATemplate.Type = CoATemplate.Type::Text THEN BEGIN

                    CoARegistrationLine.INIT;
                    CoARegistrationLine."Document Type" := CoARegistrationHeader."Document Type";
                    CoARegistrationLine."Document No." := CoARegistrationHeader."No.";
                    CoARegistrationLine."Line No." := NextLineNo;
                    CoARegistrationLine."Item No. EP" := CoARegistrationHeader."Item No.";
                    CoARegistrationLine."Lot No. EP" := CoARegistrationHeader."Lot No.";
                    CoARegistrationLine.Type := CoARegistrationLine.Type::Text;
                    CoARegistrationLine."Text Description" := CoATemplate.Description;
                    CoARegistrationLine.INSERT;
                    NextLineNo += 10000;
                END ELSE BEGIN

                    IF CoATemplate."Alternative Item No." <> '' THEN
                        SearchLotNoItemHF(CoARegistrationHeader, CoATemplate, SearchItemNo, SearchLotNo)
                    ELSE BEGIN
                        SearchItemNo := CoARegistrationHeader."Item No.";
                        SearchLotNo := CoARegistrationHeader."Lot No.";
                    END;
                    IF SearchLotNo = '' THEN
                        SearchLotNo := CoARegistrationHeader."Lot No.";

                    QCRegistrationHeader.SETCURRENTKEY("Item No.", "Check Point Code");
                    QCRegistrationHeader.SETFILTER("Item No.", SearchItemNo);
                    QCRegistrationHeader.SETFILTER("Check Point Code", CoATemplate."Check Point Code");
                    QCRegistrationHeader.SETFILTER("Lot No.", SearchLotNo);

                    IF QCRegistrationHeader.FINDSET THEN
                        REPEAT
                            ParameterFilter := '@' + CoATemplate."Parameter Code";
                            QCRegistrationLine.RESET;
                            QCRegistrationLine.SETFILTER("Document No.", QCRegistrationHeader."No.");
                            QCRegistrationLine.SETFILTER("Parameter Code", '%1', ParameterFilter);

                            IF Selection = 2 THEN BEGIN
                                QCRegistrationLine2.SETFILTER("Document No.", QCRegistrationHeader."No.");
                                QCRegistrationLine2.SETFILTER("Parameter Code", '%1', ParameterFilter);

                                IF QCRegistrationLine2.FINDLAST THEN
                                    QCRegistrationLine.SETRANGE("Measure No.", QCRegistrationLine2."Measure No.");
                            END;
                            IF QCRegistrationLine.FINDSET THEN
                                REPEAT
                                    CoARegistrationLine.INIT;
                                    CoARegistrationLine.TRANSFERFIELDS(QCRegistrationLine);
                                    CoARegistrationLine."Document Type" := CoARegistrationHeader."Document Type";
                                    CoARegistrationLine."Document No." := CoARegistrationHeader."No.";
                                    CoARegistrationLine."Line No." := NextLineNo;
                                    CoARegistrationLine.Type := CoATemplate.Type::Parameter;
                                    CoARegistrationLine."Item No. EP" := CoARegistrationHeader."Item No.";
                                    CoARegistrationLine."Lot No. EP" := CoARegistrationHeader."Lot No.";
                                    CoARegistrationLine."Item No. HF" := SearchItemNo;
                                    CoARegistrationLine."Lot No. HF" := SearchLotNo;
                                    CoARegistrationLine."Check Point Code" := CoATemplate."Check Point Code";
                                    CoARegistrationLine."Text Description" := CoATemplate.Description;
                                    CoARegistrationLine."CoA Type Value" := CoATemplate."Type Value";
                                    CoARegistrationLine.INSERT;
                                    NextLineNo += 10000;
                                    QCRegistrationStep.SETRANGE("Document Type", QCRegistrationLine."Document Type");
                                    QCRegistrationStep.SETFILTER("Document No.", QCRegistrationLine."Document No.");
                                    QCRegistrationStep.SETRANGE("Line No.", QCRegistrationLine."Line No.");
                                    IF QCRegistrationStep.FINDSET THEN
                                        REPEAT
                                            CoARegistrationStep.INIT;
                                            CoARegistrationStep.TRANSFERFIELDS(QCRegistrationStep);
                                            CoARegistrationStep."Document Type" := CoARegistrationLine."Document Type";
                                            CoARegistrationStep."Document No." := CoARegistrationLine."Document No.";
                                            CoARegistrationStep."Line No." := CoARegistrationLine."Line No.";
                                            CoARegistrationStep.INSERT;
                                        UNTIL QCRegistrationStep.NEXT <= 0;
                                UNTIL QCRegistrationLine.NEXT <= 0;
                        UNTIL QCRegistrationHeader.NEXT <= 0;
                END;

            UNTIL CoATemplate.NEXT <= 0;
    End;

    LOCAL procedure SearchLotNoItemHF(RegistrationHeader: Record "WDC-QA Registration Header"; CoATemplate: Record "WDC-QA CoA Template"; VAR SearchItemNo: Code[20]; VAR SearchLotNo: Code[20])
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
    begin
        SearchItemNo := CoATemplate."Alternative Item No.";
        SearchLotNo := '';

        ItemLedgerEntry.SETCURRENTKEY("Source Type", "Source No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Source Type", ItemLedgerEntry."Source Type"::Item);
        ItemLedgerEntry.SETFILTER("Source No.", RegistrationHeader."Item No.");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SETFILTER("Lot No.", RegistrationHeader."Lot No.");
        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
            ItemLedgerEntry2.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type");
            ItemLedgerEntry2.SETRANGE("Order Type", ItemLedgerEntry."Order Type");
            ItemLedgerEntry2.SETRANGE("Order No.", ItemLedgerEntry."Order No.");
            ItemLedgerEntry2.SETRANGE("Order Line No.", ItemLedgerEntry."Order Line No.");
            ItemLedgerEntry2.SETFILTER("Item No.", CoATemplate."Alternative Item No.");
            ItemLedgerEntry2.SETRANGE("Entry Type", ItemLedgerEntry2."Entry Type"::Consumption);
            IF ItemLedgerEntry2.FINDFIRST THEN
                SearchLotNo := ItemLedgerEntry2."Lot No.";
        END;
    end;

    procedure CreateSecondSamplingOKH1(VAR Rec: Record "WDC-QA Registration Line")
    var
        RegistrationLine: Record "WDC-QA Registration Line";
        RegistrationLine2: Record "WDC-QA Registration Line";
        LineNumber: Integer;
        MeasureNo: Integer;
        lRegistrationLineLineNo: Record "WDC-QA Registration Line";
        lRegistrationStep: Record "WDC-QA Registration step";
        PaletNo: Decimal;
        RegistrationLine3: Record "WDC-QA Registration Line";
        RegistrationLine1: Record "WDC-QA Registration Line";
        RegistrationLine4: Record "WDC-QA Registration Line";
    begin
        RegistrationLine.COPY(Rec);

        RegistrationLine2.SETCURRENTKEY("Parameter Code");
        RegistrationLine2.SETRANGE("Document Type", RegistrationLine."Document Type");
        RegistrationLine2.SETFILTER("Document No.", RegistrationLine."Document No.");
        RegistrationLine2.SETRANGE("Parameter Code", RegistrationLine."Parameter Code");
        RegistrationLine2.SETRANGE("Measure No.", RegistrationLine."Measure No.");
        RegistrationLine2.FINDFIRST;

        RegistrationLine3.RESET;
        RegistrationLine3.SETRANGE("Document Type", RegistrationLine."Document Type");
        RegistrationLine3.SETRANGE("Document No.", RegistrationLine."Document No.");
        IF RegistrationLine3.FINDLAST THEN;
        LineNumber := RegistrationLine3."Line No." + 10000;

        RegistrationLine4.RESET;
        RegistrationLine4.SETCURRENTKEY("Measure No.");
        RegistrationLine4.SETRANGE("Document Type", RegistrationLine."Document Type");
        RegistrationLine4.SETFILTER("Document No.", RegistrationLine."Document No.");
        RegistrationLine4.SETRANGE("Parameter Code", RegistrationLine."Parameter Code");

        RegistrationLine4.FINDLAST;
        RegistrationLine4.RESET;
        RegistrationLine4.SETCURRENTKEY("Pallet No.");
        RegistrationLine4.SETRANGE("Document Type", RegistrationLine."Document Type");
        RegistrationLine4.SETFILTER("Document No.", RegistrationLine."Document No.");
        RegistrationLine4.SETRANGE("Parameter Code", RegistrationLine."Parameter Code");

        RegistrationLine4.FINDLAST;
        PaletNo := RegistrationLine4."Pallet No." + 1;

        RegistrationLine.INIT;
        RegistrationLine.TRANSFERFIELDS(RegistrationLine2);
        RegistrationLine."Line No." := LineNumber;
        RegistrationLine."Measure No." := RegistrationLine2."Measure No.";
        RegistrationLine."Result Option" := RegistrationLine."Result Option"::" ";
        RegistrationLine."Average Result Option" := RegistrationLine."Average Result Option"::" ";
        RegistrationLine."Result Value" := 0;
        RegistrationLine."Average Result Value" := 0;
        RegistrationLine."Conclusion Result" := RegistrationLine."Conclusion Result"::" ";
        RegistrationLine."Conclusion Average Result" := RegistrationLine."Conclusion Average Result"::" ";
        RegistrationLine."Is Second Sampling" := FALSE;
        RegistrationLine."Pallet No." := PaletNo;
        RegistrationLine.INSERT;

        RegistrationLine.InsertRegistrationSteps;

        LineNumber += 10000;
    end;

    var
        SpecificationNo: Code[20];
        AutoCreateQC: Boolean;
        DivisionError: Boolean;
        ParameterFilter: Text[50];
        Text001: TextConst ENU = '&All Lines,&Second Sampling if there',
                           FRA = '&Toutes les lignes,&Deuxièmes analyses si présentes';
        Text002: TextConst ENU = 'This Registration already contain lines. If you continue\the present lines will be deleted. Do you want to continue?',
                           FRA = 'Cette enregistrement contient déjà des lignes. Si vous continuer\les lignes actuelles seront supprimées. Voulez-vous continuer?';
        Text003: TextConst ENU = 'Process is interrupped.',
                           FRA = 'Process interrompu.';
        Text004: TextConst ENU = 'No valid Specification lines are found.',
                           FRA = 'Aucune ligne de spécification valide.';
        Text013: TextConst ENU = 'You have entered an illegal value or a nonexistent column number.',
                           FRA = 'Vous avez saisi une valeur incorrecte ou un numéro de colonne inexistant.';
}

