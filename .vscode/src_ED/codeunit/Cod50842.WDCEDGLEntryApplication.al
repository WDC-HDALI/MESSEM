codeunit 50842 "WDC-ED G/L Entry Application"
{
    Permissions = TableData "G/L Entry" = rimd;

    trigger OnRun()
    begin
    end;

    procedure SetAppliesToID(var GLEntry: Record "G/L Entry"; OnlyNotApplied: Boolean)
    var
        EntryApplID: Code[50];
    begin
        GLEntry.LockTable();
        if OnlyNotApplied then begin
            GLEntry.SetFilter(Letter, '<>''''');
            GLEntry.ModifyAll("Applies-to ID", '');
            GLEntry.SetRange(Letter, '');
        end;
        if GLEntry.FindFirst then begin
            // Make Applies-to ID
            if GLEntry."Applies-to ID" <> '' then
                EntryApplID := ''
            else
                if EntryApplID = '' then begin
                    EntryApplID := UserId;
                    if EntryApplID = '' then
                        EntryApplID := '***';
                end;
            GLEntry.ModifyAll("Applies-to ID", EntryApplID);
        end;
    end;

    procedure Validate(var Entry: Record "G/L Entry")
    begin
        GLEntry.Reset();
        LetterToSet := '';
        SumPos := 0;
        SumNeg := 0;
        LetterDate := 0D;
        if not GLEntry.Get(Entry."Entry No.") then
            exit;
        if GLEntry."Applies-to ID" = '' then
            exit;
        MarkEntries;
        GetLetter;
        if SumPos + SumNeg <> 0 then
            LetterToSet := LowerCase(LetterToSet)
        else
            LetterToSet := UpperCase(LetterToSet);
        GLEntry.MarkedOnly(true);
        if GLEntry.FindSet() then
            repeat
                GLEntry.Letter := LetterToSet;
                GLEntry."Applies-to ID" := '';
                GLEntry."Letter Date" := LetterDate;
                GLEntry.Modify();
            until GLEntry.Next = 0;
        Message('%1', Text1120006);
    end;

    procedure MarkEntries()
    var
        GLEntry2: Record "G/L Entry";
        GLEntry3: Record "G/L Entry";
        Operand1: Text[10];
        Operand2: Text[10];
    begin
        GLEntry2.SetRange("G/L Account No.", GLEntry."G/L Account No.");
        GLEntry2.SetRange("Applies-to ID", GLEntry."Applies-to ID");

        if GLEntry2.FindSet() then
            repeat
                GLEntry.Get(GLEntry2."Entry No.");
                if not GLEntry.Mark then begin
                    Operand1 := UpperCase(GLEntry.Letter);
                    Operand2 := UpperCase(LetterToSet);
                    if ((Operand1 < Operand2) and (GLEntry.Letter <> '')) or
                       (LetterToSet = '')
                    then
                        LetterToSet := GLEntry.Letter;
                    if GLEntry."Posting Date" > LetterDate then
                        LetterDate := GLEntry."Posting Date";
                    GLEntry.Mark(true);
                    if GLEntry.Amount < 0 then
                        SumNeg += GLEntry.Amount
                    else
                        SumPos += GLEntry.Amount;
                    if GLEntry.Letter <> '' then begin
                        GLEntry3.SetFilter("G/L Account No.", GLEntry."G/L Account No.");
                        GLEntry3.SetFilter(Letter, GLEntry.Letter);
                        if GLEntry3.FindSet() then
                            repeat
                                GLEntry.Get(GLEntry3."Entry No.");
                                if not GLEntry.Mark then begin
                                    GLEntry.Mark(true);
                                    Operand1 := UpperCase(GLEntry.Letter);
                                    Operand2 := UpperCase(LetterToSet);
                                    if ((Operand1 < Operand2) and (GLEntry.Letter <> '')) or
                                       (LetterToSet = '')
                                    then
                                        LetterToSet := GLEntry.Letter;
                                    if GLEntry."Posting Date" > LetterDate then
                                        LetterDate := GLEntry."Posting Date";
                                    if GLEntry.Amount < 0 then
                                        SumNeg += GLEntry.Amount
                                    else
                                        SumPos += GLEntry.Amount;
                                end;
                            until GLEntry3.Next = 0;
                    end;
                end;
            until GLEntry2.Next = 0;
    end;

    procedure GetLetter()
    var
        GLEntry2: Record "G/L Entry";
    begin
        if LetterToSet <> '' then
            exit;
        GLEntry2.SetFilter("G/L Account No.", GLEntry."G/L Account No.");
        GLEntry2.SetCurrentKey("G/L Account No.", Letter);
        if GLEntry2.FindLast then
            LetterToSet := UpperCase(GLEntry2.Letter);
        NextLetter(LetterToSet);
    end;

    procedure NextLetter(var Letter: Text[10])
    begin
        case Letter of
            '':
                Letter := 'AAA';
            'AAA' .. 'ZZY':
                IncrementAlphabeticString(Letter, 1, 3);
            'ZZZ':
                Letter := 'ZZZ.000000';
            'ZZZ.000000' .. 'ZZZ.999998':
                Letter := IncStr(Letter);
            'ZZZ.999999':
                Letter := 'ZZZ.AAAAAA';
            'ZZZ.AAAAAA' .. 'ZZZ.ZZZZZY':
                IncrementAlphabeticString(Letter, 5, 10);
        end;
    end;

    local procedure IncrementAlphabeticString(var String: Text; FirstCharIndex: Integer; LastCharIndex: Integer)
    var
        i: Integer;
        TempChar: Integer;
    begin
        for i := LastCharIndex downto FirstCharIndex do
            if String[i] = 'Z' then
                String[i] := 'A'
            else begin
                TempChar := String[i];
                TempChar := TempChar + 1;
                String[i] := TempChar;
                break;
            end;
    end;

    var
        GLEntry: Record "G/L Entry";
        LetterToSet: Text[10];
        SumPos: Decimal;
        SumNeg: Decimal;
        LetterDate: Date;
        Text1120006: TextConst ENU = 'Successfully applied',
                               FRA = 'Lettrage réussi';
}

