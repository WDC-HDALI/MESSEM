namespace MESSEM.MESSEM;

using Microsoft.Inventory.Journal;

pageextension 50038 "WDC Item Journal Batches" extends "Item Journal Batches"
{
    layout
    {
        addafter("Reason Code")
        {
            field("Entry Type"; Rec."Entry Type")
            {
                ApplicationArea = all;
                style = Attention;
                StyleExpr = true;
            }
            field("Source Type by Default"; Rec."Source Type by Default")
            {
                ApplicationArea = all;
            }

        }
        modify("Item Tracking on Lines")
        {
            visible = false;
        }
    }
}
