namespace Messem.Messem;

using Microsoft.Foundation.Company;

pageextension 50501 "WDC-QA Company Information" extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {
            field(Background; Rec.Background)
            {
                ApplicationArea = All;
            }
        }
    }
}
