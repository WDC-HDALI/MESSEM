namespace Messem.Messem;

using Microsoft.Inventory.Journal;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Tracking;

tableextension 50506 "WDC-QA Tracking Specification" extends "Tracking Specification"
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
