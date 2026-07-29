namespace MESSEM.MESSEM;

using Microsoft.Purchases.History;

pageextension 50059 "WDC Posted Purchase Rec Line" extends "Posted Purchase Receipt Lines"
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                ApplicationArea = All;
            }
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
            }
            field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
