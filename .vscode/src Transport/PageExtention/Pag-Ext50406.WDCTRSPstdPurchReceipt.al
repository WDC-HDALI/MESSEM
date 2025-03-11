namespace MESSEM.MESSEM;

using Microsoft.Sales.Setup;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
//WDC01  WDC.HG  03/01/2025  show field "sales Order No."
pageextension 50406 "WDC-TRS Pstd Purch Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("Transport Order No."; Rec."Transport Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC01
            field("sales Order No."; Rec."sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC01

        }
    }
}
