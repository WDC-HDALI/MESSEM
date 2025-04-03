namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item;

pageextension 50039 "WDC Inventory Posting Groups" extends "Inventory Posting Groups"
{
    layout
    {
        addafter(Description)
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field("Bin Code"; Rec."Bin Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
