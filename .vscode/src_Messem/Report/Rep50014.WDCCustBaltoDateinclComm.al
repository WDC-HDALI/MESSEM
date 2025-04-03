report 50014 "WDC CustBal toDate inclComm"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/CustBaltoDateinclComm.rdlc';

    CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Ecritures ouvertes';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked, "Date Filter";
            column(TxtCustGeTranmaxDtFilter; STRSUBSTNO(Text000, FORMAT(GETRANGEMAX("Date Filter"))))
            {
            }
            column(CompanyName; companyinfo.Name)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(PrintLedgerEntryComment; PrintLedgerEntryComment)
            {
            }
            column(CustTableCaptCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(PhoneNo_Customer; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(CustBalancetoDateCaption; CustBalancetoDateCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(AllamtsareinLCYCaption; AllamtsareinLCYCaptionLbl)
            {
            }
            column(CustLedgEntryPostingDtCaption; CustLedgEntryPostingDtCaptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }
            dataitem(CustLedgEntry3; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(PostingDt_CustLedgEntry; FORMAT("Posting Date"))
                {
                    IncludeCaption = false;
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_CustLedgEntry; Description)
                {
                    IncludeCaption = true;
                }
                column(OriginalAmt; OriginalAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(RemainingAmt_Cust3; RemainingAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No."),
                                   "Posting Date" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(<> "Initial Entry"));
                    column(EntType_DtldCustLedgEnt; "Entry Type")
                    {
                    }
                    column(postDt_DtldCustLedgEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_DtldCustLedgEntry; "Document Type")
                    {
                    }
                    column(DocNo_DtldCustLedgEntry; "Document No.")
                    {
                    }
                    column(Amt; Amt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CurrencyCodeDtldCustLedgEntry; CurrencyCode)
                    {
                    }
                    column(EntNo_DtldCustLedgEntry; DtldCustLedgEntryNum)
                    {
                    }
                    column(RemainingAmt; RemainingAmt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT PrintUnappliedEntries THEN
                            IF Unapplied THEN
                                CurrReport.SKIP;

                        IF PrintAmountInLCY THEN BEGIN
                            Amt := "Amount (LCY)";
                            CurrencyCode := '';
                        END ELSE BEGIN
                            Amt := Amount;
                            CurrencyCode := "Currency Code";
                        END;
                        IF Amt = 0 THEN
                            CurrReport.SKIP;

                        DtldCustLedgEntryNum := DtldCustLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        DtldCustLedgEntryNum := 0;
                    end;
                }
                dataitem("WDC Ledger Entry Comment Line"; "WDC Ledger Entry Comment Line")
                {
                    column(LedgerEntryCommentLineComment; Comment)
                    {
                    }
                    column(LedgerEntryCommentLineLineNo; "Line No.")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        IF NOT PrintLedgerEntryComment THEN
                            CurrReport.BREAK;

                        SETRANGE("Ledger Entry Type", DATABASE::"Cust. Ledger Entry");
                        SETRANGE("Ledger Entry No.", CustLedgEntry3."Entry No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintAmountInLCY THEN BEGIN
                        CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                        OriginalAmt := "Original Amt. (LCY)";
                        RemainingAmt := "Remaining Amt. (LCY)";
                        CurrencyCode := '';
                    END ELSE BEGIN
                        CALCFIELDS("Original Amount", "Remaining Amount");
                        OriginalAmt := "Original Amount";
                        RemainingAmt := "Remaining Amount";
                        CurrencyCode := "Currency Code";
                    END;

                    CurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode,
                      RemainingAmt,
                      0,
                      Counter1);
                end;

                trigger OnPreDataItem()
                begin
                    RESET;
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                    DtldCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', MaxDate), 99991231D);
                    DtldCustLedgEntry.SETRANGE("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
                    IF NOT PrintUnappliedEntries THEN
                        DtldCustLedgEntry.SETRANGE(Unapplied, FALSE);

                    IF DtldCustLedgEntry.FIND('-') THEN
                        REPEAT
                            "Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                            MARK(TRUE);
                        UNTIL DtldCustLedgEntry.NEXT = 0;

                    SETCURRENTKEY("Customer No.", Open);
                    SETRANGE("Customer No.", Customer."No.");
                    SETRANGE(Open, TRUE);
                    SETRANGE("Posting Date", 0D, MaxDate);

                    IF FIND('-') THEN
                        REPEAT
                            MARK(TRUE);
                        UNTIL NEXT = 0;

                    SETCURRENTKEY("Entry No.");
                    SETRANGE(Open);
                    MARKEDONLY(TRUE);
                    SETRANGE("Date Filter", 0D, MaxDate);
                end;
            }
            dataitem(Integer2; integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(CustName; Customer.Name)
                {
                }
                column(TtlAmtCurrencyTtlBuff; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurryCode_CurrencyTtBuff; CurrencyTotalBuffer."Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        OK := CurrencyTotalBuffer.FIND('-')
                    ELSE
                        OK := CurrencyTotalBuffer.NEXT <> 0;
                    IF NOT OK THEN
                        CurrReport.BREAK;

                    CurrencyTotalBuffer2.UpdateTotal(
                      CurrencyTotalBuffer."Currency Code",
                      CurrencyTotalBuffer."Total Amount",
                      0,
                      Counter1);
                end;

                trigger OnPostDataItem()
                begin
                    CurrencyTotalBuffer.DELETEALL;
                end;

                trigger OnPreDataItem()
                begin
                    CurrencyTotalBuffer.SETFILTER("Total Amount", '<>0');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MaxDate := GETRANGEMAX("Date Filter");
                SETRANGE("Date Filter", 0D, MaxDate);
                CALCFIELDS("Net Change (LCY)", "Net Change");

                IF ((PrintAmountInLCY AND ("Net Change (LCY)" = 0)) OR
                    ((NOT PrintAmountInLCY) AND ("Net Change" = 0)))
                THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                // FW-48276-N9M8
                //CurrReport.NEWPAGEPERRECORD := PrintOnePrPage;
                //
            end;
        }
        dataitem(Integer3; integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurryCode_CurrencyTtBuff2; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(TtlAmtCurrencyTtlBuff2; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    OK := CurrencyTotalBuffer2.FIND('-')
                ELSE
                    OK := CurrencyTotalBuffer2.NEXT <> 0;
                IF NOT OK THEN
                    CurrReport.BREAK;
            end;

            trigger OnPostDataItem()
            begin
                CurrencyTotalBuffer2.DELETEALL;
            end;

            trigger OnPreDataItem()
            begin
                CurrencyTotalBuffer2.SETFILTER("Total Amount", '<>0');
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
                    Caption = 'Options';
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        Captionml = ENU = 'Show Amounts in LCY', FRA = 'Afficher montants DS';
                        ApplicationArea = all;

                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        Captionml = ENU = 'New Page per Customer', FRA = 'Nouvelle page par client';
                        ApplicationArea = all;
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        Captionml = ENU = 'Include Unapplied Entries', FRA = 'Inclure écritures non lettrées';
                        ApplicationArea = all;
                    }
                    field(PrintLedgerEntryComment; PrintLedgerEntryComment)
                    {
                        Captionml = ENU = 'Print Ledger Entry Comment', FRA = 'Imprimer commentaire écriture';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }



    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        CustDateFilter := Customer.GETFILTER("Date Filter");
        companyinfo.Get();
    end;

    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean)
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
    end;

    var

        Text000: textconst ENU = 'Balance on %1', FRA = 'Solde au %1';
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        PrintAmountInLCY: Boolean;
        PrintOnePrPage: Boolean;
        CustFilter: Text[250];
        CustDateFilter: Text[30];
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldCustLedgEntryNum: Integer;
        OK: Boolean;
        CurrencyCode: Code[10];
        PrintUnappliedEntries: Boolean;
        CustBalancetoDateCaptionLbl: textconst ENU = 'Customer - Balance to Date', FRA = 'Clients : Ecritures ouvertes';
        CurrReportPageNoCaptionLbl: textconst ENU = 'Page', FRA = 'Page';
        AllamtsareinLCYCaptionLbl: textconst ENU = 'All amounts are in LCY.', FRA = 'Tous les montants sont en devise société.';
        CustLedgEntryPostingDtCaptionLbl: textconst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        OriginalAmtCaptionLbl: textconst ENU = 'Amount', FRA = 'Montant';
        TotalCaptionLbl: textconst ENU = 'Total', FRA = 'Total';
        PrintLedgerEntryComment: Boolean;
        companyinfo: record "Company Information";
}

