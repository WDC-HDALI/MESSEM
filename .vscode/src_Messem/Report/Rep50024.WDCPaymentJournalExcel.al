report 50024 "WDC Payment Journal Excel"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PaymentJournalMessemExcel.rdlc';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Line No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";
            column(AccountType_GenJournalLine; "Gen. Journal Line"."Account Type")
            {
            }
            column(AccountNo_GenJournalLine; "Gen. Journal Line"."Account No.")
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(Description_GenJournalLine; "Gen. Journal Line".Description)
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line".Amount * 100)
            {
            }
            column(BalAccountNo_GenJournalLine; "Gen. Journal Line"."Bal. Account No.")
            {
            }
            column(CurrencyCode_GenJournalLine; "Gen. Journal Line"."Currency Code")
            {
            }
            column(RecipientBankAccount_GenJournalLine; "Gen. Journal Line"."Recipient Bank Account")
            {
            }
            column(txtMontantTouteLettre; txtMontantTouteLettre)
            {
            }
            column(RIB; RIB)
            {
            }
            column(VendorName; VendorName)
            {
            }

            trigger OnAfterGetRecord()
            begin

                VendorBankAccount.RESET;
                VendorBankAccount.SETRANGE(Code, "Gen. Journal Line"."Recipient Bank Account");
                VendorBankAccount.SETRANGE("Vendor No.", "Gen. Journal Line"."Account No.");
                IF VendorBankAccount.FindFirst() then BEGIN
                    RIB := VendorBankAccount."Bank Account No.";
                END;

                IF Vendor.GET("Gen. Journal Line"."Account No.") THEN
                    VendorName := Vendor.Name;



                IF "Gen. Journal Line".GET("Gen. Journal Line"."Account No.") THEN
                    cuMontantTouteLettre."Montant en texte"(txtMontantTouteLettre, "Gen. Journal Line".Amount);

                GeneralLedgerSetup.GET;
                IF "Gen. Journal Line"."Currency Code" <> '' THEN BEGIN
                    CurrencyCode := "Gen. Journal Line"."Currency Code";
                END ELSE BEGIN
                    IF "Gen. Journal Line"."Currency Code" = '' THEN
                        CurrencyCode := GeneralLedgerSetup."LCY Code";
                END;
            end;
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

    var
        VendorBankAccount: Record 288;
        CurrencyCode: Code[10];
        txtMontantTouteLettre: Text;
        recPaymentMethod: Record 289;
        cuMontantTouteLettre: Codeunit "WDC Montant Toute Lettre";
        GeneralLedgerSetup: Record 98;
        RIB: Text;
        Vendor: Record 23;
        VendorName: Text[50];

}

