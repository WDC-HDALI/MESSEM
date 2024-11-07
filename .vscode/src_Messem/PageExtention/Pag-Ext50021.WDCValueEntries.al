namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;

pageextension 50021 "WDC Value Entries" extends "Value Entries"
{
    layout
    {
        addafter("Cost Amount (Actual)")
        {
            field("Rebate Accrual Amount (LCY)"; Rec."Rebate Accrual Amount (LCY)")
            {
                ApplicationArea = all;
            }
        }
    }
}
