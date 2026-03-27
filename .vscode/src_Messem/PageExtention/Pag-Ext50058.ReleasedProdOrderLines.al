namespace MESSEM.MESSEM;

using Microsoft.Manufacturing.Document;

pageextension 50058 ReleasedProdOrderLines extends "Released Prod. Order Lines"
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
