namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;
using Microsoft.Finance.GeneralLedger.Setup;

pageextension 50017 "WDC General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("Calculation of Tax  0 to 30 D"; Rec."Calculation of Tax  0 to 30 D")
            {
                ApplicationArea = all;
            }
            field("Calculation of Tax 31 to 60 D"; Rec."Calculation of Tax 31 to 60 D")
            {
                ApplicationArea = all;
            }
            field("Calculation of Tax 61 to 90 D"; Rec."Calculation of Tax 61 to 90 D")
            {
                ApplicationArea = all;
            }
            field("Calculation of Tax more 91 D"; Rec."Calculation of Tax more 91 D")
            {
                ApplicationArea = all;
            }
        }

    }
}


