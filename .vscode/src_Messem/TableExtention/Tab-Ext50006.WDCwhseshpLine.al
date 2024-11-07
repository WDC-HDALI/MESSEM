tableextension 50006 "WDC whse shp Line " extends "Warehouse Shipment Line"
{
    fields
    {
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Unit', FRA = 'Qté à traiter unité d''expédition';
            ;
            DataClassification = ToBeClassified;
        }
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            ;
            DataClassification = ToBeClassified;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            ;
            DataClassification = ToBeClassified;
        }
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Container', FRA = 'Qté par support logistique';
            ;
            DataClassification = ToBeClassified;
        }

    }
}
