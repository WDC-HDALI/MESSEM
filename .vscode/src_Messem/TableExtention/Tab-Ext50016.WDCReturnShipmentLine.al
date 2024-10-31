tableextension 50016 "WDCReturn Shipment Line" extends "Return Shipment Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Unit"));

        }
        field(50001; "Quantity Shipment Units"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;
        }
        field(50002; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
            DataClassification = ToBeClassified;

        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Container"));


        }
        field(50004; "Quantity Shipment Containers"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;
        }


    }
}
