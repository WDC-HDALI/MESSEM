namespace MESSEM.MESSEM;

using Microsoft.Manufacturing.Document;

pageextension 50056 WDCFinishedProdOrderLines extends "Finished Prod. Order Lines"
{
    procedure ShowActualCosts()
    begin
        clear(ProdOrderCostDetailLines);
        ProdOrderCostDetailLines.SetProdOrderLine(rec);
        ProdOrderCostDetailLines.RunModal();

    end;

    var
        ProdOrderCostDetailLines: page "Prod. Order Cost Detail Lines";
}
