namespace Messem.Messem;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Vendor;

tableextension 50507 "WDC-QA Reservation Entry" extends "Reservation Entry"
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
