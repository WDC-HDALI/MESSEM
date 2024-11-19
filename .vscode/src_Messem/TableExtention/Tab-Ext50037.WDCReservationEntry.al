namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;

tableextension 50037 "WDC Reservation Entry" extends "Reservation Entry"
{
    fields
    {
        field(50000; PFD; Code[20])
        {
            CaptionML = ENU = 'PFD', FRA = 'PFD';
            DataClassification = ToBeClassified;
        }
        field(50001; Variety; Code[20])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            DataClassification = ToBeClassified;
        }
        field(50002; Brix; Code[20])
        {
            CaptionML = ENU = 'Brix', FRA = 'Brix';
            DataClassification = ToBeClassified;
        }
        field(50003; "Package Number"; Integer)
        {
            CaptionML = ENU = 'Package Number', FRA = 'Nbre de Palette';
            DataClassification = ToBeClassified;
        }
        field(50004; Place; Code[20])
        {
            CaptionML = ENU = 'Place', FRA = 'Localisation';
            DataClassification = ToBeClassified;

        }
    }
}
