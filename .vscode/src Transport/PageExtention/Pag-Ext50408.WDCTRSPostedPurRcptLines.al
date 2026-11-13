namespace MESSEM.MESSEM;

using Microsoft.Purchases.History;
//********************Documentation*******************
//WDC01  WDC.HG  12/11/2026  Create Current Object
pageextension 50408 WDCTRSPostedPurRcptLines extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter(Description)
        {
            field("External Doc No."; Rec."External Doc No.")
            {
                ApplicationArea = all;
            }
            field("sales order"; Rec."sales order")
            {
                ApplicationArea = all;
            }
        }
    }

}
