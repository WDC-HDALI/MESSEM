tableextension 50015 "WDC Purch. Rcpt. Line TabExt" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Unit"));

        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Container"));


        }
        field(50008; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
            DataClassification = ToBeClassified;

        }
        field(50009; "Quantity Shipment Units"; Decimal)
        {
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;
        }
        field(50010; "Quantity Shipment Containers"; Decimal)
        {
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;
        }
    }

}
