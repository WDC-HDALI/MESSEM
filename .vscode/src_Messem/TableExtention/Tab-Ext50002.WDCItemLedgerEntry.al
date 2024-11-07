tableextension 50002 "WDC Item Ledger Entry " extends "Item Ledger Entry"
{
    fields
    {
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
        field(50004; "Qty Shipm.Units per Shipm.Cont"; Decimal)
        {
            Caption = 'Shipm.Units per Shipm.Containr';
            DataClassification = ToBeClassified;
        }
        field(50005; "Quantity Shipment Units"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;
        }
        field(50006; "Quantity Shipment Containers"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;

        }


        field(50007; "Balance Reg. Customer/Vend.No."; code[20])
        {
            CaptionML = ENU = 'Balance Registration Customer/Vendor No.', FRA = 'N° client/fournisseur enregistrement solde';
            DataClassification = ToBeClassified;
        }
        field(50008; "Balance Registration Direction"; enum "WDC Bal. Regist. Direc")
        {
            CaptionML = ENU = 'Balance Registration Direction', FRA = 'Sens enregistrement solde';
            DataClassification = ToBeClassified;
        }
        field(50009; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
        }

    }


}
