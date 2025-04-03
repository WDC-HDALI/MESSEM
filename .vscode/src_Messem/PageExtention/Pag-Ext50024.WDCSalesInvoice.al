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
                CaptionML = ENU = 'Scelle No.', FRA = 'Nombre de points maximum';
                ApplicationArea = all;
            }
            field("Forwarding Agent"; Rec."Forwarding Agent")
            {
                captionml = FRA = 'Nombre de points', ENU = 'Forwarding Agent';
                ApplicationArea = all;
            }
        }
        addlast("Foreign Trade")
        {
            field("Destination Port"; Rec."Destination Port")
            {
                CaptionML = ENU = 'Destination Port', FRA = 'Taux maximum remise BQ';
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