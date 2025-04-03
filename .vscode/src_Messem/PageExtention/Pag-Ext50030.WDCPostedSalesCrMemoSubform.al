namespace MessemMA.MessemMA;

using Microsoft.Sales.History;

pageextension 50030 "WDCPostedSalesCrMemoSubform" extends "Posted Sales Cr. Memo Subform"
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
        }

    }
}
