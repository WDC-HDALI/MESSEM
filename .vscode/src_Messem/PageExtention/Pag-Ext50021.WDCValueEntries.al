namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;
//******************Documentation*******************
//WDC01  WDC.HG  13/11/2025 Add "Lot No." field 
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
        addafter("Item No.")
        {
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
