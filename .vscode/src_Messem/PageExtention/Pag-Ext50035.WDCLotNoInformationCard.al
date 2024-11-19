namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Journal;

pageextension 50035 "WDC Lot No. Information Card" extends "Lot No. Information Card"
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
        }
    }
}
