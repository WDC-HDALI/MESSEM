tableextension 50003 "WDC Sales Line" extends "Sales Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            TableRelation = "WDC Packaging" WHERE(Type = filter("Shipment Unit"));

            trigger OnValidate()
            var
                Packaging: Record "WDC Packaging";
                TmpPackaging: Code[20];
            begin
                // IF NOT ValidationFromWhseSuspended THEN
                //   TestStatusOpen;
                IF ("Shipment No." <> '') OR ("Return Receipt No." <> '') THEN
                    FIELDERROR("Shipment Unit", STRSUBSTNO(Text001, FIELDCAPTION("Shipment Unit")));
                IF (Type = Type::Item) AND
                   ("Document Type" = "Document Type"::"Return Order") THEN BEGIN
                    GetSalesHeader;
                    //   IF SalesHeader."Packaging Order" THEN BEGIN
                    //     TmpPackaging := "Shipment Unit";
                    IF Packaging.GET("Shipment Unit") THEN BEGIN
                        Packaging.TESTFIELD("Item No.");
                        VALIDATE("No.", Packaging."Item No.")
                    END ELSE
                        VALIDATE("No.", '');
                    // "Shipment Unit" := TmpPackaging;

                END;
                IF ("Shipment Unit" = '') AND (xRec."Shipment Unit" <> '') AND ("Quantity Shipment Units" <> 0) THEN
                    VALIDATE("Quantity Shipment Units", 0);

                // IF "Entsorgung %" <> 0 THEN
                //   UpdateUnitPrice(FIELDNO("Shipment Unit"));

            end;
        }
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Unit', FRA = 'Qté par support logistique';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = filter("Shipment Container"));
            trigger OnValidate()
            begin
                // IF NOT ValidationFromWhseSuspended THEN
                //   TestStatusOpen;
                IF ("Shipment No." <> '') OR ("Return Receipt No." <> '') THEN
                    FIELDERROR("Shipment Container", STRSUBSTNO(Text001, FIELDCAPTION("Shipment Container")));

                IF ("Shipment Container" = '') AND (xRec."Shipment Container" <> '') AND ("Quantity Shipment Containers" <> 0) THEN
                    VALIDATE("Quantity Shipment Containers", 0);
            end;
        }
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Container', FRA = 'Qté par support logistique';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(50004; "Qty Shipm.Units per Shipm.Cont"; Decimal)
        {
            CaptionML = ENU = 'Qty Shipm.Units per Shipm.Cont', FRA = 'Qté d''unités d''expédition par support logistique';
            DecimalPlaces = 0 : 0;
            Editable = false;
            InitValue = 1;
            MinValue = 0;

        }
        field(50008; "Quantity Shipment Units"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            CaptionML = ENU = 'Quantity Shipment Units', FRA = 'Nombre d''unités d''expédition';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin

                // IF NOT ValidationFromWhseSuspended THEN
                //   TestStatusOpen;
                //UpdateQtyShipmentContCalc;
                VALIDATE("Qty. Shpt. Cont. Calc.", Quantity / "Qty. per Shipment Container");


                IF ("Quantity Shipment Units" <> 0) THEN
                    TESTFIELD("Shipment Unit")
                ELSE
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        VALIDATE("Shipment Unit", '');
                IF (CurrFieldNo <> FIELDNO("Quantity Shipment Units")) AND
                   (CurrFieldNo <> 0) AND
                   (("Shipment No." <> '') OR ("Return Receipt No." <> '')) THEN
                    FIELDERROR("Quantity Shipment Units", STRSUBSTNO(Text001, FIELDCAPTION("Quantity Shipment Units")));
                IF "Quantity Shipment Units" <> 0 THEN begin
                    IF ("Quantity Shipment Units" <> 0) AND (Quantity <> 0) THEN
                        "Qty. per Shipment Unit" := Quantity / "Quantity Shipment Units"
                    ELSE
                        "Qty. per Shipment Unit" := 1;
                END;
                IF ("Quantity Shipment Units" * "Qty. Shipped Shipment Units" < 0) OR
                   ((ABS("Quantity Shipment Units") < ABS("Qty. Shipped Shipment Units")))
                THEN
                    FIELDERROR("Quantity Shipment Units", STRSUBSTNO(Text002, FIELDCAPTION("Qty. Shipped Shipment Units")));
                IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
                    "Return Qty. to Receive S.Units" := "Quantity Shipment Units" -
                      ("Return Qty. Received S.Units" + "Reserv Qty. to Post Ship.Unit")
                ELSE begin
                    "Qty. to Ship Shipment Units" := "Quantity Shipment Units" -
                      ("Qty. Shipped Shipment Units" + "Reserv Qty. to Post Ship.Unit");
                    "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;
                end;
            end;

        }

        field(50009; "Quantity Shipment Containers"; Decimal)
        {
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DataClassification = ToBeClassified;
            BlankZero = true;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            var
            //AllCustSalesCostTypeL: Record "11018427";//verif
            begin
                IF "Quantity Shipment Containers" <> 0 THEN
                    TESTFIELD("Shipment Container")
                ELSE
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        VALIDATE("Shipment Container", '');
                IF (CurrFieldNo <> FIELDNO("Quantity Shipment Units")) AND
                   (CurrFieldNo <> 0) AND
                   (("Shipment No." <> '') OR ("Return Receipt No." <> '')) THEN
                    FIELDERROR("Quantity Shipment Containers", STRSUBSTNO(Text001, FIELDCAPTION("Quantity Shipment Containers")));

                IF "Quantity Shipment Containers" <> 0 THEN
                    IF ("Quantity Shipment Containers" <> 0) AND (Quantity <> 0) THEN
                        "Qty. per Shipment Container" := Quantity / "Quantity Shipment Containers"
                    ELSE
                        "Qty. per Shipment Container" := 1;

                IF ("Quantity Shipment Containers" * "Qty. Shipped Shipm. Containers" < 0) OR
                   ((ABS("Quantity Shipment Containers") < ABS("Qty. Shipped Shipm. Containers")))
                THEN
                    FIELDERROR("Quantity Shipment Containers", STRSUBSTNO(Text003, FIELDCAPTION("Qty. Shipped Shipm. Containers")));

                IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
                    "Return Qty. to Receive S.Cont." := "Quantity Shipment Containers" -
                      ("Return Qty. Received S.Cont." + "Reserv Qty. to Post Ship.Cont.")
                ELSE
                    "Qty. to Ship Shipm. Containers" := "Quantity Shipment Containers" -
                      ("Qty. Shipped Shipm. Containers" + "Reserv Qty. to Post Ship.Cont.");
                "Qty. S.Cont. to invoice" := MaxShipContToInvoice;

            end;
        }
        field(50010; "Packaging Item"; Boolean)
        {
            CaptionML = ENU = 'Packaging Item', FRA = 'Article d''emballage';
            DataClassification = ToBeClassified;
        }

        field(50011; "Qty. to Ship Shipment Units"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            CaptionML = ENU = 'Qty. to Ship Shipment Units', FRA = 'Qté unités d''expédition à expédier';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                IF CurrFieldNo <> FIELDNO("Qty. to Ship Shipment Units") THEN
                    EXIT;

                IF ("Qty. to Ship Shipment Units" * "Quantity Shipment Units" < 0) OR
                   (ABS("Qty. to Ship Shipment Units") > ABS("Quantity Shipment Units" - "Qty. Shipped Shipment Units")) OR
                   ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Qty. Shipped Shipment Units") < 0)
                THEN
                    ERROR(
                      text005,
                      "Quantity Shipment Units" - "Qty. Shipped Shipment Units");

                "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;
            end;

        }
        field(50012; "Qty. Shpt. Cont. Calc."; Decimal)
        {
            CaptionML = ENU = 'Qty. Shpt. Cont. Calc.', FRA = 'Qté support logistique à expédier (calculé)';
            DataClassification = ToBeClassified;
            Editable = false;
            BlankZero = true;
            DecimalPlaces = 5;

        }
        field(50013; "Qty. Shipped Shipment Units"; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipped Shipment Units', FRA = 'Qté unités d''expédition expédiées';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;

        }
        field(50014; "Reserv Qty. to Post Ship.Unit"; Decimal)
        {
            CaptionML = ENU = 'Reserv Qty. to Post Ship.Unit', FRA = 'Qté réservée d''unités d''expédition à valider';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

        }
        field(50015; "Qty. Shipped Shipm. Containers"; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipped Shipm. Containers', FRA = 'Qté de support logistique expédiée';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;

        }
        field(50016; "Reserv Qty. to Post Ship.Cont."; Decimal)
        {
            CaptionML = ENU = 'Reserv Qty. to Post Ship.Cont.', FRA = 'Qté réservée de support logistique à valider';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

        }
        field(50017; "Qty. to Ship Shipm. Containers"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            CaptionML = ENU = 'Qty. to Ship Shipm. Containers', FRA = 'Qté de support logistique à expédier';
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                IF CurrFieldNo <> FIELDNO("Qty. to Ship Shipm. Containers") THEN
                    EXIT;

                IF ("Qty. to Ship Shipm. Containers" * "Quantity Shipment Containers" < 0) OR
                   (ABS("Qty. to Ship Shipm. Containers") > ABS("Quantity Shipment Containers" - "Qty. Shipped Shipm. Containers")) OR
                   ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Qty. Shipped Shipm. Containers") < 0)
                THEN
                    ERROR(
                      Text005,
                      "Quantity Shipment Containers" - "Qty. Shipped Shipm. Containers");

                "Qty. S.Cont. to invoice" := MaxShipContToInvoice;
            end;
        }
        field(50018; "Qty. S.Units to invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Units to invoice', FRA = 'Qté unités d''expédition à facturer';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
            BlankZero = true;

        }
        field(50019; "Qty. S.Cont. to invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Cont. to invoice', FRA = 'Qté support logistique à facturer';
            DataClassification = ToBeClassified;
        }
        field(50020; "Return Qty. to Receive S.Units"; Decimal)
        {
            CaptionML = ENU = 'Return Qty. to Receive S.Units', FRA = 'Qté retour unités d''expédition à recevoir';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

        }
        field(50021; "Return Qty. Received S.Cont."; Decimal)
        {
            CaptionML = ENU = 'Return Qty. Received S.Cont.', FRA = 'Qté retour support logistique reçus';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;

        }
        field(50022; "Return Qty. Received S.Units"; Decimal)
        {
            CaptionML = ENU = 'Return Qty. Received S.Units', FRA = 'Qté retour unités d''expédition reçues';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50023; "Qty. S.Units Invoiced"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Units Invoiced', FRA = 'Qté unités d''expédition facturée';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50024; "Qty. S.Cont. Invoiced"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Cont. Invoiced', FRA = 'Qté support logistique facturée';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;
            Editable = false;
        }

        field(50025; "Return Qty. to Receive S.Cont."; Decimal)
        {
            CaptionML = ENU = 'Return Qty. to Receive S.Cont.', FRA = 'Qté retour support logistique à recevoir';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 0;

        }
        field(50026; "Qty. Shipped Shpt. Cont. Calc."; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipped Shpt. Cont. Calc.', FRA = 'Qté support logistique expédiée (calculé)';
            DataClassification = ToBeClassified;
            BlankZero = true;
            Editable = false;
            DecimalPlaces = 5;

        }

        field(50027; "Packaging Return"; Boolean)
        {
            CaptionML = ENU = 'Packaging Return', FRA = 'Retour d''emballage';
            DataClassification = ToBeClassified;

        }
        field(50030; "Harmonised Tariff Code"; Code[20])
        {
            Captionml = ENU = 'Harmonised Tariff Code', FRA = 'Nombre de points';
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                InventoryPostingGroup: record "Inventory Posting Group";
                item: record item;
            begin
                if "Location Code" = '' then
                    "Location Code" := InventoryPostingGroup."Location Code";
                if ("Bin Code" = '') and ("Location Code" <> '') then
                    if item.get("No.") then
                        if InventoryPostingGroup.get(item."Inventory Posting Group") then
                            if InventoryPostingGroup."Location Code" = "Location Code" then
                                "Bin Code" := InventoryPostingGroup."Bin Code";
            end;

        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                InventoryPostingGroup: record "Inventory Posting Group";
                item: record item;
            begin
                if (rec."Location Code" <> xRec."Location Code") and (rec."Location Code" <> '') then
                    if "Bin Code" = '' then
                        if item.get("No.") then
                            if InventoryPostingGroup.get(item."Inventory Posting Group") then
                                if InventoryPostingGroup."Location Code" = "Location Code" then
                                    "Bin Code" := InventoryPostingGroup."Bin Code";
            end;

        }

    }

    procedure MaxShipUnitsToInvoice(): Decimal
    begin
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
            EXIT("Return Qty. Received S.Units" + "Return Qty. to Receive S.Units" - "Qty. S.Units Invoiced")
        ELSE
            EXIT("Qty. Shipped Shipment Units" + "Qty. to Ship Shipment Units" - "Qty. S.Units Invoiced");
    end;

    procedure MaxShipContToInvoice(): Decimal
    begin
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
            EXIT("Return Qty. Received S.Cont." + "Return Qty. to Receive S.Cont." - "Qty. S.Cont. Invoiced")
        ELSE
            EXIT("Qty. Shipped Shipm. Containers" + "Qty. to Ship Shipm. Containers" - "Qty. S.Cont. Invoiced");
    end;

    procedure GetBalanceRegCustomerNo(): Code[20]
    var
        Packaging: Record "WDC Packaging";
        CustomerVendorPackaging: Record "WDC Customer/Vendor Packaging";
        ShippingAgent: Record "Shipping Agent";
    begin
        IF Type <> Type::Item THEN
            EXIT;

        GetSalesHeader;
        IF NOT (("Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"]) OR
                (SalesHeader.Ship AND ("Document Type" = "Document Type"::Invoice)) OR
                (SalesHeader.Receive AND ("Document Type" = "Document Type"::"Credit Memo"))) THEN
            EXIT;

        Packaging.SETCURRENTKEY("Item No.");
        Packaging.SETRANGE("Item No.", "No.");
        IF NOT Packaging.FINDFIRST THEN
            EXIT;

        IF NOT CustomerVendorPackaging.GET(DATABASE::Customer, "Sell-to Customer No.", Packaging.Code) THEN
            EXIT;

        IF NOT CustomerVendorPackaging."Register Balance" THEN
            EXIT;

        IF NOT CustomerVendorPackaging."Balance Reg. Shipping Agent" THEN
            EXIT("Sell-to Customer No.");

        SalesHeader.TESTFIELD("Shipping Agent Code");
        ShippingAgent.GET(SalesHeader."Shipping Agent Code");
        ShippingAgent.TESTFIELD("Customer No.");

        EXIT(ShippingAgent."Customer No.");
    end;

    procedure GetSalesHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document Type" <> SalesHeader."Document Type") OR ("Document No." <> SalesHeader."No.") THEN BEGIN
            SalesHeader.GET("Document Type", "Document No.");
            IF SalesHeader."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                SalesHeader.TESTFIELD("Currency Factor");
                Currency.GET(SalesHeader."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
        END;
    end;

    procedure CalcPackagingQuantityToShip()
    begin
        IF ("Shipment Unit" <> '') THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                IF (CurrFieldNo <> FIELDNO("Return Qty. to Receive")) THEN
                    EXIT;
                "Return Qty. to Receive S.Units" := ROUND("Return Qty. to Receive" / "Qty. per Shipment Unit", 1, '>') -
                                                    "Reserv Qty. to Post Ship.Unit";

                IF ("Return Qty. to Receive S.Units" * "Quantity Shipment Units" < 0) OR
                  (ABS("Return Qty. to Receive S.Units") > ABS("Quantity Shipment Units" - "Return Qty. Received S.Units")) OR
                  ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Return Qty. Received S.Units") < 0)
                THEN
                    "Return Qty. to Receive S.Units" := "Quantity Shipment Units" -
                      ("Return Qty. Received S.Units" + "Reserv Qty. to Post Ship.Unit");
            END ELSE BEGIN
                IF (CurrFieldNo <> FIELDNO("Qty. to Ship")) THEN
                    EXIT;
                "Qty. to Ship Shipment Units" := ROUND("Qty. to Ship" / "Qty. per Shipment Unit", 1, '>') -
                                                 "Reserv Qty. to Post Ship.Unit";
                IF ("Qty. to Ship Shipment Units" * "Quantity Shipment Units" < 0) OR
                  (ABS("Qty. to Ship Shipment Units") > ABS("Quantity Shipment Units" - "Qty. Shipped Shipment Units")) OR
                  ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Qty. Shipped Shipment Units") < 0)
                THEN
                    "Qty. to Ship Shipment Units" := "Quantity Shipment Units" -
                      ("Qty. Shipped Shipment Units" + "Reserv Qty. to Post Ship.Unit");
            END;
        END;

        IF ("Shipment Container" <> '') THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                IF (CurrFieldNo <> FIELDNO("Return Qty. to Receive")) THEN
                    EXIT;
                "Return Qty. to Receive S.Cont." := ROUND("Return Qty. to Receive" / "Qty. per Shipment Container", 1, '>') -
                                                    "Reserv Qty. to Post Ship.Cont.";

                IF ("Return Qty. to Receive S.Cont." * "Quantity Shipment Containers" < 0) OR
                  (ABS("Return Qty. to Receive S.Cont.") > ABS("Quantity Shipment Containers" - "Return Qty. Received S.Cont.")) OR
                  ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Return Qty. Received S.Cont.") < 0)
                THEN
                    "Return Qty. to Receive S.Cont." := "Quantity Shipment Containers" -
                      ("Return Qty. Received S.Cont." + "Reserv Qty. to Post Ship.Cont.");
            END ELSE BEGIN
                IF (CurrFieldNo <> FIELDNO("Qty. to Ship")) THEN
                    EXIT;
                "Qty. to Ship Shipm. Containers" := ROUND("Qty. to Ship" / "Qty. per Shipment Container", 1, '>') -
                                                    "Reserv Qty. to Post Ship.Cont.";
                IF ("Qty. to Ship Shipm. Containers" * "Quantity Shipment Containers" < 0) OR
                  (ABS("Qty. to Ship Shipm. Containers") > ABS("Quantity Shipment Containers" - "Qty. Shipped Shipm. Containers")) OR
                  ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Qty. Shipped Shipm. Containers") < 0)
                THEN
                    "Qty. to Ship Shipm. Containers" := "Quantity Shipment Containers" -
                      ("Qty. Shipped Shipm. Containers" + "Reserv Qty. to Post Ship.Cont.");
            END;
        END;
    end;




    var
        SalesHeader: record "Sales Header";
        Currency: record Currency;
        Text001: TextConst ENU = 'Field %1 cannot be changed when the line has been shipped.', FRA = 'Champ %1 ne peut pas être modifié quand la ligne a été expédiée.';
        Text002: TextConst ENU = 'must not be less than %1', FRA = 'ne doit pas être inférieur(e) à %1';
        text003: TextConst ENU = 'Sales Cost for category %1 are linked to this %2.', FRA = 'Coût de vente catégorie %1 est lié à %2.';
        text004: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Change %1 de %2 à %3?';
        text005: TextConst ENU = 'You cannot ship more than %1 units.', FRA = 'Vous ne pouvez pas expédier plus de %1 unité(s).';
}
