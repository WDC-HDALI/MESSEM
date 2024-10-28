tableextension 50005 "WDC Prod. Order Line TabExt" extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            Caption = 'Shipment Unit';
            DataClassification = ToBeClassified;
        }

    }
}
