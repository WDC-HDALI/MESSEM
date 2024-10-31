report 50072 "MM VAT Return"
{
    // WDC01  27/05/2024  WDC.ST  Création
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/MMVATReturn.rdlc';

    CaptionML = ENU = 'MM VAT Return', FRA = 'MM retour TVA';

    dataset
    {
        dataitem(Vendor; 23)
        {
            DataItemTableView = SORTING("Gen. Bus. Posting Group")
                                ORDER(Ascending)
                                WHERE("Gen. Bus. Posting Group" = CONST('LOCAL'),
                                     "VAT Bus. Posting Group" = CONST('ASSUJETTIE'));
            PrintOnlyIfDetail = true;
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(RecGCompanyinformation_Address; RecGCompanyinformation.Address)
            {
            }
            column(FORMATTODAY04; FORMAT(TODAY, 0, 4))
            {
            }
            column(PAGENo; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Vendor_No; Vendor."No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(DateDebut; DateDebut)
            {
            }
            column(Datefin; Datefin)
            {
            }
            column(Vendor_ICE; Vendor.ICE)
            {
            }
            column(Vendor_IF; Vendor."VAT Registration No.")
            {
            }
            column(Vendor_PaymentTermsCode; Vendor."Payment Terms Code")
            {
            }
            column(Vendor_PaymentMethodCode; Vendor."Payment Method Code")
            {
            }
            dataitem("Vendor Ledger Entry"; 25)
            {
                CalcFields = Amount;
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Vendor No.", "Posting Date", "Currency Code")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = CONST(Payment));
                column(VendorLedgerEntry_DebitAmount; "Vendor Ledger Entry"."Debit Amount")
                {
                }
                column(VendorLedgerEntry_CreditAmount; "Vendor Ledger Entry"."Credit Amount")
                {
                }
                column(VendorLedgerEntry_DocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(VendorLedgerEntry_Description; "Vendor Ledger Entry".Description)
                {
                }
                column(VendorLedgerEntry_PostingDate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                dataitem("VendorLedger Entry1"; 25)
                {
                    DataItemLink = "Vendor No." = FIELD("Vendor No.");
                    DataItemTableView = SORTING("Entry No.");
                    column(VendorLedgerEntry1_Description; "VendorLedger Entry1".Description)
                    {
                    }
                    column(SoldeT; SoldeT)
                    {
                    }
                    column(VendorLedgerEntry1_DueDate; "VendorLedger Entry1"."Due Date")
                    {
                    }
                    column(VendorLedgerEntry1_PostingDate; "VendorLedger Entry1"."Posting Date")
                    {
                    }
                    column(MontantLettre; MontantLettre)
                    {
                    }
                    column(VendorLedgerEntry1_DocumentNo; "VendorLedger Entry1"."Document No.")
                    {
                    }
                    column(PurchInvHeader_VendorInvoiceNo; PurchInvHeader."Vendor Invoice No.")
                    {
                    }
                    column(PurchInvHeader_AmountTTC; PurchInvHeader."Amount Including VAT")
                    {
                    }
                    column(PurchInvHeader_Amount; PurchInvHeader.Amount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT PurchInvHeader.GET("VendorLedger Entry1"."Document No.") THEN BEGIN
                            CurrReport.SKIP;
                        END ELSE BEGIN
                            PurchInvHeader.CALCFIELDS(Amount);
                            PurchInvHeader.CALCFIELDS("Amount Including VAT");
                            IF PurchInvHeader."Amount Including VAT" - PurchInvHeader.Amount = 0 THEN
                                CurrReport.SKIP;
                        END;

                        MontantLettre := 0;
                        rec380.RESET;
                        rec380.SETRANGE(rec380."Vendor Ledger Entry No.", "Entry No.");
                        //rec380.SETRANGE("Document Type",rec380."Document Type"::Invoice);
                        rec380.SETRANGE("Document No.", "Vendor Ledger Entry"."Document No.");
                        rec380.SETRANGE("Applied Vend. Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                        rec380.SETRANGE(Unapplied, FALSE);
                        IF rec380.FINDFIRST THEN
                            MontantLettre := ABS(rec380.Amount)
                        ELSE BEGIN
                            rec380.RESET;
                            rec380.SETRANGE(rec380."Vendor Ledger Entry No.", "Vendor Ledger Entry"."Entry No.");
                            rec380.SETRANGE(rec380."Applied Vend. Ledger Entry No.", "VendorLedger Entry1"."Entry No.");
                            //rec379.SETRANGE("Document Type",rec380."Document Type"::Payment);
                            //rec379.SETFILTER("Document Type",'%1|2',rec380."Document Type"::Payment,rec380."Document Type"::"Credit Memo");
                            rec380.SETRANGE("Document No.", "VendorLedger Entry1"."Document No.");
                            rec380.SETRANGE(Unapplied, FALSE);
                            IF rec380.FINDFIRST THEN
                                MontantLettre := ABS(rec380.Amount)
                        END;

                        SoldeT += MontantLettre;
                    end;

                    trigger OnPreDataItem()
                    begin
                        rec25.COPY("Vendor Ledger Entry");
                        rec25.RESET;
                        IF rec25."Entry No." <> 0 THEN BEGIN
                            CreateVendLedgEntry := "Vendor Ledger Entry";
                            FindApplnEntriesDtldtLedgEntry(rec25, CreateVendLedgEntry);
                            rec25.SETCURRENTKEY("Entry No.");
                            rec25.SETRANGE("Entry No.");

                            IF CreateVendLedgEntry."Closed by Entry No." <> 0 THEN BEGIN
                                rec25."Entry No." := CreateVendLedgEntry."Closed by Entry No.";
                                rec25.MARK(TRUE);
                            END;

                            rec25.SETCURRENTKEY("Closed by Entry No.");
                            rec25.SETRANGE("Closed by Entry No.", CreateVendLedgEntry."Entry No.");
                            IF rec25.FIND('-') THEN
                                REPEAT
                                    rec25.MARK(TRUE);
                                UNTIL rec25.NEXT = 0;

                            rec25.SETCURRENTKEY("Entry No.");
                            rec25.SETRANGE("Closed by Entry No.");
                        END;
                        rec25.MARKEDONLY(TRUE);
                        "VendorLedger Entry1".COPY(rec25);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SoldeT := "Vendor Ledger Entry".Amount;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", DateDebut, Datefin);
                    //IF Nfact<>'' THEN
                    //  SETFILTER("Document No.",Nfact);
                end;
            }

            trigger OnPreDataItem()
            begin
                RecGCompanyinformation.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateDebut; DateDebut)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = all;
                }
                field(Datefin; Datefin)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = all;
                }
                field(Nfact; Nfact)
                {
                    Caption = 'Invoice No.';
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Titre = 'Applied by Vendor Invoice';
        Date = 'Date Filter';
        Document = 'Document No.';
        Eché = 'Due';
        MtDebit = 'Debit Amount';
        MtCredit = 'Credit Amount';
        Solde = 'Value';
        Fournisseu = 'Vendor';
    }

    trigger OnPreReport()
    begin
        IF DateDebut = 0D THEN ERROR('Veuillez saisir la date début');
        IF Datefin = 0D THEN ERROR('Veuillez saisir la date fin');
    end;

    var
        RecGCompanyinformation: Record 79;
        CreateVendLedgEntry: Record 25;
        rec25: Record 25;
        rec380: Record 380;
        SoldeT: Decimal;
        MontantLettre: Decimal;
        DateDebut: Date;
        Datefin: Date;
        Nfact: Code[20];
        // recPayLine: Record 10866;
        recVendor: Record 23;
        PurchInvHeader: Record 122;
        PurchCrMemoHdr: Record 24;

    procedure FindApplnEntriesDtldtLedgEntry(var rec25Bis: Record 25; recCreate: Record 25)
    var
        DtldVendLedgEntry1: Record 380;
        DtldVendLedgEntry2: Record 380;
    begin
        DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", CreateVendLedgEntry."Entry No.");
        DtldVendLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldVendLedgEntry1.FIND('-') THEN BEGIN
            REPEAT
                IF DtldVendLedgEntry1."Vendor Ledger Entry No." =
                  DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                THEN BEGIN
                    DtldVendLedgEntry2.INIT;
                    DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SETRANGE(
                      "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldVendLedgEntry2.FIND('-') THEN BEGIN
                        REPEAT
                            IF DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                              DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                            THEN BEGIN
                                rec25Bis.SETCURRENTKEY("Entry No.");
                                rec25Bis.SETRANGE("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                IF rec25Bis.FIND('-') THEN
                                    rec25Bis.MARK(TRUE);
                            END;
                        UNTIL DtldVendLedgEntry2.NEXT = 0;
                    END;
                END ELSE BEGIN
                    rec25Bis.SETCURRENTKEY("Entry No.");
                    rec25Bis.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    IF rec25Bis.FIND('-') THEN
                        rec25Bis.MARK(TRUE);
                END;
            UNTIL DtldVendLedgEntry1.NEXT = 0;
        END;
    end;
}

