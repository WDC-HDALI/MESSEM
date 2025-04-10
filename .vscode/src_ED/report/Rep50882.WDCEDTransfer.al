report 50882 "WDC-ED Transfer"
{
    captionML = ENU = 'Transfer', FRA = 'Virement';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Payment Header"; "WDC-ED Payment Header")
        {
            DataItemTableView = SORTING("No.");
            MaxIteration = 1;
            dataitem("Payment Line"; "WDC-ED Payment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.");

                trigger OnAfterGetRecord()
                var
                    GLAcct: Record "G/L Account";
                    Cust: Record Customer;
                    Vend: Record Vendor;
                    BankAcct: Record "Bank Account";
                    FixedAsset: Record "Fixed Asset";
                    PaymentClass: Record "WDC-ED Payment Class";
                    RecordCode: Text;
                    OperationCode: Text;
                    FromPaymentNo: Text;
                    VendName: Text;
                    VendBankName: Text;
                    BankBranchNo: Text;
                    AgencyCode: Text;
                    BankAccountNo: Text;
                    Designation: Text;
                    PrintAmount: Text;
                    ExportedText: Text;
                begin
                    TestField("Account No.");
                    TestField("Bank Account No.");

                    if StrLen("Bank Branch No.") > 5 then
                        Error(Text008, "Bank Account Name");

                    if StrLen("Agency Code") > 5 then
                        Error(Text008, "Bank Account Name");

                    if StrLen("Bank Account No.") > 11 then
                        Error(Text008, "Bank Account Name");

                    if not "RIB Checked" then
                        Error(Text009, "Bank Account Name", "Account No.");

                    if "Currency Code" <> "Payment Header"."Currency Code" then
                        Error(Text010);

                    PaymentClass.Get("Payment Header"."Payment Class");
                    if (PaymentClass."Line No. Series" <> '') and ("Document No." = '') then
                        Error(Text011);

                    RecordCode := '06';
                    OperationCode := '02';
                    FromPaymentNo := PadStr("Payment Header"."National Issuer No.", 6);

                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                GLAcct.Get("Account No.");
                                VendName := PadStr(GLAcct.Name, 24);
                            end;
                        "Account Type"::Customer:
                            begin
                                Cust.Get("Account No.");
                                VendName := PadStr(Cust.Name, 24);
                            end;
                        "Account Type"::Vendor:
                            begin
                                Vend.Get("Account No.");
                                VendName := PadStr(Vend.Name, 24);
                            end;
                        "Account Type"::"Bank Account":
                            begin
                                BankAcct.Get("Account No.");
                                VendName := PadStr(BankAcct.Name, 24);
                            end;
                        "Account Type"::"Fixed Asset":
                            begin
                                FixedAsset.Get("Account No.");
                                VendName := PadStr(FixedAsset.Description, 24);
                            end;
                    end;

                    "Payment Header".CalcFields("Status Name");

                    VendBankName := PadStr("Bank Account Name", 20);
                    BankBranchNo := PADSTR2("Bank Branch No.", 5, '0');
                    AgencyCode := PADSTR2("Agency Code", 5, '0');
                    BankAccountNo := PADSTR2("Bank Account No.", 11, '0');
                    Designation := PadStr("Payment Header"."Status Name", 31);
                    PrintAmount := FormatAmount(Amount, 16);
                    ExportedText :=
                      RecordCode +
                      OperationCode +
                      PadStr('', 8) +
                      FromPaymentNo +
                      PadStr('', 12) +
                      VendName +
                      VendBankName +
                      PadStr('', 12) +
                      AgencyCode +
                      BankAccountNo +
                      PrintAmount +
                      Designation +
                      BankBranchNo;

                    //ExportFile.Write(PadStr(ExportedText, 160));
                end;

                trigger OnPostDataItem()
                var
                    PaymentHeader: Record "WDC-ED Payment Header";
                    RecordCode: Text;
                    OperationCode: Text;
                    FromPaymentNo: Text;
                    PrintAmount: Text;
                    ExportedText: Text;
                begin
                    RecordCode := '08';
                    OperationCode := '02';
                    FromPaymentNo := PadStr("Payment Header"."National Issuer No.", 6);
                    PrintAmount := FormatAmount("Payment Header".Amount, 16);
                    ExportedText :=
                      RecordCode +
                      OperationCode +
                      PadStr('', 8) +
                      FromPaymentNo +
                      PadStr('', 84) +
                      PrintAmount;

                    //ExportFile.Write(PadStr(ExportedText, 160));

                    PaymentHeader := "Payment Header";
                    PaymentHeader."File Export Completed" := true;
                    PaymentHeader.Modify();
                end;
            }

            trigger OnAfterGetRecord()
            var
                ExportedText: Text;
                RecordCode: Text;
                OperationCode: Text;
                FromPaymentNo: Text;
                ExecutionDate: Text;
                CompanyName: Text;
                BankBranchNo: Text;
                AgencyCode: Text;
                BankAccountNo: Text;
                CurrencyIdentifier: Code[1];
            begin
                TestField("Account Type", "Account Type"::"Bank Account");
                TestField("National Issuer No.");
                TestField("No.");

                if StrLen("Bank Branch No.") > 5 then
                    Error(Text003, "No.");

                if StrLen("Agency Code") > 5 then
                    Error(Text003, "No.");

                if StrLen("Bank Account No.") > 11 then
                    Error(Text003, "No.");

                if not "RIB Checked" then
                    Error(Text004, "No.");

                if ("Currency Code" <> '') and ("Currency Code" <> GLSetup."LCY Code") then
                    Error(Text006, GLSetup."LCY Code");

                case "Currency Code" = '' of
                    true:
                        CurrencyIdentifier := 'E';
                    false:
                        CurrencyIdentifier := 'F';
                end;

                CalcFields(Amount);

                RecordCode := '03';
                OperationCode := '02';
                FromPaymentNo := PadStr("National Issuer No.", 6);
                ExecutionDate := Format("Posting Date", 4, '<Day,2><Month,2>') + CopyStr(Format("Posting Date", 2, '<Year,2>'), 2, 1);
                CompanyName := PadStr(CompanyInfo.Name, 24);
                BankBranchNo := PADSTR2("Bank Branch No.", 5, '0');
                AgencyCode := PADSTR2("Agency Code", 5, '0');
                BankAccountNo := PADSTR2("Bank Account No.", 11, '0');
                ExportedText :=
                  RecordCode +
                  OperationCode +
                  PadStr('', 8) +
                  FromPaymentNo +
                  PadStr('', 7) +
                  ExecutionDate +
                  CompanyName +
                  PadStr('', 26) +
                  CurrencyIdentifier +
                  PadStr('', 5) +
                  AgencyCode +
                  BankAccountNo +
                  PadStr('', 47) +
                  BankBranchNo;

                //ExportFile.Write(PadStr(ExportedText, 160));
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

    trigger OnPostReport()
    var
        ToFile: Text[260];
    begin
        // ExportFile.Close;
        // ToFile := Text012;
        // Download(ExportFileName, GetCaption, '', Text013, ToFile);
    end;

    trigger OnPreReport()
    var
    // FileMgt: Codeunit "File Management";
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);

        GLSetup.Get();

        // ExportFileName := FileMgt.ServerTempFileName('');

        // ExportFile.TextMode := true;
        // ExportFile.WriteMode := true;
        // ExportFile.Create(ExportFileName);
    end;

    local procedure GetCaption() Result: Text[50]
    var
        AllObjWithCaption: Record AllObjWithCaption;
        ID: Integer;
    begin
        Result := '';

        if not Evaluate(ID, DelChr(CurrReport.ObjectId(false), '=', DelChr(CurrReport.ObjectId(false), '=', '0123456789'))) then
            exit;

        if not AllObjWithCaption.Get(AllObjWithCaption."Object Type"::Report, ID) then
            exit;

        exit(CopyStr(AllObjWithCaption."Object Caption", 1, MaxStrLen(Result)));
    end;

    local procedure FormatAmount(Amount: Decimal; Width: Integer): Text[50]
    var
        FormatAmount: Text[50];
    begin
        FormatAmount := ConvertStr(Format(Amount, Width, '<Precision,2:2><Integer><Decimal><Comma,,>'), ' ', '0');
        FormatAmount := '0' + CopyStr(FormatAmount, 1, Width - 3) + CopyStr(FormatAmount, Width - 1, 2);
        exit(FormatAmount);
    end;

    local procedure PADSTR2(String: Text[1024]; Length: Integer; FillCharacter: Text[1]): Text[1024]
    var
        PaddingLength: Integer;
    begin
        PaddingLength := Length - StrLen(String);

        case true of
            PaddingLength <= 0:
                exit(PadStr(String, Length, FillCharacter));
            PaddingLength > 0:
                exit(PadStr('', PaddingLength, FillCharacter) + String);
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ExportFile: File;
        ExportFileName: Text[260];
        Text003: TextConst ENU = 'Bank Account No. %1 is too long. Please verify before continuing.',
                           FRA = 'Le n° de compte bancaire %1 est trop long. Vérifiez-le avant de continuer.';
        Text004: TextConst ENU = 'The RIB of the company''s bank account %1 is incorrect. Please verify before continuing.',
                           FRA = 'Le RIB du compte bancaire %1 de la société est erroné. Vérifiez-le avant de continuer.';
        Text006: TextConst ENU = 'You can only use currency code %1.',
                           FRA = 'Vous ne pouvez utiliser que le code devise %1.';
        Text008: TextConst ENU = 'The vendor''s bank account number %1 is too long. Please verify before continuing.',
                           FRA = 'Le n° de compte bancaire %1 du fournisseur est trop long. Vérifiez-le avant de continuer.';
        Text009: TextConst ENU = 'The RIB of the vendor''s bank account %1 %2 is incorrect. Please verify before continuing.',
                           FRA = 'Le RIB du compte bancaire %1 %2 du fournisseur est erroné. Vérifiez-le avant de continuer.',
                           Comment = '%1 - bank account name, %2 - bank account no';
        Text010: TextConst ENU = 'All transfers must refer to the same currency.',
                           FRA = 'Tous les virements doivent être liés à la même devise.';
        Text011: TextConst ENU = 'All transfers must have a document number.',
                           FRA = 'Tous les virements doivent avoir un n° de document.';
        Text012: TextConst ENU = 'default.txt',
                           FRA = 'default.txt';
        Text013: TextConst ENU = 'Text Files|*.txt|All Files|*.*',
                           FRA = 'ichiers texte|*.txt|Tous les fichiers|*.*';
}

