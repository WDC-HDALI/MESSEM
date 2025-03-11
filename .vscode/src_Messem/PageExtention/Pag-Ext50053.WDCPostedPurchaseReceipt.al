namespace Messem.Messem;

using Microsoft.Manufacturing.Journal;
using Microsoft.Purchases.History;

pageextension 50053 "WDC Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
