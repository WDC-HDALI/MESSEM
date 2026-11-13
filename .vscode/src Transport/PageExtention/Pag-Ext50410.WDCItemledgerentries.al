namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;
//********************Documentation*******************
//WDC01  WDC.HG  12/11/2026  Create Current Object
pageextension 50410 "WDC Item ledger entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document Line No.")
        {
            field("Transport External Doc No."; Rec."Transport External Doc No.")
            {
                ApplicationArea = all;
            }
            field("Transport Sales Order"; Rec."Transport Sales Order")
            {
                ApplicationArea = all;
            }
        }

    }
}
