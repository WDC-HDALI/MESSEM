tableextension 50001 "WDC PurchaseLine " extends "Purchase Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Unit"));

        }
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Unit', FRA = 'Qté par unité d''expédition';
            DataClassification = ToBeClassified;
            InitValue = 1;
            Editable = false;
        }
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Container', FRA = 'Qté par support logistique';
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = 1;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Packaging" WHERE(Type = CONST("Shipment Container"));
            trigger
            OnValidate()
            begin
                IF ("Shipment Container" = '') AND (xRec."Shipment Container" <> '') AND ("Quantity Shipment Containers" <> 0) THEN
                    VALIDATE("Quantity Shipment Containers", 0);

            end;
        }
        field(50004; "Qty Shipm.Units per Shipm.Cont"; Decimal)
        {
            CaptionML = ENU = 'Qty. Shipment Units per Shipment Container', FRA = 'Qté d''unités d''expédition par support logistique';
            DecimalPlaces = 0 : 0;
            InitValue = 1;
            trigger
            OnValidate()
            begin
                IF "Qty Shipm.Units per Shipm.Cont" <= 0 THEN
                    FIELDERROR("Qty Shipm.Units per Shipm.Cont", Text002);
                IF "Shipment Unit" <> '' THEN
                    "Qty. per Shipment Container" := "Qty. per Shipment Unit" * "Qty Shipm.Units per Shipm.Cont"
                ELSE
                    "Qty. per Shipment Container" := "Qty Shipm.Units per Shipm.Cont" / "Qty. per Unit of Measure";
                IF ("Shipment Container" <> '') AND (Quantity <> 0) THEN BEGIN
                    "Quantity Shipment Containers" := ROUND(Quantity / "Qty. per Shipment Container", 1, '>');
                    UpdateQtyToReceiveContainers;
                END;

            end;
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
            trigger OnValidate()
            begin
                IF ("Quantity Shipment Units" <> 0) THEN
                    TESTFIELD("Shipment Unit")
                ELSE
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        VALIDATE("Shipment Unit", '');
                IF (CurrFieldNo = FIELDNO("Quantity Shipment Units")) AND
               (CurrFieldNo <> 0) AND (("Receipt No." <> '') OR ("Return Shipment No." <> '')) THEN
                    FIELDERROR("Quantity Shipment Units", STRSUBSTNO(Text001, FIELDCAPTION("Quantity Shipment Units")));


                IF ("Quantity Shipment Units" <> 0) AND (Quantity <> 0) THEN
                    "Qty. per Shipment Unit" := Quantity / "Quantity Shipment Units"
                ELSE
                    "Qty. per Shipment Unit" := 1;

                // IF ("Quantity Shipment Units" * "Qty. Received Shipment Units" < 0) OR
                //    ((ABS("Quantity Shipment Units") < ABS("Qty. Received Shipment Units")))
                // THEN
                //   FIELDERROR("Quantity Shipment Units",STRSUBSTNO(Text004,FIELDCAPTION("Qty. Received Shipment Units")));
                IF ("Shipment Container" <> '') AND ("Quantity Shipment Units" <> 0) THEN begin
                    "Quantity Shipment Containers" := ROUND("Quantity Shipment Units" / "Qty Shipm.Units per Shipm.Cont", 1, '>');
                    "Qty. to Receive Shipment Units" := "Quantity Shipment Units";
                    "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;
                end;
                //>>a voir
                IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
                    "Return Qty. to Ship S.Units" := "Quantity Shipment Units" -
                      ("Return Qty. Shipped S.Units" + "Reserv Qty. to Post Ship.Unit")
                ELSE begin
                    "Qty. to Receive Shipment Units" := "Quantity Shipment Units";
                    "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;
                end;

            end;
        }
        field(50010; "Quantity Shipment Containers"; Decimal)
        {
            CaptionML = ENU = 'Quantity Shipment Containers', FRA = 'Qté de support logistique';
            DecimalPlaces = 0 : 0;
            trigger
            OnValidate()
            begin
                IF "Quantity Shipment Containers" <> 0 THEN
                    TESTFIELD("Shipment Container")
                ELSE
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        VALIDATE("Shipment Container", '');

                IF (CurrFieldNo = FIELDNO("Quantity Shipment Containers")) AND
                  (CurrFieldNo <> 0) AND
                  (("Receipt No." <> '') OR ("Return Shipment No." <> '')) THEN
                    FIELDERROR("Quantity Shipment Containers", STRSUBSTNO(Text001, FIELDCAPTION("Quantity Shipment Containers")));


                IF ("Quantity Shipment Containers" <> 0) AND (Quantity <> 0) THEN
                    "Qty. per Shipment Container" := Quantity / "Quantity Shipment Containers"
                ELSE
                    "Qty. per Shipment Container" := 1;

                IF ("Quantity Shipment Containers" * "Qty. Received Shipm.Containers" < 0) OR
                   ((ABS("Quantity Shipment Containers") < ABS("Qty. Received Shipm.Containers")))
                THEN
                    FIELDERROR("Quantity Shipment Containers", STRSUBSTNO(Text003, FIELDCAPTION("Qty. Received Shipm.Containers")));
                UpdateQtyToReceiveContainers();
            end;
        }
        field(50011; "Qty. to Receive Shipment Units"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Receive Shipment Units', FRA = 'Qté d''unités d''expédition à recevoir';
            DecimalPlaces = 0 : 0;
            trigger
            OnValidate()
            begin

                "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;

            end;
        }
        field(50012; "Qty. to Rec. Shipm. Containers"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Rec. Shipm. Containers', FRA = 'Qté de support logistique à recevoir';
            DecimalPlaces = 0 : 0;
            trigger
            OnValidate()
            begin
                "Qty. S.Cont. to invoice" := MaxShipContToInvoice;
            end;
        }
        field(50013; "Qty. S.Units to invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Units to invoice', FRA = 'Qté unités d''expédition à facturer';
            DecimalPlaces = 0 : 0;
        }
        field(50014; "Qty. S.Cont. to invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Cont. to invoice', FRA = 'Qté support logistique à facturer';
            DecimalPlaces = 0 : 0;
        }
        field(50015; "Qty. Received Shipment Units"; Decimal)
        {
            CaptionML = ENU = 'Qty. Received Shipment Units', FRA = 'Qté d''unités d''expédition reçue';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(50016; "Qty. Received Shipm.Containers"; Decimal)
        {
            CaptionML = ENU = 'Qty. Received Shipm.Containers', FRA = 'Qté de support logistique reçue';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50017; "Qty. Rec. Shpt. Cont. Calc"; Decimal)
        {
            CaptionML = ENU = 'Qty. Received Shpt. Cont. Calc.', FRA = 'Qté support logistique reçue calculée';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50018; "Return Qty. to Ship S.Cont."; Decimal)
        {
            CaptionML = ENU = 'Return Qty. to Ship S.Cont.', FRA = 'Qté retour support logistique à expédier';
            DecimalPlaces = 0 : 0;
            trigger
            OnValidate()
            begin
                IF ("Return Qty. to Ship S.Cont." * "Quantity Shipment Containers" < 0) OR
   (ABS("Return Qty. to Ship S.Cont.") > ABS("Quantity Shipment Containers" - "Return Qty. Shipped S.Cont.")) OR
   ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Return Qty. Shipped S.Cont.") < 0)
THEN
                    ERROR(
                      Text004,
                      "Quantity Shipment Containers" - "Return Qty. Shipped S.Cont.");
                "Qty. S.Cont. to invoice" := MaxShipContToInvoice;

            end;
        }
        field(50019; "Return Qty. to Ship S.Units"; Decimal)
        {
            CaptionML = ENU = 'Return Qty. to Ship S.Units', FRA = 'Qté retour unités d''expédition à expédier';
            DecimalPlaces = 0 : 0;
            trigger
            OnValidate()
            begin

                IF ("Return Qty. to Ship S.Units" * "Quantity Shipment Units" < 0) OR
   (ABS("Return Qty. to Ship S.Units") > ABS("Quantity Shipment Units" - "Return Qty. Shipped S.Units")) OR
   ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Return Qty. Shipped S.Units") < 0)
    THEN
                    ERROR(
                      Text004,
                      "Quantity Shipment Units" - "Return Qty. Shipped S.Units");
                "Qty. S.Units to invoice" := MaxShipUnitsToInvoice;
            end;
        }
        field(50020; "Reserv Qty. to Post Ship.Unit"; Decimal)
        {
            CaptionML = ENU = 'Reserved Qty. to Post Shipment Unit', FRA = 'Qté réservée d''unités d''expédition à valider';
            DecimalPlaces = 0 : 0;
        }
        field(50021; "Reserv Qty. to Post Ship.Cont."; Decimal)
        {
            CaptionML = ENU = 'Reserved Qty. to Post Shipment Containers', FRA = 'Qté réservée de support logistique à valider';
            DecimalPlaces = 0 : 0;
        }
        field(50022; "Packaging Return"; Boolean)
        {
            CaptionML = ENU = 'Packaging Return', FRA = 'Retour d''emballage';
        }
        field(50023; "Return Qty. Shipped S.Units"; Decimal)
        {
            CaptionML = ENU = 'Return Qty. Shipped Shipment Units', FRA = 'Qté retour unités d''expédition expédiées';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(50024; "Return Qty. Shipped S.Cont."; Decimal)
        {
            CaptionML = ENU = 'Return Qty. Shipped Shipment Containers', FRA = 'Qté retour support logistique expédiés';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(50025; "Qty. S.Units Invoiced"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Units Invoiced', FRA = 'Qté unités d''expédition facturée';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(50026; "Qty. S.Cont. Invoiced"; Decimal)
        {
            CaptionML = ENU = 'Qty. S.Cont. Invoiced', FRA = 'Qté support logistique facturée';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(50027; "Qty. Shpt. Cont. Calc."; Decimal)
        {
            CaptionML = ENU = 'Qty Shipm. Cont. (Calculated)', FRA = 'Qté support logistique à expédier (calculé)';
            Editable = false;
        }
        field(50028; "Rebate Code"; Code[20])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
            TableRelation = "WDC Rebate Code";
            DataClassification = ToBeClassified;
        }
        field(50029; "Accrual Amount (LCY)"; Decimal)
        {
            CaptionML = ENU = 'Accrual Amount (LCY)', FRA = 'Montant d''ajustement DS';
            DataClassification = ToBeClassified;
        }
        field(50030; "Scale Weight"; Decimal)
        {
            CaptionML = ENU = 'Scale Weight', FRA = 'Poids balance';
            DataClassification = ToBeClassified;
        }
        // modify("No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         InventoryPostingGroup: record "Inventory Posting Group";
        //         item: record item;
        //     begin
        //         if "Location Code" = '' then
        //             "Location Code" := InventoryPostingGroup."Location Code";
        //         if ("Bin Code" = '') and ("Location Code" <> '') then
        //             if item.get("No.") then
        //                 if InventoryPostingGroup.get(item."Inventory Posting Group") then
        //                     if InventoryPostingGroup."Location Code" = "Location Code" then
        //                         "Bin Code" := InventoryPostingGroup."Bin Code";
        //     end;

        // }
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
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                lUserSetup: Record "User Setup";
                err: TextConst ENU = 'You are not authorized to use this Account.', FRA = 'Vous n''êtes pas autorisé à utiliser ce compte comptable.';
            begin
                IF Type = Type::"G/L Account" THEN BEGIN
                    IF lUserSetup.GET(USERID) THEN BEGIN
                        IF lUserSetup."G/L Account 2/6" AND NOT lUserSetup."Check Accounting" THEN
                            IF (STRPOS("No.", '2') <> 1) AND (STRPOS("No.", '6') <> 1) THEN
                                ERROR(Err);
                    END;
                END;
            end;
        }
    }
    procedure MaxShipUnitsToInvoice(): Decimal
    begin
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
            EXIT("Return Qty. Shipped S.Units" + "Return Qty. to Ship S.Units" - "Qty. S.Units Invoiced")
        ELSE
            EXIT("Qty. Received Shipment Units" + "Qty. to Receive Shipment Units" - "Qty. S.Units Invoiced");
    end;

    procedure MaxShipContToInvoice(): Decimal
    begin
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
            EXIT("Return Qty. Shipped S.Cont." + "Return Qty. to Ship S.Cont." - "Qty. S.Cont. Invoiced")
        ELSE
            EXIT("Qty. Received Shipm.Containers" + "Qty. to Rec. Shipm. Containers" - "Qty. S.Cont. Invoiced");
    end;

    procedure GetBalanceRegVendorNo(): Code[20]
    var
        Packaging: Record "WDC Packaging";
        CustomerVendorPackaging: Record "WDC Customer/Vendor Packaging";
    begin
        IF Type <> Type::Item THEN
            EXIT;

        Packaging.SETCURRENTKEY("Item No.");
        Packaging.SETRANGE("Item No.", "No.");
        IF NOT Packaging.FINDFIRST THEN
            EXIT;

        IF NOT CustomerVendorPackaging.GET(DATABASE::Vendor, "Buy-from Vendor No.", Packaging.Code) THEN
            EXIT;

        IF NOT CustomerVendorPackaging."Register Balance" THEN
            EXIT;

        IF NOT CustomerVendorPackaging."Balance Reg. Shipping Agent" THEN
            EXIT("Buy-from Vendor No.");
    end;

    procedure UpdateQtyToReceiveContainers()
    begin
        IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN
            "Return Qty. to Ship S.Cont." := "Quantity Shipment Containers" -
              ("Return Qty. Shipped S.Cont." + "Reserv Qty. to Post Ship.Cont.")
        ELSE
            "Qty. to Rec. Shipm. Containers" := "Quantity Shipment Containers" -
              ("Qty. Received Shipm.Containers" + "Reserv Qty. to Post Ship.Cont.");
        "Qty. S.Cont. to invoice" := MaxShipContToInvoice();
    END;

    procedure CalcPackagingQuantityToReceive()
    begin
        IF ("Shipment Unit" <> '') THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                IF (CurrFieldNo <> FIELDNO("Return Qty. to Ship")) THEN
                    EXIT;
                "Return Qty. to Ship S.Units" := ROUND("Return Qty. to Ship" / "Qty. per Shipment Unit", 1, '>') -
                                                   "Reserv Qty. to Post Ship.Unit";
                IF ("Return Qty. to Ship S.Units" * "Quantity Shipment Units" < 0) OR
                  (ABS("Return Qty. to Ship S.Units") > ABS("Quantity Shipment Units" - "Return Qty. Shipped S.Units")) OR
                  ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Return Qty. Shipped S.Units") < 0)
                THEN
                    "Return Qty. to Ship S.Units" := "Quantity Shipment Units" -
                      ("Return Qty. Shipped S.Units" + "Reserv Qty. to Post Ship.Unit");
            END ELSE BEGIN
                IF (CurrFieldNo <> FIELDNO("Qty. to Receive")) THEN
                    EXIT;
                "Qty. to Receive Shipment Units" := ROUND("Qty. to Receive" / "Qty. per Shipment Unit", 1, '>') -
                                                      "Reserv Qty. to Post Ship.Unit";
                IF ("Qty. to Receive Shipment Units" * "Quantity Shipment Units" < 0) OR
                  (ABS("Qty. to Receive Shipment Units") > ABS("Quantity Shipment Units" - "Qty. Received Shipment Units")) OR
                  ("Quantity Shipment Units" * ("Quantity Shipment Units" - "Qty. Received Shipment Units") < 0)
                THEN
                    "Qty. to Receive Shipment Units" := "Quantity Shipment Units" - "Qty. Received Shipment Units";
            END;
        END;

        IF ("Shipment Container" <> '') THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"] THEN BEGIN
                IF (CurrFieldNo <> FIELDNO("Return Qty. to Ship")) THEN
                    EXIT;
                "Return Qty. to Ship S.Cont." := ROUND("Return Qty. to Ship" / "Qty. per Shipment Container", 1, '>') -
                                                   "Reserv Qty. to Post Ship.Cont.";
                IF ("Return Qty. to Ship S.Cont." * "Quantity Shipment Containers" < 0) OR
                  (ABS("Return Qty. to Ship S.Cont.") > ABS("Quantity Shipment Containers" - "Return Qty. Shipped S.Cont.")) OR
                  ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Return Qty. Shipped S.Cont.") < 0)
                THEN
                    "Return Qty. to Ship S.Cont." := "Quantity Shipment Containers" -
                      ("Return Qty. Shipped S.Cont." + "Reserv Qty. to Post Ship.Cont.");
            END ELSE BEGIN
                IF (CurrFieldNo <> FIELDNO("Qty. to Receive")) THEN
                    EXIT;
                "Qty. to Rec. Shipm. Containers" := ROUND("Qty. to Receive" / "Qty. per Shipment Container", 1, '>') -
                                                      "Reserv Qty. to Post Ship.Cont.";
                IF ("Qty. to Rec. Shipm. Containers" * "Quantity Shipment Containers" < 0) OR
                  (ABS("Qty. to Rec. Shipm. Containers") > ABS("Quantity Shipment Containers" - "Qty. Received Shipm.Containers")) OR
                  ("Quantity Shipment Containers" * ("Quantity Shipment Containers" - "Qty. Received Shipm.Containers") < 0)
                THEN
                    "Qty. to Rec. Shipm. Containers" := "Quantity Shipment Containers" -
                      ("Qty. Received Shipm.Containers" - "Reserv Qty. to Post Ship.Cont.");
            END;
        END;
    end;


    var
        Text001: TextConst ENU = 'Field %1 cannot be changed when the line has been received.', FRA = 'Champ %1 ne peut pas être modifié quand la ligne a été réceptionnée.';
        Text002: TextConst ENU = 'Must be greater than 0.', FRA = 'Doit être supérieur à 0.';
        Text003: TextConst ENU = 'must not be less than %1', FRA = 'ne doit pas être inférieur(e) à %1';
        Text004: TextConst ENU = 'You cannot return more than %1 units.', FRA = 'Vous ne pouvez pas retourner plus de %1 unité(s).';
}
