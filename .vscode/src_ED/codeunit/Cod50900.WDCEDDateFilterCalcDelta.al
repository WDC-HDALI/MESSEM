codeunit 50900 "WDC-ED DateFilter-Calc Delta"
{
    procedure VerifMonthPeriod("Filter": Text[30])
    var
        Date: Record Date;
        FilterDate: Date;
        FilterPos: Integer;
    begin
        if CopyStr(Filter, StrLen(Filter) - 1, 2) = '..' then
            exit;
        // Begin Check
        FilterPos := StrPos(Filter, '..');

        if FilterPos = 0 then
            Error(DateInsteadOfPeriodErr);

        Evaluate(FilterDate, CopyStr(Filter, 1, FilterPos - 1));
        Date.SetRange("Period Type", Date."Period Type"::Month);
        Date.SetRange(Date."Period Start", FilterDate);
        if not Date.Find('-') then
            Error(Text10801);

        Date.Reset();
        // Ending check
        if FilterPos <> 0 then begin
            Evaluate(FilterDate, CopyStr(Filter, FilterPos + 2, 8));
            Date.SetRange("Period Type", Date."Period Type"::Month);
            Date.SetRange(Date."Period End", ClosingDate(FilterDate));
            if not Date.Find('-') then
                Error(Text10802);
        end;
    end;

    procedure VerifiyDateFilter("Filter": Text[30])
    begin
        if Filter = ',,,' then
            Error(Text10800);
    end;

    procedure ReturnEndingPeriod(StartPeriod: Date; PeriodType: Option Date,Week,Month,Quarter,Year): Date
    var
        PeriodDate: Record Date;
    begin
        PeriodDate.SetRange("Period Type", PeriodType);
        PeriodDate.SetRange("Period Start", StartPeriod);
        if PeriodDate.Find('-') then
            exit(PeriodDate."Period End")
        else
            exit(0D);
    end;

    procedure CreateFiscalYearFilter(var "Filter": Text[30]; var Name: Text[30]; Date: Date; NextStep: Integer)
    begin
        CreateAccountingDateFilter(Filter, Name, true, Date, NextStep);
    end;

    local procedure CreateAccountingDateFilter(var "Filter": Text[30]; var Name: Text[30]; FiscalYear: Boolean; Date: Date; NextStep: Integer)
    begin
        AccountingPeriod.Reset();
        if FiscalYear then
            AccountingPeriod.SetRange("New Fiscal Year", true);
        AccountingPeriod."Starting Date" := Date;
        if not AccountingPeriod.Find('=<>') then
            exit;
        if AccountingPeriod."Starting Date" > Date then
            NextStep := NextStep - 1;
        if NextStep <> 0 then
            if AccountingPeriod.Next(NextStep) <> NextStep then begin
                if NextStep < 0 then
                    Filter := '..' + Format(AccountingPeriod."Starting Date" - 1)
                else
                    Filter := Format(AccountingPeriod."Starting Date") + '..' + Format(DMY2Date(31, 12, 9999));
                Name := '...';
                exit;
            end;
        StartDate := AccountingPeriod."Starting Date";
        if FiscalYear then
            Name := StrSubstNo(Text000, Format(Date2DMY(StartDate, 3)))
        else
            Name := AccountingPeriod.Name;
        if AccountingPeriod.Next <> 0 then
            Filter := Format(StartDate) + '..' + Format(AccountingPeriod."Starting Date" - 1)
        else begin
            Filter := Format(StartDate) + '..' + Format(DMY2Date(31, 12, 9999));
            Name := Name + '...';
        end;
    end;

    var
        StartDate: Date;
        AccountingPeriod: Record "Accounting Period";
        Text000: TextConst ENU = 'Fiscal Year %1',
                           FRA = '';
        Text10800: TextConst ENU = 'The selected date is not a starting period.',
                             FRA = 'La date choisie n''est pas un début de période.';
        Text10801: TextConst ENU = 'The starting date must be the first day of a month.',
                             FRA = 'La date de début doit être le premier jour du mois.';
        Text10802: TextConst ENU = 'The ending date must be the last day of a month.',
                             FRA = 'La date de fin doit correspondre au dernier jour du mois.';
        DateInsteadOfPeriodErr: TextConst ENU = 'You must enter a date interval, such as 01.01.24..31.01.24.',
                                          FRA = 'Vous devez entrer un intervalle de temps, par exemple 01.01.24..31.01.24.';

}