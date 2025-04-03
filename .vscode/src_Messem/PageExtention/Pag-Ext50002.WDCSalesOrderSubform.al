pageextension 50002 "WDC Sales Order Subform " extends "Sales Order Subform"
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
        addafter("Qty. to Ship")
        {


            field("Qty. to Ship Shipment Units"; Rec."Qty. to Ship Shipment Units")
            {
                ApplicationArea = all;

            }
            field("Qty. to Ship Shipm. Containers"; Rec."Qty. to Ship Shipm. Containers")
            {
                ApplicationArea = all;

            }
            field("Harmonised Tariff Code"; Rec."Harmonised Tariff Code")
            {
                ApplicationArea = all;

            }
        }

        addafter("Shipment Date")
        {

            field("Qty. Shpt. Cont. Calc."; Rec."Qty. Shpt. Cont. Calc.")
            {
                ApplicationArea = all;

            }

            field("Qty. Shipped Shpt. Cont. Calc."; Rec."Qty. Shipped Shpt. Cont. Calc.")
            {
                ApplicationArea = all;

            }

        }
        modify("Bin Code")
        {
            Visible = TRUE;
        }
        moveafter("Location Code"; "Bin Code")
    }


}
