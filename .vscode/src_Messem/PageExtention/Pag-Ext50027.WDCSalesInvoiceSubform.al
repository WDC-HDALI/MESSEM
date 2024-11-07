namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;

pageextension 50027 "WDC SalesInvoiceSubform" extends "Sales Invoice Subform"
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
        }
    }
}
