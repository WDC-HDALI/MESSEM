pageextension 50001 "WDC Prchse Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addafter("Bin Code")
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
            field("Shipm.Units per Shipm.Containr"; Rec."Qty Shipm.Units per Shipm.Cont")
            {
                ApplicationArea = all;

            }

        }
        addafter("Qty. to Receive")
        {
            field("Qty. to Receive Shipment Units"; Rec."Qty. to Receive Shipment Units")
            {
                ApplicationArea = all;

            }
            field("Qty. to Rec. Shipm. Containers"; Rec."Qty. to Rec. Shipm. Containers")
            {
                ApplicationArea = all;

            }


        }
        addafter("Line No.")
        {
            field("Qty. Shpt. Cont. Calc."; Rec."Qty. Shpt. Cont. Calc.")
            {
                ApplicationArea = all;

            }
            field("Qty. Rec. Shpt. Cont. Calc"; Rec."Qty. Rec. Shpt. Cont. Calc")
            {
                ApplicationArea = all;

            }
        }
        addlast(content)
        {
            field("Accrual Amount (LCY)"; Rec."Accrual Amount (LCY)")
            {
                ApplicationArea = all;
            }
            field("Rebate Code"; Rec."Rebate Code")
            {
                ApplicationArea = all;
            }
        }
    }

}



