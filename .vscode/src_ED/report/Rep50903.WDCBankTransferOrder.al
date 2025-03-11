namespace MESSEM.MESSEM;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Vendor;

report 50903 "WDC Bank Transfer Order"
{
    CaptionML = ENU = 'Bank Transfer Order', FRA = 'Ordre de Virement Bancaire';
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_ED/report/RDLC/BankTransferOrder.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(WDCEDPaymentHeader; "WDC-ED Payment Header")
        {
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }

            column(Bank_Country_Region_Code; "Bank Country/Region Code")
            {
            }
            column(AccountNo; "Account No.")
            {
            }

            column(AccountType; "Account Type")
            {
            }
            column(Payment_Class_Name; "Payment Class Name")
            {
            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(AgencyCode; "Agency Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountLCY; "Amount (LCY)")
            {
            }
            column(BankAccountNo; "Bank Account No.")
            {
            }
            column(BankAddress; "Bank Address")
            {
            }
            column(BankAddress2; "Bank Address 2")
            {
            }
            column(BankBranchNo; "Bank Branch No.")
            {
            }
            column(BankCity; "Bank City")
            {
            }
            column(BankContact; "Bank Contact")
            {
            }
            column(BankCountryRegionCode; "Bank Country/Region Code")
            {
            }
            column(BankCounty; "Bank County")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(BankName2; "Bank Name 2")
            {
            }
            column(BankPostCode; "Bank Post Code")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(IBAN; IBAN)
            {
            }
            column(NationalIssuerNo; "National Issuer No.")
            {
            }
            column(No; "No.")
            {
            }
            column(NoofUnpostedLines; "No. of Unposted Lines")
            {
            }
            column(PartnerType; "Partner Type")
            {
            }
            column(PaymentClass; "Payment Class")
            {
            }
            column(PaymentClassName; "Payment Class Name")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            dataitem("WDC-ED Payment Line"; "WDC-ED Payment Line")
            {
                DataItemLink = "No." = FIELD("No."),
                               "Payment Class" = FIELD("Payment Class");
                RequestFilterFields = "No.";
                column(Account_Type; "Account Type")
                {
                }
                column(Account_No_; "Account No.")
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(Document_No_; "Document No.")
                {
                }
                column(Bank_Account_No_; "Bank Account No.")
                {
                }
                column(Bank_Account_Name; "Bank Account Name")
                {
                }
                column(Amount__LCY_; "Amount (LCY)")
                {
                }

                trigger OnAfterGetRecord()
                var
                    lVendor: Record Vendor;

                begin

                    if "WDC-ED Payment Line"."Account Type" = "WDC-ED Payment Line"."Account Type"::Vendor then
                        if lVendor.Get("WDC-ED Payment Line"."Account No.") then
                            VendorName := lVendor.Name;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CompanyInfo.get;
                CompanyInfo.CALCFIELDS(Picture);


                //  TxtReportTitle := STRSUBSTNO(TxtTitre, "Payment Header"."Type Règlement");
            end;
        }
    }
    var
        VendorName: Text[100];
        CompanyInfo: Record 79;
}

