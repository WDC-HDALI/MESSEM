namespace MessemMA.MessemMA;

using Microsoft.Sales.History;

pageextension 50025 "WDC Posted Sales Invoice" extends "Posted Sales Invoice"
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
        addlast("Foreign Trade")
        {
            field("Destination Port"; Rec."Destination Port")
            {
                ApplicationArea = all;
            }
            field("Scelle No."; Rec."Scelle No.")
            {
                ApplicationArea = all;
            }


        }
        addlast("Bill-to")
        {
            group("EDI")
            {
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
}
