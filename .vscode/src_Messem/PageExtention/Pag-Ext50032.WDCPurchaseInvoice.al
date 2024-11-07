namespace MessemMA.MessemMA;

using Microsoft.Purchases.Document;

pageextension 50032 WDCPurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        addafter("Pay-to Contact")
        {
            field("N° ferme"; Rec.Farm)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Farm No.', FRA = 'N° ferme';
            }
        }
    }
}
