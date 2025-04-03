namespace MESSEM.MESSEM;

using Microsoft.Purchases.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.NoSeries;

tableextension 50402 "WDC-TRS Sales Receiv. Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50400; "Transport Order Nos."; Code[20])
        {
            CaptionML = ENU = 'Transport Order Nos.', FRA = 'Ordre transport Nos.';
            TableRelation = "No. Series";
        }
        field(50401; "Transport Sales Item No."; Code[20])
        {
            CaptionML = ENU = 'Transport Sales Item No.', FRA = 'N° article transport vente';
            TableRelation = Item;
        }
    }
}
