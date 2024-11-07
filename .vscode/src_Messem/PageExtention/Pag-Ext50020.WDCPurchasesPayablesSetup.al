namespace MESSEM.MESSEM;

using Microsoft.Purchases.Setup;

pageextension 50020 "WDC Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {

        addlast("Background Posting")
        {
            group(order)
            {
                field("Date Price-and Discount Def."; Rec."Date Price-and Discount Def.")
                {
                    ApplicationArea = all;
                }
            }
        }

    }
}
