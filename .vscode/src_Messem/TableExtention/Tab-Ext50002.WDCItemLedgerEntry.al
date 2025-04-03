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
        field(50010; PFD; Code[20])
        {
            CaptionML = ENU = 'PFD', FRA = 'PFD';
            DataClassification = ToBeClassified;
        }
        field(50011; Variety; Code[20])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            DataClassification = ToBeClassified;
        }
        field(50012; Brix; Code[20])
        {
            CaptionML = ENU = 'Brix', FRA = 'Brix';
            DataClassification = ToBeClassified;
        }
        field(50013; "Package Number"; Integer)
        {
            CaptionML = ENU = 'Package Number', FRA = 'Nombre Palette';
            DataClassification = ToBeClassified;
        }
        field(50014; Place; Code[20])
        {
            CaptionML = ENU = 'Place', FRA = 'Localisation';
            DataClassification = ToBeClassified;

        }
        field(50015; "Rebate Accrual Amount (LCY)"; Decimal)
        {
            CaptionML = ENU = 'Rebate Accrual Amount (LCY)', FRA = 'Montant ajustement bonus DS';
            FieldClass = FlowField;
            CalcFormula = Sum("Value Entry"."Rebate Accrual Amount (LCY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Editable = false;
        }
        field(50016; "Purchase Order No."; Code[20])
        {
            CaptionML = ENU = 'Purchase Order No.', FRA = 'N° commande achat';
            DataClassification = ToBeClassified;

        }
        field(50017; "Source Subtype"; Enum "WDC Lot Attribute Src Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
        }
    }


}
