namespace MessemMA.MessemMA;

using Microsoft.Sales.History;

pageextension 50023 "WDC PostedSalesShipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
        {
            field("Pallet Quantity"; Rec."Pallet Quantity")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Forwarding Agent"; Rec."Forwarding Agent")
            {
                ApplicationArea = all;
            }
            field("Container No."; Rec."Container No.")
            {
                ApplicationArea = all;
            }
            field("Scelle No."; Rec."Scelle No.")
            {
                ApplicationArea = all;
            }
            field("Destination Port"; Rec."Destination Port")
            {
                ApplicationArea = all;
            }
            field("Notify Party 1"; Rec."Notify Party 1")
            {
                ApplicationArea = all;
            }
            field("Notify Party 2"; Rec."Notify Party 2")
            {
                ApplicationArea = all;
            }

        }
    }

}
