pageextension 50906 "WDC-ED Accounting Periods" extends "Accounting Periods"
{
    layout
    {
        addlast(Control1)
        {

            field("Fiscally Closed"; Rec."Fiscally Closed")
            {
                ApplicationArea = All;
            }
            field("Fiscal Closing Date"; Rec."Fiscal Closing Date")
            {
                ApplicationArea = All;
            }
            field("Period Reopened Date"; Rec."Period Reopened Date")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
    }
}