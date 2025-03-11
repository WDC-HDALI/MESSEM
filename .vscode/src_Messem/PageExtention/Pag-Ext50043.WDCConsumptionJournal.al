namespace Messem.Messem;

using Microsoft.Manufacturing.Journal;

pageextension 50043 "WDC Consumption Journal" extends "Consumption Journal"
{
    procedure SetInformation(pOrderNo: Code[20]; pOrderLineNo: Integer)
    begin
        OpenedFromBatch := TRUE;
        OrderNo := pOrderNo;
        OrderLine := pOrderLineNo;
        FormPageOF := TRUE;
    end;

    var
        OpenedFromBatch: Boolean;
        FormPageOF: Boolean;
        OrderLine: Integer;
        OrderNo: Code[20];
}
