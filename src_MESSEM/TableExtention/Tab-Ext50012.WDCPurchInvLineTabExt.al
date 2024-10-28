tableextension 50012 "WDC Purch. Inv. Line TabExt" extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            Caption = 'Shipment Unit';
            DataClassification = ToBeClassified;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            Caption = 'Shipment Container';
            DataClassification = ToBeClassified;
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
