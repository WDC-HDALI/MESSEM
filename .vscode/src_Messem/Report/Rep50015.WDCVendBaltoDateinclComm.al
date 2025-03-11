report 50015 "WDC VendBal toDate inclComm."
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/VendBaltoDateinclComm.rdlc';

    Captionml = ENU = 'Vendor - Balance to Date', FRA = 'Fourn. : Détail écr. ouvertes';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked, "Date Filter";
            column(StrNoVenGetMaxDtFilter; STRSUBSTNO(Text000, FORMAT(GETRANGEMAX("Date Filter"))))
            {
            }
            column(CompanyName; companyinfo.Name)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(PrintLedgerEntryComment; PrintLedgerEntryComment)
            {
            }
            column(VendorCaption; TABLECAPTION + ': ' + VendFilter)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(Name_Vendor; Name)
            {
            }
            column(PhoneNo_Vendor; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(VendorBalancetoDateCptn; VendorBalancetoDateCptnLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllamountsareinLCYCaption; AllamountsareinLCYCaptionLbl)
            {
            }
            column(PostingDateCption; PostingDateCptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }
            dataitem(VendLedgEntry3; "Vendor Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(PostDt_VendLedgEntry3; FORMAT("Posting Date"))
                {
                }
                column(DocType_VendLedgEntry3; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_VendLedgEntry3; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_VendLedgEntry3; Description)
                {
                    IncludeCaption = true;
                }
                column(OriginalAmt; OriginalAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(RemainingAmt_VendLedgEntry3; RemainingAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_VendLedgEntry3; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No."),
                                  "Posting Date" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Vendor Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(<> "Initial Entry"));
                    column(EntryTp_DtldVendLedgEntry; "Entry Type")
                    {
                    }
                    column(PostDate_DtldVendLedEnt; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_DtldVendLedEnt; "Document Type")
                    {
                    }
                    column(DocNo_DtldVendLedgEntry; "Document No.")
                    {
                    }
                    column(Amt; Amt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CurrencyCodeDtldVendLedgEntry; CurrencyCode)
                    {
                    }
                    column(DtldVendtLedgEntryNum; DtldVendtLedgEntryNum)
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

                        DtldVendtLedgEntryNum := DtldVendtLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        DtldVendtLedgEntryNum := 0;
                    end;
                }
                dataitem("Ledger Entry Comment Line"; "WDC Ledger Entry Comment Line")
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

                        SETRANGE("Ledger Entry Type", DATABASE::"Vendor Ledger Entry");
                        SETRANGE("Ledger Entry No.", VendLedgEntry3."Entry No.");
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
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type");
                    DtldVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
                    DtldVendLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', MaxDate), 99991231D);
                    DtldVendLedgEntry.SETRANGE("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                    IF NOT PrintUnappliedEntries THEN
                        DtldVendLedgEntry.SETRANGE(Unapplied, FALSE);

                    IF DtldVendLedgEntry.FIND('-') THEN
                        REPEAT
                            "Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                            MARK(TRUE);
                        UNTIL DtldVendLedgEntry.NEXT = 0;

                    SETCURRENTKEY("Vendor No.", Open);
                    SETRANGE("Vendor No.", Vendor."No.");
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
            dataitem(Integer2; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(Name1_Vendor; Vendor.Name)
                {
                }
                column(CurrTotalBufferTotalAmt; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurrTotalBufferCurrCode; CurrencyTotalBuffer."Currency Code")
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
        }
        dataitem(Integer3; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurrTotalBuffer2CurrCode; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(CurrTotalBuffer2TotalAmt; CurrencyTotalBuffer2."Total Amount")
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
                        CaptionML = ENU = 'Show Amounts in LCY', FRA = 'fficher montants DS';
                        ApplicationArea = all;
                    }
                    field(PrintOnePrPage; PrintOnePrPage)
                    {
                        CaptionML = ENU = 'New Page per Vendor', FRA = 'Nouvelle page par fournisseur';
                        ApplicationArea = all;
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        Captionml = ENU = 'Include Unapplied Entries', FRA = 'Inclure écritures non lettrées';
                        ApplicationArea = all;
                    }
                    field(PrintLedgerEntryComment; PrintLedgerEntryComment)
                    {
                        CaptionML = ENU = 'Print Ledger Entry Comment', FRA = 'Imprimer commentaire écriture';
                        ApplicationArea = all;
                    }
                }
            }
        }

    }

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := Vendor.GETFILTER("Date Filter");
        companyinfo.get();
    end;

    var
        Text000: TextConst ENU = 'Balance on %1', FRA = 'Solde au %1';
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        PrintAmountInLCY: Boolean;
        PrintOnePrPage: Boolean;
        VendFilter: Text[250];
        VendDateFilter: Text[30];
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldVendtLedgEntryNum: Integer;
        OK: Boolean;
        CurrencyCode: Code[10];
        PrintUnappliedEntries: Boolean;
        VendorBalancetoDateCptnLbl: TextConst ENU = 'Vendor - Balance to Date', FRA = 'Fourn. : Détail écr. ouvertes';
        PageNoCaptionLbl: TextConst ENU = 'Page', FRA = 'page';
        AllamountsareinLCYCaptionLbl: TextConst ENU = 'All amounts are in LCY.', FRA = 'Tous les montants sont en devise société.';
        PostingDateCptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilisation';
        OriginalAmtCaptionLbl: TextConst ENU = 'Amount', FRA = 'Montant';
        TotalCaptionLbl: TextConst ENU = 'Total', FRA = 'Total';
        PrintLedgerEntryComment: Boolean;
        companyinfo: record "Company Information";

    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean)
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
    end;
}

