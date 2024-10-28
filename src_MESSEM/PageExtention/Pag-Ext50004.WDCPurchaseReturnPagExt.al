pageextension 50004 "WDC Purchase Return PagExt" extends "Purchase Return Order Subform"
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
        addafter("Return Qty. to Ship")
        {
            field("Return Qty. to Ship S.Units"; Rec."Return Qty. to Ship S.Units")
            {
                ApplicationArea = all;

            }
            field("Return Qty. to Ship S.Cont."; Rec."Return Qty. to Ship S.Cont.")
            {
                ApplicationArea = all;

            }


        }
        addlast(Control1)
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





    }
}
