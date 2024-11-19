tableextension 50004 "WDC Item Journal Line " extends "Item Journal Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Unit"));
            Editable = false;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Container"));
        }
        field(50004; "Qty Shipm.Units per Shipm.Cont"; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipment Units per Shipment Container', FRA = 'Qté d''unités d''expédition par support logistique';
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(50005; "Quantity Shipment Units"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;
            trigger OnValidate()
            begin
                IF ("Entry Type" IN ["Entry Type"::Output, "Entry Type"::Consumption]) THEN
                    IF ("Quantity Shipment Containers" <> 0) THEN
                        TESTFIELD("Shipment Unit");
                IF ("Entry Type" = "Entry Type"::Output) THEN
                    IF ("Quantity Shipment Units" <> 0) AND ("Quantity Shipment Containers" <> 0) THEN
                        "Qty Shipm.Units per Shipm.Cont" := round("Quantity Shipment Units" / "Quantity Shipment Containers", 1, '>');

            end;

        }
        field(50006; "Quantity Shipment Containers"; Decimal)
        {
            BlankZero = true;
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;
            trigger OnValidate()
            begin
                IF ("Entry Type" IN ["Entry Type"::Output, "Entry Type"::Consumption]) THEN
                    IF ("Quantity Shipment Units" <> 0) THEN
                        TESTFIELD("Shipment Container");
                IF ("Entry Type" = "Entry Type"::Output) THEN
                    IF ("Quantity Shipment Units" <> 0) AND ("Quantity Shipment Containers" <> 0) THEN
                        "Qty Shipm.Units per Shipm.Cont" := "Quantity Shipment Units" / "Quantity Shipment Containers";

            end;

        }
        field(50007; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
        }
        field(50008; "Balance Reg. Customer/Vend.No."; code[20])
        {
            CaptionML = ENU = 'Balance Registration Customer/Vendor No.', FRA = 'N° client/fournisseur enregistrement solde';
            DataClassification = ToBeClassified;
        }
        field(50009; "Balance Registration Direction"; Enum "WDC Bal. Regist. Direc")
        {
            CaptionML = ENU = 'Balance Registration Direction', FRA = 'Sens enregistrement solde';
            DataClassification = ToBeClassified;

        }
        field(50010; "Rebate Accrual Amount (LCY)"; Decimal)
        {
            CaptionML = ENU = 'Rebate Accrual Amount (LCY)', FRA = 'Montant ajustement bonus DS';
            DataClassification = ToBeClassified;
        }
        field(50011; "Source Subtype"; Enum "WDC Lot Attribute Src Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
        }
        field(50012; PFD; Code[20])
        {
            CaptionML = ENU = 'PFD', FRA = 'PFD';
            DataClassification = ToBeClassified;
        }
        field(50013; Variety; Code[20])
        {
            CaptionML = ENU = 'Variety', FRA = 'Variété';
            DataClassification = ToBeClassified;
        }
        field(50014; Brix; Code[20])
        {
            CaptionML = ENU = 'Brix', FRA = 'Brix';
            DataClassification = ToBeClassified;
        }
        field(50015; "Package Number"; Integer)
        {
            CaptionML = ENU = 'Package Number', FRA = 'Nombre Palette';
            DataClassification = ToBeClassified;
        }
        field(50016; Place; Code[20])
        {
            CaptionML = ENU = 'Place', FRA = 'Localisation';
            DataClassification = ToBeClassified;

        }


        modify("Source No.")
        {
            trigger OnAfterValidate()
            begin
                GetBalanceRegistration();
            end;

        }

    }
    procedure GetBalanceRegistration(): Code[20]
    var
        Packaging: Record "WDC Packaging";
        CustomerVendorPackaging: Record "WDC Customer/Vendor Packaging";
    begin
        IF ("Source No." = '') OR
           ("Item No." = '')
        THEN
            EXIT;

        Packaging.SETCURRENTKEY("Item No.");
        Packaging.SETRANGE("Item No.", "Item No.");
        IF NOT Packaging.FINDFIRST THEN
            EXIT;

        CASE "Source Type" OF
            "Source Type"::Customer:
                IF NOT CustomerVendorPackaging.GET(DATABASE::Customer, "Source No.", Packaging.Code) THEN BEGIN
                    CustomerVendorPackaging.INIT;
                    CustomerVendorPackaging."Source Type" := DATABASE::Customer;
                    CustomerVendorPackaging."Source No." := "Source No.";
                    CustomerVendorPackaging."Register Balance" := TRUE;
                    CustomerVendorPackaging.VALIDATE(Code, Packaging.Code);
                    CustomerVendorPackaging.INSERT(TRUE);
                END;
            "Source Type"::Vendor:
                IF NOT CustomerVendorPackaging.GET(DATABASE::Vendor, "Source No.", Packaging.Code) THEN BEGIN
                    CustomerVendorPackaging.INIT;
                    CustomerVendorPackaging."Source Type" := DATABASE::Vendor;
                    CustomerVendorPackaging."Source No." := "Source No.";
                    CustomerVendorPackaging."Register Balance" := TRUE;
                    CustomerVendorPackaging.VALIDATE(Code, Packaging.Code);
                    CustomerVendorPackaging.INSERT(TRUE);
                END;
            ELSE
                EXIT;
        END;

        IF NOT CustomerVendorPackaging."Register Balance" THEN
            EXIT;
        IF NOT CustomerVendorPackaging."Balance Reg. Shipping Agent" THEN BEGIN
            GetBalanceRegDirection();
            "Balance Reg. Customer/Vend.No." := "Source No.";
        END;
    end;

    procedure GetBalanceRegDirection(): Integer
    begin
        CASE "Entry Type" OF
            "Entry Type"::Sale:
                IF (Quantity > 0) THEN
                    "Balance Registration Direction" := "Balance Registration Direction"::Outbound
                ELSE
                    "Balance Registration Direction" := "Balance Registration Direction"::Inbound;
            "Entry Type"::Purchase:
                IF (Quantity > 0) THEN
                    "Balance Registration Direction" := "Balance Registration Direction"::Inbound
                ELSE
                    "Balance Registration Direction" := "Balance Registration Direction"::Outbound;
            "Entry Type"::"Positive Adjmt.":
                CASE "Source Type" OF
                    "Source Type"::Customer:
                        "Balance Registration Direction" := "Balance Registration Direction"::Inbound;
                    "Source Type"::Vendor:
                        "Balance Registration Direction" := "Balance Registration Direction"::Inbound;
                END;
            "Entry Type"::"Negative Adjmt.":
                CASE "Source Type" OF
                    "Source Type"::Customer:
                        "Balance Registration Direction" := "Balance Registration Direction"::Outbound;
                    "Source Type"::Vendor:
                        "Balance Registration Direction" := "Balance Registration Direction"::Outbound;
                END;
        END;
    end;









}
