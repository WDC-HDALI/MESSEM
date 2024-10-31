pageextension 50000 "WDC ItemCard " extends "Item Card"
{
    layout
    {
        addafter("Next Counting End Date")
        {
            field("Shipment Unit"; Rec."Shipment Unit")
            {
                ApplicationArea = all;

            }
            field("Qty. per Shipment Unit"; Rec."Qty. per Shipment Unit")
            {
                ApplicationArea = all;

            }
            field("Label Type"; Rec."Label Type")
            {
                ApplicationArea = all;

            }
            field("Shipment Container"; Rec."Shipment Container")
            {
                ApplicationArea = all;

            }
            field("Shipm.Units per Shipm.Containr"; Rec."Shipm.Units per Shipm.Containr")
            {
                ApplicationArea = all;

            }
            field("Qty. per Shipment Container"; Rec."Qty. per Shipment Container")
            {
                ApplicationArea = all;

            }
            field("Qty. per Layer"; Rec."Qty. per Layer")
            {
                ApplicationArea = all;

            }
            field("No. of Layers"; Rec."No. of Layers")
            {
                ApplicationArea = all;

            }


        }
    }

}
