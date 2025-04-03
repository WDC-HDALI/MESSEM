namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 50054 "WDC General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addbefore(Amount)
        {
            field("Debit Amount_"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount_"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
        }
    }
}
