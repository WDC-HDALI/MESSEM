codeunit 50000 "WDC Subscriber Sales"
{

    [EventSubscriber(ObjectType::Table, database::"sales Line", 'OnAfterAssignFieldsForNo', '', FALSE, FALSE)]
    local procedure OnAfterAssignFieldsForNosales(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")

    var
        Item: Record 27;
    begin

        if Item.get(SalesLine."No.") then
            SalesLine."Packaging Item" := IsPackagingItem();
        IF NOT SalesLine."Packaging Item" THEN BEGIN
            SalesLine."Shipment Unit" := Item."Shipment Unit";
            SalesLine."Shipment Container" := Item."Shipment Container";
            if item."Shipm.Units per Shipm.Containr" <> 0 then
                SalesLine."Qty Shipm.Units per Shipm.Cont" := item."Shipm.Units per Shipm.Containr"
            else
                SalesLine."Qty Shipm.Units per Shipm.Cont" := 1
        END ELSE BEGIN
            SalesLine."Shipment Unit" := '';
            SalesLine."Shipment Container" := '';
        END;
        IF SalesLine."Shipment Unit" <> '' THEN
            SalesLine."Qty. per Shipment Unit" := Item."Qty. per Shipment Unit" / SalesLine."Qty. per Unit of Measure"
        ELSE
            SalesLine."Qty. per Shipment Unit" := 1;
        IF SalesLine."Shipment Container" <> '' THEN
            SalesLine."Qty. per Shipment Container" := Item."Qty. per Shipment Container" / SalesLine."Qty. per Unit of Measure"
        ELSE
            SalesLine."Qty. per Shipment Container" := 1;

    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnValidateQuantityOnAfterCalcBaseQty', '', FALSE, FALSE)]
    local procedure OnValidateQuantityOnAfterCalcBaseQtysale(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line")
    begin
        IF SalesLine."Shipment Unit" <> '' THEN
            SalesLine."Quantity Shipment Units" := ROUND(SalesLine.Quantity / SalesLine."Qty. per Shipment Unit", 1, '>');
        IF SalesLine."Shipment Container" <> '' THEN begin
            SalesLine."Quantity Shipment Containers" := ROUND(SalesLine.Quantity / SalesLine."Qty. per Shipment Container", 1, '>');
            IF SalesLine."Qty. per Shipment Container" <> 0 THEN
                SalesLine."Qty. Shpt. Cont. Calc." := SalesLine.Quantity / SalesLine."Qty. per Shipment Container";
        end;
        if Not (SalesLine."Outstanding Quantity" = 0) then begin
            SalesLine."Qty. to Ship Shipment Units" := SalesLine."Quantity Shipment Units" -
            (SalesLine."Qty. Shipped Shipment Units" + SalesLine."Reserv Qty. to Post Ship.Unit");
            SalesLine."Qty. to Ship Shipm. Containers" := SalesLine."Quantity Shipment Containers" -
              (SalesLine."Qty. Shipped Shipm. Containers" + SalesLine."Reserv Qty. to Post Ship.Cont.");
        end;
        IF SalesLine."Document Type" IN [SalesLine."Document Type"::"Return Order", SalesLine."Document Type"::"Credit Memo"] THEN begin
            SalesLine."Qty. S.Units to invoice" := SalesLine."Return Qty. Received S.Units" + SalesLine."Return Qty. to Receive S.Units" - SalesLine."Qty. S.Units Invoiced";
            SalesLine."Qty. S.Cont. to invoice" := SalesLine."Return Qty. Received S.Cont." + SalesLine."Return Qty. to Receive S.Cont." - SalesLine."Qty. S.Cont. Invoiced";
        end
        ELSE begin
            SalesLine."Qty. S.Units to invoice" := SalesLine."Qty. Shipped Shipment Units" + SalesLine."Qty. to Ship Shipment Units" - SalesLine."Qty. S.Units Invoiced";
            SalesLine."Qty. S.Cont. to invoice" := SalesLine."Qty. Shipped Shipm. Containers" + SalesLine."Qty. to Ship Shipm. Containers" - SalesLine."Qty. S.Cont. Invoiced";
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnAfterUpdateWithWarehouseShip', '', FALSE, FALSE)]
    local procedure OnAfterUpdateWithWarehouseShip(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        Location: Record "Location";
        item: Record item;
    begin
        if Item.get(SalesLine."No.") then
            SalesLine."Packaging Item" := IsPackagingItem();
        IF (SalesLine.Type = SalesLine.Type::Item) THEN
            CASE TRUE OF
                (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity >= 0):
                    IF (Location.RequireShipment(SalesLine."Location Code")) AND NOT SalesLine."Packaging Item" THEN BEGIN
                        SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", 0);
                        SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", 0);
                    END ELSE BEGIN
                        IF NOT (SalesLine."Outstanding Quantity" = 0) THEN BEGIN
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", SalesLine."Quantity Shipment Units" -
                              (SalesLine."Qty. Shipped Shipment Units" + SalesLine."Reserv Qty. to Post Ship.Unit"));
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", SalesLine."Quantity Shipment Containers" -
                              (SalesLine."Qty. Shipped Shipm. Containers" + SalesLine."Reserv Qty. to Post Ship.Cont."));
                        END ELSE BEGIN
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", 0);
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", 0);
                        END;
                    END;
                (SalesLine."Document Type" IN [SalesLine."Document Type"::Quote, SalesLine."Document Type"::Order]) AND (SalesLine.Quantity < 0):
                    IF Location.RequireReceive(SalesLine."Location Code") THEN BEGIN
                        SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", 0);
                        SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", 0);
                    END ELSE BEGIN
                        IF NOT (SalesLine."Outstanding Quantity" = 0) THEN BEGIN
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", SalesLine."Quantity Shipment Units" -
                              (SalesLine."Qty. Shipped Shipment Units" + SalesLine."Reserv Qty. to Post Ship.Unit"));
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", SalesLine."Quantity Shipment Containers" -
                              (SalesLine."Qty. Shipped Shipm. Containers" + SalesLine."Reserv Qty. to Post Ship.Cont."));
                        END ELSE BEGIN
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipment Units", 0);
                            SalesLine.VALIDATE(SalesLine."Qty. to Ship Shipm. Containers", 0);
                        END;
                    END;
                (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity >= 0):
                    IF (Location.RequireReceive(SalesLine."Location Code")) AND NOT (SalesLine."Packaging Item") THEN BEGIN
                        SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", 0);
                        SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", 0);
                    END ELSE BEGIN
                        IF NOT (SalesLine."Outstanding Quantity" = 0) then begin
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", SalesLine."Quantity Shipment Units" -
                              (SalesLine."Return Qty. Received S.Units" + SalesLine."Reserv Qty. to Post Ship.Unit"));
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", SalesLine."Quantity Shipment Containers" -
                              (SalesLine."Return Qty. Received S.Cont." + SalesLine."Reserv Qty. to Post Ship.Cont."));
                        END ELSE BEGIN
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", 0);
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", 0);
                        END;
                    END;
                (SalesLine."Document Type" = SalesLine."Document Type"::"Return Order") AND (SalesLine.Quantity < 0):
                    IF (Location.RequireShipment(SalesLine."Location Code")) AND NOT (SalesLine."Packaging Item") THEN BEGIN
                        SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", 0);
                        SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", 0);
                    END ELSE BEGIN
                        IF NOT (SalesLine."Outstanding Quantity" = 0) then begin
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", SalesLine."Quantity Shipment Units" -
                              (SalesLine."Return Qty. Received S.Units" + SalesLine."Reserv Qty. to Post Ship.Unit"));
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", SalesLine."Quantity Shipment Containers" -
                              (SalesLine."Return Qty. Received S.Cont." + SalesLine."Reserv Qty. to Post Ship.Cont."));
                        END ELSE BEGIN
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Units", 0);
                            SalesLine.VALIDATE(SalesLine."Return Qty. to Receive S.Cont.", 0);
                        END;
                    END;
            END;
        //
    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnAfterInitQtyToInvoice', '', FALSE, FALSE)]
    local procedure OnAfterInitQtyToInvoice(var SalesLine: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        SalesLine."Qty. S.Units to invoice" := MaxShipUnitsToInvoice(SalesLine);
        SalesLine."Qty. S.Cont. to invoice" := MaxShipContToInvoice(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnBeforeUpdateQtyToAsmFromSalesLineQtyToShip', '', FALSE, FALSE)]
    local procedure OnBeforeUpdateQtyToAsmFromSalesLineQtyToShip(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        CalcPackagingQuantityToShip(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnBeforeCheckApplFromItemLedgEntry', '', FALSE, FALSE)]
    local procedure OnBeforeCheckApplFromItemLedgEntry(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)
    begin
        CalcPackagingQuantityToShip(SalesLine);
    end;

    [EventSubscriber(ObjectType::Table, database::"sales line", 'OnValidateQtyToReturnAfterInitQty', '', FALSE, FALSE)]
    local procedure OnValidateQtyToReturnAfterInitQty(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        CalcPackagingQuantityToShip(SalesLine)
    end;

    procedure IsPackagingItem(): Boolean
    var
        Packaging: Record "WDC Packaging";
        item: Record 27;
    begin
        Packaging.RESET;
        Packaging.SETCURRENTKEY("Item No.");
        Packaging.SETFILTER("Item No.", item."No.");
        EXIT(NOT Packaging.ISEMPTY);
    end;

    procedure MaxShipUnitsToInvoice(psalesline: Record "Sales Line"): Decimal
    begin

        IF psalesline."Document Type" IN [psalesline."Document Type"::"Return Order", psalesline."Document Type"::"Credit Memo"] THEN
            EXIT(psalesline."Return Qty. Received S.Units" + psalesline."Return Qty. to Receive S.Units" - psalesline."Qty. S.Units Invoiced")
        ELSE
            EXIT(psalesline."Qty. Shipped Shipment Units" + psalesline."Qty. to Ship Shipment Units" - psalesline."Qty. S.Units Invoiced");

    end;

    procedure MaxShipContToInvoice(psalesline: Record "Sales Line"): Decimal
    begin
        IF psalesline."Document Type" IN [psalesline."Document Type"::"Return Order", psalesline."Document Type"::"Credit Memo"] THEN
            EXIT(psalesline."Return Qty. Received S.Cont." + psalesline."Return Qty. to Receive S.Cont." - psalesline."Qty. S.Cont. Invoiced")
        ELSE
            EXIT(psalesline."Qty. Shipped Shipm. Containers" + psalesline."Qty. to Ship Shipm. Containers" - psalesline."Qty. S.Cont. Invoiced");
    end;

    procedure CalcPackagingQuantityToShip(psalesline: Record "Sales Line")
    begin
        IF (psalesline."Shipment Unit" <> '') THEN BEGIN
            IF psalesline."Document Type" IN [psalesline."Document Type"::"Return Order", psalesline."Document Type"::"Credit Memo"] THEN BEGIN
                // IF (CurrFieldNo <> FIELDNO( psalesline."Return Qty. to Receive")) AND
                //    (NOT OverruleCalcPackagingCheck) THEN
                //IF (NOT OverruleCalcPackagingCheck) THEN 
                //EXIT;
                psalesline."Return Qty. to Receive S.Units" := round(psalesline."Return Qty. to Receive" / psalesline."Qty. per Shipment Unit", 1, '>') -
                                                    psalesline."Reserv Qty. to Post Ship.Unit";

                IF (psalesline."Return Qty. to Receive S.Units" * psalesline."Quantity Shipment Units" < 0) OR
                  (ABS(psalesline."Return Qty. to Receive S.Units") > ABS(psalesline."Quantity Shipment Units" - psalesline."Return Qty. Received S.Units")) OR
                  (psalesline."Quantity Shipment Units" * (psalesline."Quantity Shipment Units" - psalesline."Return Qty. Received S.Units") < 0)
                THEN
                    psalesline."Return Qty. to Receive S.Units" := psalesline."Quantity Shipment Units" -
                      (psalesline."Return Qty. Received S.Units" + psalesline."Reserv Qty. to Post Ship.Unit");
            END ELSE BEGIN
                // IF (CurrFieldNo <> FIELDNO( psalesline."Qty. to Ship")) AND
                //    (NOT OverruleCalcPackagingCheck) THEN
                // IF (NOT OverruleCalcPackagingCheck) THEN 
                //   EXIT;
                psalesline."Qty. to Ship Shipment Units" := round(psalesline."Qty. to Ship" / psalesline."Qty. per Shipment Unit", 1, '>') -
                                                 psalesline."Reserv Qty. to Post Ship.Unit";
                IF (psalesline."Qty. to Ship Shipment Units" * psalesline."Quantity Shipment Units" < 0) OR
                  (ABS(psalesline."Qty. to Ship Shipment Units") > ABS(psalesline."Quantity Shipment Units" - psalesline."Qty. Shipped Shipment Units")) OR
                  (psalesline."Quantity Shipment Units" * (psalesline."Quantity Shipment Units" - psalesline."Qty. Shipped Shipment Units") < 0)
                THEN
                    psalesline."Qty. to Ship Shipment Units" := psalesline."Quantity Shipment Units" -
                      (psalesline."Qty. Shipped Shipment Units" + psalesline."Reserv Qty. to Post Ship.Unit");
            END;
        END;

        IF (psalesline."Shipment Container" <> '') THEN BEGIN
            IF psalesline."Document Type" IN [psalesline."Document Type"::"Return Order", psalesline."Document Type"::"Credit Memo"] THEN BEGIN
                // IF (CurrFieldNo <> FIELDNO(psalesline."Return Qty. to Receive")) AND
                //    (NOT OverruleCalcPackagingCheck) THEN
                // IF (NOT OverruleCalcPackagingCheck) THEN 
                //   EXIT;
                psalesline."Return Qty. to Receive S.Cont." := round(psalesline."Return Qty. to Receive" / psalesline."Qty. per Shipment Container", 1, '>') -
                                                    psalesline."Reserv Qty. to Post Ship.Cont.";

                IF (psalesline."Return Qty. to Receive S.Cont." * psalesline."Quantity Shipment Containers" < 0) OR
                  (ABS(psalesline."Return Qty. to Receive S.Cont.") > ABS(psalesline."Quantity Shipment Containers" - psalesline."Return Qty. Received S.Cont.")) OR
                  (psalesline."Quantity Shipment Containers" * (psalesline."Quantity Shipment Containers" - psalesline."Return Qty. Received S.Cont.") < 0)
                THEN
                    psalesline."Return Qty. to Receive S.Cont." := psalesline."Quantity Shipment Containers" -
                      (psalesline."Return Qty. Received S.Cont." + psalesline."Reserv Qty. to Post Ship.Cont.");
            END ELSE BEGIN
                // IF (CurrFieldNo <> FIELDNO( psalesline."Qty. to Ship")) AND
                //    (NOT OverruleCalcPackagingCheck) THEN
                // IF (NOT OverruleCalcPackagingCheck) THEN 
                //   EXIT;
                psalesline."Qty. to Ship Shipm. Containers" := Round(psalesline."Qty. to Ship" / psalesline."Qty. per Shipment Container", 1, '>') -
                                                    psalesline."Reserv Qty. to Post Ship.Cont.";
                IF (psalesline."Qty. to Ship Shipm. Containers" * psalesline."Quantity Shipment Containers" < 0) OR
                  (ABS(psalesline."Qty. to Ship Shipm. Containers") > ABS(psalesline."Quantity Shipment Containers" - psalesline."Qty. Shipped Shipm. Containers")) OR
                  (psalesline."Quantity Shipment Containers" * (psalesline."Quantity Shipment Containers" - psalesline."Qty. Shipped Shipm. Containers") < 0)
                THEN
                    psalesline."Qty. to Ship Shipm. Containers" := psalesline."Quantity Shipment Containers" -
                      (psalesline."Qty. Shipped Shipm. Containers" + psalesline."Reserv Qty. to Post Ship.Cont.");
            END;
        END;

    end;



}
