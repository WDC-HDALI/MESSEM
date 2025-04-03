namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Journal;

pageextension 50034 "WDC Lot No. Information List" extends "Lot No. Information List"
{
    layout
    {

        addbefore(Blocked)
        {

            field(PFD; Rec.PFD)
            {
                ApplicationArea = all;

            }
            field(Variety; Rec.Variety)
            {
                ApplicationArea = all;
            }
            field(Brix; Rec.Brix)
            {
                ApplicationArea = all;
            }
            field("Package Number"; Rec."Package Number")
            {
                ApplicationArea = all;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = all;
            }
            field("Purch. Received Quantity"; Rec."Purch. Received Quantity")
            {
                ApplicationArea = all;
            }
        }
    }
}
