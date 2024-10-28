pageextension 50008 "WDCPurchase InvoicePagExt" extends "Purchase Invoice"
{
    layout
    {
        addafter("Buy-from Contact")
        {

            field(Farm; Rec.Farm)
            {
                ApplicationArea = all;

            }
        }

    }
}
