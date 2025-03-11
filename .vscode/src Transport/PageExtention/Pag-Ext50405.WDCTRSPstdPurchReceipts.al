namespace MESSEM.MESSEM;

using Microsoft.Sales.Setup;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Setup;
//WDC01  WDC.HG  03/01/2025  show field "sales Order No."

pageextension 50405 "WDC-TRS Pstd Purch Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("Transport purchase Item No."; Rec."Transport Order No.")
            {
                ApplicationArea = all;
            }
            //<<WDC01
            field("sales Order No."; Rec."sales Order No.")
            {
                ApplicationArea = all;
            }
            //>>WDC01

        }
    }
}
