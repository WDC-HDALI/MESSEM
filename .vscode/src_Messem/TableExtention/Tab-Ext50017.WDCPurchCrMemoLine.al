tableextension 50017 "WDC PurchCrMemoLine" extends "Purch. Cr. Memo Line"
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
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;
        }
        field(50028; "Rebate Code"; Code[20])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
            TableRelation = "WDC Rebate Code";
        }
        field(50029; "Accrual Amount (LCY)"; Decimal)
        {
            CaptionML = ENU = 'Accrual Amount (LCY)', FRA = 'Montant d''ajustement DS';
            DataClassification = ToBeClassified;
        }


    }

}
