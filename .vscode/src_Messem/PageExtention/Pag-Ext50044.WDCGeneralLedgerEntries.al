namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 50044 "WDC General Ledger Entrie" extends "General Ledger Entries"
{
    layout
    {

        addafter(Description)
        {
            field("Purchase Description"; Rec."Purchase Description")
            {
                ApplicationArea = All;
            }
        }
    }
}
