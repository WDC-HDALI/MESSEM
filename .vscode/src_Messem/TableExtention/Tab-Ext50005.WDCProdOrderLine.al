tableextension 50005 "WDC Prod. Order Line " extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
        }

    }
}
