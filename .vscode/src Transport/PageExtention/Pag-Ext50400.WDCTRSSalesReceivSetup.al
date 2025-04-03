namespace MESSEM.MESSEM;

using Microsoft.Sales.Setup;

pageextension 50400 "WDC-TRS Sales & Receiv. Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Transport Order Nos."; Rec."Transport Order Nos.")
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("Transport Sales Item No."; Rec."Transport Sales Item No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
