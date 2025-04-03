namespace Sogrega.Sogrega;

using Microsoft.Sales.History;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Inventory.Ledger;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.VAT.Ledger;

report 50025 "WDC Update Rebate Value Entry"
{
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/Update_.rdlc';
    ApplicationArea = All;
    Caption = 'Update Rebate Value Entry';
    UsageCategory = Lists;
    Permissions = TableData "G/L Entry" = rimd,
   TableData "VAT Entry" = rimd,
   TableData "Value Entry" = rimd,
   TableData "Sales Invoice Line" = rimd,
   TableData "Cust. Ledger Entry" = rimd,
   TableData "Detailed Cust. Ledg. Entry" = rimd,
               TableData "Sales Invoice Header" = rimd;

    dataset
    {
        dataitem("Company Information"; 79)
        {
            column(CompanyName; "Company Information".Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                lRebatEtries: Record "WDC Rebate Entry";
                lValueEntrie: Record 5802;
                lItemLedgerEntry: Record "Item Ledger Entry";
            begin
                // lRebatEtries.Reset();
                // lRebatEtries.setrange("Posting Date", 20250226D, 20250312D);
                // //lRebatEtries.SetFilter("Document No.", '152640');
                // if lRebatEtries.FindFirst() then
                //     repeat
                //         lValueEntrie.Reset();
                //         lValueEntrie.SetCurrentKey("Document No.", "Gen. Prod. Posting Group");
                //         lValueEntrie.SetRange("Document No.", lRebatEtries."Document No.");
                //         lValueEntrie.SetFilter("Gen. Prod. Posting Group", 'AV-FRAISES');
                //         if lValueEntrie.FindSet() then
                //             repeat
                //                 if lValueEntrie."Rebate Accrual Amount (LCY)" = 0 then begin
                //                     lValueEntrie."Rebate Accrual Amount (LCY)" := lRebatEtries."Accrual Amount (LCY)";
                //                     lValueEntrie.Modify();
                //                 end;
                //             until lRebatEtries.Next() = 0;
                //     until lRebatEtries.Next() = 0;
                lItemLedgerEntry.Reset();

                lItemLedgerEntry.SetFilter("Item No.", '10*');
                lItemLedgerEntry.SetFilter("Source No.", '279|30|366|375|439|443|485|488|493|555|646|648|650|705|802|818|96|99');
                lItemLedgerEntry.SetRange("Entry Type", lItemLedgerEntry."Entry Type"::Purchase);
                lItemLedgerEntry.CalcFields("Rebate Accrual Amount (LCY)");
                lItemLedgerEntry.SetRange("Rebate Accrual Amount (LCY)", 0);
                //lItemLedgerEntry.SetRange("Entry No.", 10147);
                if lItemLedgerEntry.FindSet() then begin
                    repeat
                        lValueEntrie.Reset();
                        lValueEntrie.SetCurrentKey("Document No.", "Gen. Prod. Posting Group");
                        lValueEntrie.SetRange("Item Ledger Entry No.", lItemLedgerEntry."Entry No.");
                        lValueEntrie.SetRange("Document Type", lValueEntrie."Document Type"::"Purchase Invoice");
                        lValueEntrie.SetFilter("Gen. Prod. Posting Group", 'AV-FRAISES');
                        if lValueEntrie.FindSet() then begin
                            lRebatEtries.Reset();
                            lRebatEtries.SetFilter("Document No.", lValueEntrie."Document No.");
                            lRebatEtries.setrange("Vendor No.", lValueEntrie."Source No.");
                            lRebatEtries.SetRange("Posting Date", lValueEntrie."Posting Date");
                            if lRebatEtries.FindFirst() then begin
                                repeat
                                    if lRebatEtries."Accrual Amount (LCY)" <> 0 then begin
                                        lValueEntrie."Rebate Accrual Amount (LCY)" := lRebatEtries."Accrual Amount (LCY)";
                                        lValueEntrie.Modify();
                                    end;
                                until lRebatEtries.Next() = 0;
                            end;
                        end;
                    until lItemLedgerEntry.Next() = 0;
                end;
            end;
        }
    }
}
