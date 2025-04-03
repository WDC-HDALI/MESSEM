namespace Messem.Messem;

using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Vendor;

tableextension 50509 "WDC-QA Item Ledger Entry" extends "Item Ledger Entry"
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
