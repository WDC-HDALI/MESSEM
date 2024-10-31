namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;

tableextension 50023 "WDC Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(50000; "Lot Attribute 1"; Code[20])
        {
            CaptionML = ENU = 'Lot Attribute 1', FRA = 'Attribut Lot 1';
            DataClassification = ToBeClassified;
            CaptionClass = '13,1,1';
            TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"1"));
        }
        field(50001; "Lot Attribute 2"; Code[20])
        {
            CaptionML = ENU = 'Lot Attribute 2', FRA = 'Attribut Lot 2';
            DataClassification = ToBeClassified;
            CaptionClass = '13,1,2';
            TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"2"));
        }
        field(50002; "Lot Attribute 3"; Code[20])
        {
            CaptionML = ENU = 'Lot Attribute 3', FRA = 'Attribut Lot 3';
            DataClassification = ToBeClassified;
            CaptionClass = '13,1,3';
            TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"3"));
        }

        field(50003; "Lot Attribute 4"; Code[20])
        {
            CaptionML = ENU = 'Lot Attribute 4', FRA = 'Attribut Lot 4';
            DataClassification = ToBeClassified;
            CaptionClass = '13,1,4';
            TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"4"));
        }
        field(50004; "Lot Attribute 5"; Code[20])
        {
            CaptionML = ENU = 'Lot Attribute 5', FRA = 'Attribut Lot 5';
            DataClassification = ToBeClassified;
            CaptionClass = '13,1,5';
            TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"5"));
        }

    }
}
