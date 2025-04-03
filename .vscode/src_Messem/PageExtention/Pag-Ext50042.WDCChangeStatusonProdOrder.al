namespace Messem.Messem;

using Microsoft.Manufacturing.Document;

pageextension 50042 "WDC Change Status on ProdOrder" extends "Change Status on Prod. Order"
{
    layout
    {

    }
    procedure Set2(EnableSuppressMessages2: Boolean)
    begin
        EnableSuppressMessages := EnableSuppressMessages2;
    end;

    procedure ReturnPostingInfo2(var SuppressMessages2: Boolean)
    begin
        SuppressMessages2 := SuppressMessages;

    end;

    var
        EnableSuppressMessages: Boolean;
        SuppressMessages: Boolean;
}
