namespace MessemMA.MessemMA;

using Microsoft.Inventory.Location;

pageextension 50031 WDCLocationCard extends "Location Card"

{
    layout
    {
        addbefore(Receipt)
        {
            field("Packaging ReceiveShip Bin Code"; Rec."Packaging ReceiveShip Bin Code")
            {
                ApplicationArea = all;
            }
        }
    }
}
