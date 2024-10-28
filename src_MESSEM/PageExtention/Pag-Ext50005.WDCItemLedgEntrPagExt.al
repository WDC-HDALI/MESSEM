pageextension 50005 "WDC Item Ledg Entr PagExt" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Balance Reg. Customer/Vend.No."; Rec."Balance Reg. Customer/Vend.No.")
            {

            }
        }
    }
}
