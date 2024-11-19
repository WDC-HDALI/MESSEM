namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Warehouse.Structure;

tableextension 50040 "WDC Inventory Posting Group" extends "Inventory Posting Group"
{
    fields
    {
        field(50000; "Location Code"; code[10])
        {
            Captionml = ENU = 'Location Code', FRA = 'Code magasin';
            DataClassification = ToBeClassified;
            tablerelation = Location;

        }
        field(50001; "Bin Code"; code[20])
        {
            Captionml = ENU = 'Bin Code', FRA = 'Code emplacement';
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
    }
}
