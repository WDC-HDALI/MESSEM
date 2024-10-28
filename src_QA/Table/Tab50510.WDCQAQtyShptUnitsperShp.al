table 50510 "WDC-QA Qty. Shpt.Units per Shp"
{
    CaptionML = ENU = 'Qty. Shipment Units per Shipment Container', FRA = 'Qté d''unités d''expédition par support logistique';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Shipment Unit"; Code[10])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Unit"));
        }
        field(2; "Shipment Container"; Code[10])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Container"));
        }
        field(3; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
    }
    keys
    {
        key(PK; "Shipment Unit", "Shipment Container")
        {
            Clustered = true;
        }
    }
}
