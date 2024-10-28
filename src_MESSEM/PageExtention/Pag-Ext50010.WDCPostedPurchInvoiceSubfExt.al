pageextension 50010 WDCPostedPurchInvoiceSubfExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
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
