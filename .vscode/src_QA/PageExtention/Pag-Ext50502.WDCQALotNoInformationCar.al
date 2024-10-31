namespace MessemMA.MessemMA;

using Microsoft.Inventory.Tracking;

pageextension 50502 "WDC-QA Lot No. Information Car" extends "Lot No. Information Card"
{
    layout
    {
        addafter(Description)
        {
            field("Qty Shipm.Units per Shipm.Cont"; Rec."Qty Shipm.Units per Shipm.Cont")
            {
                ApplicationArea = all;
            }
        }
    }
}
