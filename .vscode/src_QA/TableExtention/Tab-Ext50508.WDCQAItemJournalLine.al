namespace Messem.Messem;

using Microsoft.Inventory.Journal;
using Microsoft.Purchases.Vendor;

tableextension 50508 "WDC-QA Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(50500; "Buy-from Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
    }
}
