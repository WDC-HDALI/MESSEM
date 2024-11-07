namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;

pageextension 50015 WDCSalesOrder extends "Sales Order"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Pallet Quantity"; Rec."Pallet Quantity")
            {
                ApplicationArea = all;
            }
        }
    }
}


