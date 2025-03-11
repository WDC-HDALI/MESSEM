namespace MESSEM.MESSEM;

using Microsoft.Sales.History;

pageextension 50040 "WDC Posted Sales Invoices" extends "Posted Sales Invoices"
{
    actions
    {
        addafter(Print)
        {
            action("Print Loading ")
            {
                CaptionML = ENU = 'Print Loading ', FRA = 'Imprimer chargement', NLD = '&Afdrukken';
                Ellipsis = true;
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    REPORT.RUNMODAL(50012, TRUE, TRUE, SalesInvHeader);
                end;
            }


        }
    }

}
