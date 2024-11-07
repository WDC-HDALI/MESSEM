namespace MessemMA.MessemMA;

using Microsoft.Sales.Comment;

tableextension 50030 "WDC SalesCommentLine" extends "Sales Comment Line"
{
    fields
    {
        field(50000; "Shipment/Receipt"; Boolean)
        {
            CaptionML = ENU = 'Shipment/ Receipt', FRA = 'Expédition / Réception';
            DataClassification = ToBeClassified;
        }
    }
}
