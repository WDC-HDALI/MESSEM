report 50843 "WDC-ED Recapitulation Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_ED/report/RDLC/RecapitulationForm.rdlc';
    captionML = ENU = 'Recapitulation Form', FRA = 'Bordereau de remise';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(BankAccAddr_1_; BankAccAddr[1])
            {
            }
            column(BankAccAddr_2_; BankAccAddr[2])
            {
            }
            column(BankAccAddr_3_; BankAccAddr[3])
            {
            }
            column(BankAccAddr_4_; BankAccAddr[4])
            {
            }
            column(BankAccAddr_5_; BankAccAddr[5])
            {
            }
            column(BankAccAddr_6_; BankAccAddr[6])
            {
            }
            column(BankAccAddr_7_; BankAccAddr[7])
            {
            }
            column(BankAccAddr_8_; BankAccAddr[8])
            {
            }
            column(Bank_Account__Bank_Account_No__; "Bank Account No.")
            {
            }
            column(Bank_Account__Bank_Branch_No__; "Bank Branch No.")
            {
            }
            column(CompanyAddr_2_; CompanyAddr[2])
            {
            }
            column(CompanyAddr_3_; CompanyAddr[3])
            {
            }
            column(CompanyAddr_4_; CompanyAddr[4])
            {
            }
            column(CompanyAddr_5_; CompanyAddr[5])
            {
            }
            column(CompanyAddr_6_; CompanyAddr[6])
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(STRSUBSTNO_Text001_FORMAT_WORKDATE_0_4__; StrSubstNo(Text001, Format(WorkDate, 0, 4)))
            {
            }
            column(CONVERTSTR_FORMAT__RIB_Key__2_______0__; ConvertStr(Format("RIB Key", 2), ' ', '0'))
            {
            }
            column(Bank_Account__Agency_Code_; "Agency Code")
            {
            }
            column(Bank_Account__No__; "No.")
            {
            }
            column(Bank_Account__Bank_Account_No__Caption; FieldCaption("Bank Account No."))
            {
            }
            column(Bank_Account__Bank_Branch_No__Caption; FieldCaption("Bank Branch No."))
            {
            }
            column(Checks_Caption; Checks_CaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Customer_No_Caption; Customer_No_CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(CustBankAccNoCaption; CustBankAccNoCaptionLbl)
            {
            }
            column(CustBankAcc_CodeCaption; CustBankAcc_CodeCaptionLbl)
            {
            }
            column(CustBankAcc_NameCaption; CustBankAcc_NameCaptionLbl)
            {
            }
            column(Gen__Journal_Line__AmountCaption; Gen__Journal_Line__AmountCaptionLbl)
            {
            }
            column(Recapitulation_FormCaption; Recapitulation_FormCaptionLbl)
            {
            }
            column(Gen__Journal_Line___Currency_Code_Caption; Gen__Journal_Line___Currency_Code_CaptionLbl)
            {
            }
            column(CONVERTSTR_FORMAT__RIB_Key__2_______0__Caption; CONVERTSTR_FORMAT__RIB_Key__2_______0__CaptionLbl)
            {
            }
            column(Bank_Account__Agency_Code_Caption; FieldCaption("Agency Code"))
            {
            }
            dataitem("Gen. Journal Line"; "Gen. Journal Line")
            {
                DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.") WHERE("Document Type" = CONST(Payment));
                RequestFilterFields = "Posting Date", "Document No.";
                column(LineNum; LineNum)
                {
                }
                column(GenJnlLine_Amount; "Gen. Journal Line".Amount)
                {
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                column(Gen__Journal_Line_Journal_Template_Name; "Journal Template Name")
                {
                }
                column(Gen__Journal_Line_Journal_Batch_Name; "Journal Batch Name")
                {
                }
                column(Gen__Journal_Line_Line_No_; "Line No.")
                {
                }
                column(Gen__Journal_Line_Account_No_; "Account No.")
                {
                }
                column(LineNumCaption; LineNumCaptionLbl)
                {
                }
                column(GenJnlLine_AmountCaption; GenJnlLine_AmountCaptionLbl)
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = FIELD("Account No.");
                    DataItemTableView = SORTING("No.");
                    column(Gen__Journal_Line___Currency_Code_; "Gen. Journal Line"."Currency Code")
                    {
                    }
                    column(Gen__Journal_Line__Amount; -"Gen. Journal Line".Amount)
                    {
                    }
                    column(CustBankAcc_Name; CustBankAcc.Name)
                    {
                    }
                    column(CustBankAccNo; CustBankAccNo)
                    {
                    }
                    column(CustBankAcc_Code; CustBankAcc.Code)
                    {
                    }
                    column(Customer_Name; Name)
                    {
                    }
                    column(Gen__Journal_Line___Account_No__; "Gen. Journal Line"."Account No.")
                    {
                    }
                    column(LineNum_Control1120037; LineNum)
                    {
                    }
                    column(Customer_No_; "No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if CustBankAcc.Get(Customer."No.", "Gen. Journal Line"."Recipient Bank Account") then
                            CustBankAccNo := CustBankAcc."Bank Branch No." + ' ' +
                              CustBankAcc."Agency Code" + ' ' +
                              CustBankAcc."Bank Account No." + ' ' +
                              ConvertStr(Format(CustBankAcc."RIB Key", 2), ' ', '0')
                        else begin
                            CustBankAccNo := '';
                            CustBankAcc.Code := '';
                            CustBankAcc.Name := '';
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if not ("Gen. Journal Line"."Account Type" in ["Gen. Journal Line"."Account Type"::Customer,
                                                                   "Gen. Journal Line"."Account Type"::"G/L Account"])
                    then
                        CurrReport.Skip();

                    if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::"G/L Account" then
                        LineNum := LineNum
                    else
                        LineNum := IncStr(LineNum);

                    if GenJnlLine."Currency Code" = '' then
                        CurrencyCode := GLSetup."LCY Code"
                    else
                        CurrencyCode := GenJnlLine."Currency Code";
                end;

                trigger OnPostDataItem()
                begin
                    if not GenJnlLine.FindFirst then
                        CurrReport.Skip();

                    if BalanceAmount then
                        GenJnlLine."Amount (LCY)" := -GenJnlLine."Amount (LCY)";
                end;

                trigger OnPreDataItem()
                begin
                    LineNum := '0';
                    GenJnlLine.Copy("Gen. Journal Line");
                    GenJnlLine.SetRange("Bal. Account Type", "Account Type"::"Bank Account");
                    GenJnlLine.SetRange("Bal. Account No.", "Bank Account"."No.");
                    if GenJnlLine.FindFirst then begin
                        BalanceAmount := true;
                        "Gen. Journal Line".SetRange("Bal. Account No.", "Bank Account"."No.");
                        "Gen. Journal Line".SetRange("Posting Date", GenJnlLine."Posting Date");
                    end else begin
                        GenJnlLine.Copy("Gen. Journal Line");
                        GenJnlLine.SetRange("Account Type", "Account Type"::"Bank Account");
                        GenJnlLine.SetRange("Account No.", "Bank Account"."No.");
                        BalanceAmount := false;
                        if GenJnlLine.FindFirst then begin
                            "Gen. Journal Line".SetRange("Document No.", GenJnlLine."Document No.");
                            "Gen. Journal Line".SetRange("Posting Date", GenJnlLine."Posting Date");
                        end else
                            CurrReport.Break();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddr.BankAcc(BankAccAddr, "Bank Account");
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                GLSetup.Get();
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
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        CustBankAcc: Record "Customer Bank Account";
        GenJnlLine: Record "Gen. Journal Line";
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[100];
        BankAccAddr: array[8] of Text[100];
        CustBankAccNo: Text[250];
        LineNum: Code[10];
        CurrencyCode: Code[10];
        BalanceAmount: Boolean;
        Text001: TextConst ENU = 'The %1',
                           FRA = 'Le %1';
        Checks_CaptionLbl: TextConst ENU = 'Checks:',
                                     FRA = 'Chèques';
        No_CaptionLbl: TextConst ENU = 'No.',
                                 FRA = 'N° ';
        Customer_No_CaptionLbl: TextConst ENU = 'Customer No.',
                                          FRA = 'N° client';
        Customer_NameCaptionLbl: TextConst ENU = 'Customer Name',
                                           FRA = 'Nom client';
        CustBankAccNoCaptionLbl: TextConst ENU = 'Cust. Bank Account No.',
                                           FRA = 'N° compte bancaire client';
        CustBankAcc_CodeCaptionLbl: TextConst ENU = 'Cust. Bank Account Code',
                                              FRA = 'Code cpte bancaire clt';
        CustBankAcc_NameCaptionLbl: TextConst ENU = 'Cust. Bank Account Name',
                                              FRA = 'Nom compte bancaire client';
        Gen__Journal_Line__AmountCaptionLbl: TextConst ENU = 'Amount',
                                                       FRA = 'Montant';
        Recapitulation_FormCaptionLbl: TextConst ENU = 'Recapitulation Form',
                                                 FRA = 'Bordereau de remise';
        Gen__Journal_Line___Currency_Code_CaptionLbl: TextConst ENU = 'Currency Code',
                                                                FRA = 'Code devise';
        CONVERTSTR_FORMAT__RIB_Key__2_______0__CaptionLbl: TextConst ENU = 'RIB Key',
                                                                     FRA = 'Clé RIB';
        LineNumCaptionLbl: TextConst ENU = 'Total number of checks:',
                                     FRA = 'Nombre total de chèques';
        GenJnlLine_AmountCaptionLbl: TextConst ENU = 'Total Amount',
                                               FRA = 'Montant total';
}

