pageextension 50007 "WDC Pstd Pur Rcpt Subform " extends "Posted Purchase Rcpt. Subform"
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
