tableextension 50010 "WDC Sales Shipment Line " extends "Sales Shipment Line"
{
    fields
    {
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Unit', FRA = 'Qté par unité d''expédition';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Container', FRA = 'Qté par support logistique';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50009; "Quantity Shipment Containers"; Decimal)
        {
            CaptionML = ENU = 'Qté de support logistique', FRA = 'Quantity Shipment Containers';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50008; "Quantity Shipment Units"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50010; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
            DataClassification = ToBeClassified;

        }

    }
}
