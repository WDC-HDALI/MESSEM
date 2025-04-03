namespace Messem.Messem;

using Microsoft.Manufacturing.Document;

reportextension 50000 "WDC Refresh Production Order" extends "Refresh Production Order"
{
    dataset
    {
        modify(InitializeRequest)
        {

        }

    }
    procedure InitializeRequest1(ShowProgress2: Boolean)
    begin
        ShowProgress := ShowProgress2;
    end;

    var
        ShowProgress: Boolean;
}
