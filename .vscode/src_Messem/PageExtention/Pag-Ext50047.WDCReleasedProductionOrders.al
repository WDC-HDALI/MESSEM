namespace Messem.Messem;

using Microsoft.Manufacturing.Document;

pageextension 50047 "WDC Released Production Orders" extends "Released Production Orders"
{
    layout
    {
        addafter("No.")
        {
            field("Sous traitance"; Rec."Sous traitance")
            {
                ApplicationArea = All;
            }
        }
    }
}
