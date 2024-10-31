pageextension 50008 "WDC Purchase Invoice" extends "Purchase Invoice"
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
