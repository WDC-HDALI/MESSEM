namespace MessemMA.MessemMA;

using Microsoft.Purchases.History;

tableextension 50031 WDCPurchInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Farm"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WDC Farm".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            CaptionML = ENU = 'Farm No.', FRA = 'Fournisseur frais généraux';
        }
    }
}
