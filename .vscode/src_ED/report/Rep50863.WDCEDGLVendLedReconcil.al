report 50863 "WDC-ED GL/Vend. Led. Reconcil."
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_ED/report/RDLC/GLVendLedgerReconciliation.rdlc';
    ApplicationArea = All;
    captionML = ENU = 'GL/Vend. Ledger Reconciliation', FRA = 'Rapprochement cpta. gén./fourn.';
    Permissions = TableData "Invoice Posting Buffer" = rimd;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Date Filter";
            column(USERID; UserId)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(FirstNo; FirstNo)
            {
            }
            column(LastNo; LastNo)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(TotalDebit; TotalDebit)
            {
            }
            column(TotalCredit; TotalCredit)
            {
            }
            column(TotalDebit_TotalCredit; TotalDebit - TotalCredit)
            {
            }
            column(General_Vendor_ledger_reconciliationCaption; General_Vendor_ledger_reconciliationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Debit_Amount_Caption; "G/L Entry".FieldCaption("Debit Amount"))
            {
            }
            column(G_L_Entry__Credit_Amount_Caption; "G/L Entry".FieldCaption("Credit Amount"))
            {
            }
            column(G_L_Entry_AmountCaption; "G/L Entry".FieldCaption(Amount))
            {
            }
            column(G_L_Entry_DescriptionCaption; "G/L Entry".FieldCaption(Description))
            {
            }
            column(G_L_Entry__Document_No__Caption; "G/L Entry".FieldCaption("Document No."))
            {
            }
            column(G_L_Entry__Document_Type_Caption; "G/L Entry".FieldCaption("Document Type"))
            {
            }
            column(G_L_Entry__G_L_Account_No__Caption; "G/L Entry".FieldCaption("G/L Account No."))
            {
            }
            column(G_L_Entry__Posting_Date_Caption; G_L_Entry__Posting_Date_CaptionLbl)
            {
            }
            column(General_AmountCaption; General_AmountCaptionLbl)
            {
            }
            dataitem("Vendor Posting Group"; "Vendor Posting Group")
            {
                DataItemTableView = SORTING(Code);
                PrintOnlyIfDetail = true;
                column(TotalDebit_TotalCredit_Control1120015; TotalDebit - TotalCredit)
                {
                }
                column(TotalCredit_Control1120014; TotalCredit)
                {
                }
                column(TotalDebit_Control1120013; TotalDebit)
                {
                }
                column(Vendor_Posting_Group_Code; Code)
                {
                }
                column(Vendor_Posting_Group_Payables_Account; "Payables Account")
                {
                }
                column(Total_amount_for_the_vendorCaption; Total_amount_for_the_vendorCaptionLbl)
                {
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = FIELD("Payables Account");
                    DataItemTableView = SORTING("G/L Account No.", "Source Type", "Source No.") WHERE(Amount = FILTER(<> 0));
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(G_L_Entry_Amount; Amount)
                    {
                    }
                    column(G_L_Entry__Posting_Date_; Format("Posting Date"))
                    {
                    }
                    column(G_L_Entry_Description; Description)
                    {
                    }
                    column(G_L_Entry__Document_Type_; "Document Type")
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120036; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120037; "Credit Amount")
                    {
                    }
                    column(G_L_Entry_Amount_Control1120038; Amount)
                    {
                    }
                    column(G_L_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Total_amount_for_the_general_ledgerCaption; Total_amount_for_the_general_ledgerCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ("Bal. Account Type" = "Bal. Account Type"::Vendor) and ("Bal. Account No." = Vendor."No.") then
                            CurrReport.Skip();
                        TotalDebit := TotalDebit + "Debit Amount";
                        TotalCredit := TotalCredit + "Credit Amount";
                        InvPostBuf.Get(InvPostBuf.Type::"G/L Account", "G/L Account No.");
                        InvPostBuf.Amount := InvPostBuf.Amount + Amount;
                        InvPostBuf.Modify();
                        HavingDetail := true;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange("Source Type", "Source Type"::Vendor);
                        SetRange("Source No.", Vendor."No.");
                        SetRange("Posting Date", Vendor.GetRangeMin("Date Filter"), Vendor.GetRangeMax("Date Filter"));
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(PostingBuffer);
                    PostingBuffer."Account Type" := PostingBuffer."Account Type"::"G/L Account";
                    PostingBuffer."Account No." := "Payables Account";
                    if not PostingBuffer.Insert() then
                        CurrReport.Skip();
                    Clear(InvPostBuf);
                    InvPostBuf.Type := InvPostBuf.Type::"G/L Account";
                    InvPostBuf."G/L Account" := "Payables Account";
                    if not InvPostBuf.Insert() then;
                end;

                trigger OnPostDataItem()
                begin
                    PostingBuffer.DeleteAll();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalDebit := 0;
                TotalCredit := 0;
                HavingDetail := false;
            end;

            trigger OnPreDataItem()
            begin
                Clear(TotalDebit);
                Clear(TotalCredit);
                Vendor.FindFirst;
                FirstNo := "No.";
                Vendor.FindLast;
                LastNo := "No.";
            end;
        }
        dataitem("Invoice Post. Buffer"; "Invoice Posting Buffer")
        {
            DataItemTableView = SORTING(Type, "G/L Account", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Area Code", "Tax Group Code", "Tax Liable", "Use Tax", "Dimension Set ID", "Job No.", "Fixed Asset Line No.") WHERE(Amount = FILTER(<> 0));
            column(HavingDetail; HavingDetail)
            {
            }
            column(Invoice_Post__Buffer_Amount; Amount)
            {
            }
            column(Invoice_Post__Buffer__G_L_Account_; "G/L Account")
            {
            }
            column(Invoice_Post__Buffer_Type; Type)
            {
            }
            column(Invoice_Post__Buffer_Gen__Bus__Posting_Group; "Gen. Bus. Posting Group")
            {
            }
            column(Invoice_Post__Buffer_Gen__Prod__Posting_Group; "Gen. Prod. Posting Group")
            {
            }
            column(Invoice_Post__Buffer_VAT_Bus__Posting_Group; "VAT Bus. Posting Group")
            {
            }
            column(Invoice_Post__Buffer_VAT_Prod__Posting_Group; "VAT Prod. Posting Group")
            {
            }
            column(Invoice_Post__Buffer_Tax_Area_Code; "Tax Area Code")
            {
            }
            column(Invoice_Post__Buffer_Tax_Group_Code; "Tax Group Code")
            {
            }
            column(Invoice_Post__Buffer_Tax_Liable; "Tax Liable")
            {
            }
            column(Invoice_Post__Buffer_Use_Tax; "Use Tax")
            {
            }
            column(Invoice_Post__Buffer_Dimension_Set_ID; "Dimension Set ID")
            {
            }
            column(Invoice_Post__Buffer_Job_No_; "Job No.")
            {
            }
            column(Invoice_Post__Buffer_Fixed_Asset_Line_No_; "Fixed Asset Line No.")
            {
            }
            column(General_amount_for_the_general_ledgerCaption; General_amount_for_the_general_ledgerCaptionLbl)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        InvPostBuf.DeleteAll();
    end;

    var
        PostingBuffer: Record "WDC-ED Payment Post. Buffer" temporary;
        InvPostBuf: Record "Invoice Posting Buffer";
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        FirstNo: Code[20];
        LastNo: Code[20];
        HavingDetail: Boolean;
        General_Vendor_ledger_reconciliationCaptionLbl: TextConst ENU = 'General/Vendor ledger reconciliation',
                                                                  FRA = 'Rapprochement compta. générale/fournisseurs';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page',
                                               FRA = 'Page';
        G_L_Entry__Posting_Date_CaptionLbl: TextConst ENU = 'Posting Date',
                                                      FRA = 'Date comptabilisation';
        General_AmountCaptionLbl: TextConst ENU = 'General Amount',
                                                                  FRA = '';
        Total_amount_for_the_vendorCaptionLbl: TextConst ENU = 'Total amount for the vendor',
                                                         FRA = 'Montant général';
        Total_amount_for_the_general_ledgerCaptionLbl: TextConst ENU = 'Total amount for the general ledger',
                                                                 FRA = 'Montant total pour le fournisseur';
        General_amount_for_the_general_ledgerCaptionLbl: TextConst ENU = 'General amount for the general ledger',
                                                                   FRA = 'Montant total pour la comptabilité';
}

