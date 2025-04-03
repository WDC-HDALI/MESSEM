namespace MESSEM.MESSEM;

using Microsoft.Foundation.Shipping;
using Microsoft.Purchases.Vendor;

pageextension 50404 "WDC-TRS Shipping Agents" extends "Shipping Agents"
{
    layout
    {
        addafter(Name)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
