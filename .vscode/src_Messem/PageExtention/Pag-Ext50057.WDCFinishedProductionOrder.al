namespace MESSEM.MESSEM;

using Microsoft.Manufacturing.Document;

pageextension 50057 WDCFinishedProductionOrder extends "Finished Production Order"
{

    actions
    {
        addafter(Statistics)
        {
            action("Actual Cost")
            {
                Caption = 'Actual Cost';
                Ellipsis = true;
                Image = CalculateCost;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CurrPage.ProdOrderLines.PAGE.ShowActualCosts;
                end;
            }
        }
    }

}