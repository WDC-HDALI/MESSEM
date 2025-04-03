namespace MESSEM.MESSEM;

using Microsoft.Sales.Setup;
using Microsoft.Purchases.Setup;

pageextension 50403 "WDC-TRS Purchases & Pay. Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Transport purchase Item No."; Rec."Trans. Purch. Charge")
            {
                ApplicationArea = all;
            }
        }
    }
}
