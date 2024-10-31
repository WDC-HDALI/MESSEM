pageextension 50005 "WDC Item Ledg Entries " extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Balance Reg. Customer/Vend.No."; Rec."Balance Reg. Customer/Vend.No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
