namespace MessemMA.MessemMA;

using Microsoft.Sales.History;

pageextension 50026 "WDC PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform"
{

    layout
    {
        addafter("Unit of Measure")
        {
            field("Shipment Unit"; Rec."Shipment Unit")
            {
                ApplicationArea = all;
            }
            field("Quantity Shipment Units"; Rec."Quantity Shipment Units")
            {
                ApplicationArea = all;
            }
            field("Shipment Container"; Rec."Shipment Container")
            {
                ApplicationArea = all;
            }
            field("Quantity Shipment Containers"; Rec."Quantity Shipment Containers")
            {
                ApplicationArea = all;
            }
            field("Harmonised Tariff Code"; Rec."Harmonised Tariff Code")
            {
                ApplicationArea = all;

            }
            // field("Unit Price per Sales Price UOM"; Rec."Unit Price per Sales Price UOM")
            // {
            //     ApplicationArea = all;
            // }
        }
        modify("Bin Code")
        {
            Visible = TRUE;
        }
        moveafter("Location Code"; "Bin Code")
    }
}
