report 50023 "WDC Payment Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PaymentJournal.rdlc';
    ApplicationArea = all;

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
            column(Amount_GenJournalLine; FORMAT("Gen. Journal Line".Amount, 0, '<Sign><Integer Thousand><Decimals>'))
            {
                //DecimalPlaces = 0:2; à voir
            }
            column(BalAccountNo_GenJournalLine; "Gen. Journal Line"."Bal. Account No.")
            {
            }
            column(Nom_FRS_GenJournalLine; "Gen. Journal Line"."Vendor Name")
            {
            }
            column(Nom_BQ_GenJournalLine; "Gen. Journal Line"."Bank Name")
            {
            }
            column(CurrencyCode_GenJournalLine; "Gen. Journal Line"."Currency Code")
            {
            }
            column(RecipientBankAccount_GenJournalLine; "Gen. Journal Line"."Recipient Bank Account")
            {
            }
            column(AdressBank; Adress)
            {
            }
            column(AdressBank2; Adress2)
            {
            }
            column(CurrencyCode; CurrencyCode)
            {
            }
            column(AcountNo; AcountNo)
            {
            }
            column(BcNo; BcNo)
            {
            }
            column(City; City)
            {
            }
            column(txtMontantTouteLettre; txtMontantTouteLettre)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAdress; CompanyInformation.Address)
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(AcountNoCredit; AcountNoCredit)
            {
            }

            trigger OnAfterGetRecord()
            begin
                VendorBankAccount.SETRANGE("Vendor No.", "Gen. Journal Line"."Account No.");
                VendorBankAccount.SETRANGE(Code, "Gen. Journal Line"."Recipient Bank Account");
                IF VendorBankAccount.FIND('-') THEN BEGIN
                    AcountNoCredit := VendorBankAccount."Bank Account No.";
                END;

                IF BankAccount.GET("Gen. Journal Line"."Bal. Account No.") THEN BEGIN
                    AcountNo := BankAccount."Bank Account No.";
                    Adress := BankAccount.Address;
                    Adress2 := BankAccount."Address 2";
                    City := BankAccount.City;
                END;

                IF PurchInvHeader.GET("Gen. Journal Line"."Applies-to Doc. No.") THEN BEGIN
                    BcNo := PurchInvHeader."Order No.";
                END;

                IF "Gen. Journal Line".GET("Gen. Journal Line"."Account No.") THEN;
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

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        VendorBankAccount: Record 288;
        Adress: Text[50];
        Adress2: Text[50];
        BankAccount: Record 270;
        AcountNo: Text[30];
        CurrencyCode: Code[10];
        PurchInvHeader: Record 122;
        BcNo: Code[20];
        City: Text[30];
        txtMontantTouteLettre: Text;
        recPaymentMethod: Record 289;
        cuMontantTouteLettre: Codeunit "WDC Montant Toute Lettre";
        CompanyInformation: Record 79;
        AcountNoCredit: Text[30];
        GeneralLedgerSetup: Record 98;
}

