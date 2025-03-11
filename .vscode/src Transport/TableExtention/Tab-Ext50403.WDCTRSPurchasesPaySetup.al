namespace MESSEM.MESSEM;

using Microsoft.Purchases.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.NoSeries;

tableextension 50403 "WDC-TRS Purchases Pay. Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50400; "Trans. Purch. Charge"; Code[20])
        {
            CaptionML = ENU = 'Transport Purch. Charge', FRA = 'N° Frais transport achat';
            TableRelation = "Item Charge";
        }
    }
}
