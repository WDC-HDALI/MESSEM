namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;

pageextension 50024 "WDC SalesInvoice" extends "Sales Invoice"
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
        addafter("Shipping Agent Code")
        {

            field("Container No."; Rec."Container No.")
            {
                CaptionML = ENU = 'Container No.', FRA = '% remise  BQ';
                ApplicationArea = all;
            }
            field("Scelle No."; Rec."Scelle No.")
            {
                ApplicationArea = all;
            }
            field("Forwarding Agent"; Rec."Forwarding Agent")
            {
                captionml = FRA = 'Nombre de points', ENU = 'Forwarding Agent';
                ApplicationArea = all;
            }
            field("Transport Tariff Code"; Rec."Transport Tariff Code")
            {
                ApplicationArea = all;
            }


        }

    }

}