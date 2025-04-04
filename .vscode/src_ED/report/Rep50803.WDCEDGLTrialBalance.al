report 50803 "WDC-ED G/L Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_ED/report/RDLC/GLTrialBalance.rdl';
    ApplicationArea = All;
    CaptionML = ENU = 'G/L Trial Balance', FRA = 'Balance comptes généraux';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyAdr; CompanyInfo.Address)
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyVAT; CompanyInfo."VAT Registration No.")
            {
            }
            column(PreviousStartDateText; StrSubstNo(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; StrSubstNo(Text005, ''))
            {
            }
            column(UserCaption; StrSubstNo(Text003, ''))
            {
            }
            column(GLAccTableCaptionFilter; "G/L Account".TableCaption + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(Name_GLAcc; Name)
            {
            }
            column(GLAcc2DebitAmtCreditAmt; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(GLAcc2CreditAmtDebitAmt; GLAccount2."Credit Amount" - GLAccount2."Debit Amount")
            {
            }
            column(DebitAmt_GLAcc; "Debit Amount")
            {
            }
            column(CreditAmt_GLAcc; "Credit Amount")
            {
            }
            column(BalAtEndingDateDebitCaption; GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount")
            {
            }
            column(BalAtEndingDateCreditCaption; GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount")
            {
            }
            column(TLAccType; TLAccountType)
            {
            }
            column(GLTrialBalCaption; GLTrialBalCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(BalAtStartingDateCaption; BalAtStartingDateCaptionLbl)
            {
            }
            column(BalDateRangeCaption; BalDateRangeCaptionLbl)
            {
            }
            column(BalAtEndingdateCaption; BalAtEndingdateCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(TotalMouvDebit; TotalMouvDebit)
            {
            }
            column(TotalMouvCredit; TotalMouvCredit)
            {
            }
            column(TotBalanceDebit; TotBalanceDebit)
            {
            }
            column(TotBalanceCredit; TotBalanceCredit)
            {
            }
            column(TotBilanDebit; TotBilanDebit)
            {
            }
            column(TotBilanCredit; TotBilanCredit)
            {
            }
            column(TotMovBilanDebit; TotMovBilanDebit)
            {
            }
            column(TotMovBilanCredit; TotMovBilanCredit)
            {
            }

            column(TotalDebit; SoldeDebit)
            {
            }
            column(TotalCredit; SoldeCredit)
            {
            }


            trigger OnAfterGetRecord()
            begin
                GLAccount2.Copy("G/L Account");
                if GLAccount2."Income/Balance" = 0 then begin
                    GLAccount2.SetRange("Date Filter", PreviousStartDate, PreviousEndDate);
                    GLAccount2.CalcFields("Debit Amount", "Credit Amount");
                end else begin
                    GLAccount2.SetRange("Date Filter", 0D, PreviousEndDate);
                    GLAccount2.CalcFields("Debit Amount", "Credit Amount");
                end;
                if not ImprNonMvt and
                   (GLAccount2."Debit Amount" = 0) and
                   ("Debit Amount" = 0) and
                   (GLAccount2."Credit Amount" = 0) and
                   ("Credit Amount" = 0)
                then
                    CurrReport.Skip();

                if "Debit Amount" < 0 then begin
                    "Credit Amount" += -"Debit Amount";
                    "Debit Amount" := 0;
                end;
                if "Credit Amount" < 0 then begin
                    "Debit Amount" += -"Credit Amount";
                    "Credit Amount" := 0;
                end;

                TLAccountType := "G/L Account"."Account Type".AsInteger();
                //>> Calcul Compte Bilan + Compte Gestion

                // Calcul Compte Bilan
                IF (GLAccount2."Account Type".AsInteger() = 0) AND (GLAccount2."Income/Balance" = 1)
                THEN BEGIN
                    IF (GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount") > 0 THEN
                        TotBilanDebit := GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount"
                    ELSE
                        TotBilanDebit := 0;
                    IF (GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount") > 0 THEN
                        TotBilanCredit := GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount"
                    ELSE
                        TotBilanCredit := 0;
                    IF "Debit Amount" > 0 THEN
                        TotMovBilanDebit := "Debit Amount"
                    ELSE
                        TotMovBilanDebit := 0;
                    IF "Credit Amount" > 0 THEN
                        TotMovBilanCredit := "Credit Amount"
                    ELSE
                        TotMovBilanCredit := 0;
                    IF (GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount") > 0 THEN
                        TotalSoldeBilanDebit := (GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
                    ELSE
                        TotalSoldeBilanDebit := 0;
                    IF (GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount") > 0 THEN
                        TotalSoldeBilanCredit := GLAccount2."Credit Amount" - GLAccount2."Debit Amount"
                    ELSE
                        TotalSoldeBilanCredit := 0;
                END ELSE BEGIN
                    TotBilanDebit := 0;
                    TotBilanCredit := 0;
                    TotMovBilanDebit := 0;
                    TotMovBilanCredit := 0;
                    TotalSoldeBilanDebit := 0;
                    TotalSoldeBilanCredit := 0;
                END;

                //Calcul Compte Gestion

                IF ("G/L Account"."Account Type".AsInteger() = 0) AND ("G/L Account"."Income/Balance" = 0)
                THEN BEGIN
                    IF ("Debit Amount" - "Credit Amount") > 0 THEN
                        TotGestionDebit := GLAccount2."Debit Amount" + "Debit Amount" - GLAccount2."Credit Amount" - "Credit Amount"
                    ELSE
                        TotGestionDebit := 0;
                    IF ("Credit Amount" - "Debit Amount") > 0 THEN
                        TotGestionCredit := GLAccount2."Credit Amount" + "Credit Amount" - GLAccount2."Debit Amount" - "Debit Amount"
                    ELSE
                        TotGestionCredit := 0;
                    IF "Debit Amount" > 0 THEN
                        TotMovGestionDebit := "Debit Amount"
                    ELSE
                        TotMovGestionDebit := 0;
                    IF "Credit Amount" > 0 THEN
                        TotMovGestionCredit := "Credit Amount"
                    ELSE
                        TotMovGestionCredit := 0;
                    IF ("Debit Amount" - "Credit Amount") > 0 THEN
                        TotalSoldeGestionDebit := (GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
                    ELSE
                        TotalSoldeGestionDebit := 0;
                    IF ("Credit Amount" - "Debit Amount") > 0 THEN
                        TotalSoldeGestionCredit := GLAccount2."Credit Amount" - GLAccount2."Debit Amount"
                    ELSE
                        TotalSoldeGestionCredit := 0;
                END ELSE BEGIN
                    TotGestionDebit := 0;
                    TotGestionCredit := 0;
                    TotMovGestionDebit := 0;
                    TotMovGestionCredit := 0;
                    TotalSoldeGestionDebit := 0;
                    TotalSoldeGestionCredit := 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                if GetFilter("Date Filter") = '' then
                    Error(Text001, FieldCaption("Date Filter"));
                if CopyStr(GetFilter("Date Filter"), 1, 1) = '.' then
                    Error(Text002);
                StartDate := GetRangeMin("Date Filter");
                PreviousEndDate := ClosingDate(StartDate - 1);
                DateFilterCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := ConvertStr(TextDate, '.', ',');
                DateFilterCalc.VerifiyDateFilter(TextDate);
                TextDate := CopyStr(TextDate, 1, 8);
                Evaluate(PreviousStartDate, TextDate);
                FiscalYearStatusText := StrSubstNo(Text007, FiscalYearFiscalClose.CheckFiscalYearStatus(GetFilter("Date Filter")));
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    captionML = ENU = 'Options', FRA = 'Options';
                    field(PrintGLAccsWithoutBalance; ImprNonMvt)
                    {
                        ApplicationArea = All;
                        captionML = ENU = 'Print G/L Accs. without balance', FRA = 'Impr. cptes non mouvementés';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
    end;



    trigger OnPreReport()
    begin
        Filter := "G/L Account".GetFilters;
    end;



    var
        CompanyInfo: Record 79;
        GLAccount2: Record "G/L Account";
        // DateFilterCalc: Codeunit "DateFilter-Calc";
        DateFilterCalc: Codeunit "WDC-ED DateFilter-Calc Delta";
        FiscalYearFiscalClose: Codeunit "WDC-ED Fiscal Year-FiscalClose";
        StartDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        ImprNonMvt: Boolean;
        "Filter": Text;
        FiscalYearStatusText: Text;
        TLAccountType: Integer;
        TotalSoldeBilanDebit: Decimal;
        TotalSoldeBilanCredit: Decimal;
        TotGestionDebit: Decimal;
        TotGestionCredit: Decimal;
        TotMovGestionDebit: Decimal;
        TotMovGestionCredit: Decimal;
        TotalSoldeGestionDebit: Decimal;
        TotalSoldeGestionCredit: Decimal;
        TotalMouvDebit: Decimal;
        TotalMouvCredit: Decimal;
        TotBalanceDebit: Decimal;
        TotBalanceCredit: Decimal;

        TotBilanDebit: Decimal;
        TotBilanCredit: Decimal;
        TotMovBilanDebit: Decimal;
        TotMovBilanCredit: Decimal;

        SoldeDebit: Decimal;
        SoldeCredit: Decimal;
        Text001: TextConst ENU = 'You must fill in the %1 field.',
                           FRA = 'Vous devez renseigner le champ %1.';
        Text002: TextConst ENU = 'You must specify a Starting Date.',
                           FRA = 'Vous devez spécifier une date de début.';
        Text003: TextConst ENU = 'Printed by %1',
                           FRA = 'Imprimé par %1';
        Text004: TextConst ENU = 'Fiscal Year Start Date : %1',
                           FRA = 'Début exercice comptable : %1';
        Text005: TextConst ENU = 'Page %1',
                           FRA = 'Page %1';
        Text007: TextConst ENU = 'Fiscal-Year Status: %1',
                           FRA = 'Statut de l''exercice comptable : %1';
        GLTrialBalCaptionLbl: TextConst ENU = 'G/L Trial Balance',
                                        FRA = 'Balance comptes généraux';
        NoCaptionLbl: TextConst ENU = 'No.',
                                FRA = 'N°';
        NameCaptionLbl: TextConst ENU = 'Name',
                                  FRA = 'Nom';
        BalAtStartingDateCaptionLbl: TextConst ENU = 'Balance at Starting Date',
                                               FRA = 'Solde à la date de début';
        BalDateRangeCaptionLbl: TextConst ENU = 'Balance Date Range',
                                          FRA = 'Solde plage de dates';
        BalAtEndingdateCaptionLbl: TextConst ENU = 'Balance at Ending date',
                                             FRA = 'Solde à la date de fin';
        DebitCaptionLbl: TextConst ENU = 'Debit',
                                   FRA = 'Débit';
        CreditCaptionLbl: TextConst ENU = 'Credit',
                                    FRA = 'Crédit';
}

