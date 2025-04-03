namespace MESSEM.MESSEM;

using Microsoft.Purchases.History;
//*************Documentation**************
//WDC01  WDC.HG  03/01/2025  show sales order No.

pageextension 50407 "WDC-TRS Get Receipt Lines" extends "Get Receipt Lines"
{
    layout
    {
        addafter(OrderNo)
        {
            field("External Doc No."; Rec."External Doc No.")
            {
                ApplicationArea = all;
            }
            //>>WDC01
            field("sales order"; Rec."sales order")
            {
                ApplicationArea = all;
            }
            //>>WDC01

        }
    }

}

