tableextension 50015 "WDC Purch. Rcpt. Line " extends "Purch. Rcpt. Line"
//************Documentation**********************************************
//WDC02  WDC.HG  24/06/2026  add "Item Amt. Rcd. Not Invoiced" field
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
        //<<WDC01
        field(50030; "Item Amt. Rcd. Not Invoiced"; Decimal)
        {
            CaptionML = ENU = 'Item Amt. Rcd. Not Invoiced', FRA = 'Montant article reçu/non facturé';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //>>WDC01

    }

}
