namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Ledger;

tableextension 50023 "WDC Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(50000; PFD; Code[20])
        {
            CaptionML = ENU = 'PFD', FRA = 'PFD';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; Variety; Code[20])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; Brix; Code[20])
        {
            CaptionML = ENU = 'Brix', FRA = 'Brix';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Package Number"; Integer)
        {
            CaptionML = ENU = 'Package Number', FRA = 'Nbre de Palette';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; Place; Code[20])
        {
            CaptionML = ENU = 'Place', FRA = 'Localisation';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(50005; "Purch. Received Quantity"; Decimal)
        {
            CaptionML = ENU = 'Purch. Received Quantity', FRA = 'Quantité réceptionnée (Achat)';
            FieldClass = FlowField;
            Editable = false;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  "Variant Code" = FIELD("Variant Code"),
                                                                  "Lot No." = FIELD("Lot No."),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Document Type" = FILTER(5 | 7 | 8)));
        }
    }
}