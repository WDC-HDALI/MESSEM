namespace Messem.Messem;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Purchases.Vendor;

pageextension 50051 "WDC Payment Journal" extends "Payment Journal"
{
    layout
    {

        modify("Recipient Bank Account")
        {
            trigger OnAfterValidate()
            var
                VendorBankAccount: Record "Vendor Bank Account";
            begin
                if VendorBankAccount.Get(Rec."Account No.", Rec."Recipient Bank Account") then begin
                    Rec.Rib := VendorBankAccount."Bank Account No.";
                    Rec.Modify();
                end;
            end;
        }
        addbefore("Posting Date")
        {
            field("To Post"; Rec."To Post")
            {
                ApplicationArea = all;
            }
        }
        addafter("Recipient Bank Account")
        {
            field(RIB; Rec.RIB)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
        }

        addbefore("Account No.")
        {
            field("Bank Name"; Rec."Bank Name")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {

        addafter("&Line")
        {
            action("Imprimer virement en masse")
            {
                CaptionML = ENU = 'Print bulk transfer', FRA = 'Imprimer virement en masse';
                Image = "Report";
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PaymentJournalMessem_Excel: Report "WDC Payment Journal Excel";
                begin
                    GenJnlLine.reset;
                    GenJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name");
                    GenJnlLine.SETRANGE("Journal Template Name", 'PAIEMENTS');
                    GenJnlLine.SETRANGE("Journal Batch Name", 'DÉFAULT');
                    PaymentJournalMessem_Excel.SETTABLEVIEW(GenJnlLine);
                    PaymentJournalMessem_Excel.RUNMODAL

                end;
            }
            action("Test Report MM")
            {
                CaptionML = ENU = 'Test Report', FRA = 'Rapport test';
                Image = TestReport;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report 50023;
            }

        }
    }
    var
        GenJnlLine: Record 81;
        ReportPrint: Codeunit 228;

}
