namespace MessemMA.MessemMA;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Journal;

codeunit 50505 "WDC-QACreate ItemTrackingLines"
{
    procedure InsertResEntrySalesLine(SalesLine: Record "Sales Line"; SerialNo: Code[20]; LotNo: Code[20]; QtyToHandleBase: Decimal; ExpirationDate: Date; WarrantyDate: Date; VendorLotNo: Code[20])
    var
        SalesLineReserve: Codeunit "Sales Line-Reserve";
    begin
        AvailDate := SalesLine."Shipment Date";

        InitTempTrackingSpecification(SalesLine."Shipment Unit", SalesLine."Qty. per Shipment Unit", SalesLine."Shipment Container", SalesLine."Qty. per Shipment Container", SalesLine."Net Weight", '');
        TrackingSpecification.SetTempTrackingSpecification(TempTrackingSpecification);
        //TrackingSpecification.InitFromSalesLine(SalesLine);
        SalesLineReserve.InitFromSalesLine(TrackingSpecification, SalesLine);
        InsertReservationEntry(SerialNo, LotNo, '', QtyToHandleBase, ExpirationDate, WarrantyDate, VendorLotNo);
    end;

    procedure InitTempTrackingSpecification(ShipmentUnit: Code[20]; QtyperShipmentUnit: Decimal; ShipmentContainer: Code[20]; QtyperShipmentContainer: Decimal; NetWeight: Decimal; ZoneCode: Code[20])
    begin
        TempTrackingSpecification.INIT;
        // TempTrackingSpecification."Shipment Unit" := ShipmentUnit;
        // TempTrackingSpecification."Qty. per Shipment Unit" := QtyperShipmentUnit;
        // TempTrackingSpecification."Shipment Container" := ShipmentContainer;
        // TempTrackingSpecification."Qty. per Shipment Container" := QtyperShipmentContainer;
        // TempTrackingSpecification."Net Weight" := NetWeight;
        // TempTrackingSpecification."Zone Code" := ZoneCode;
    end;

    local procedure InsertReservationEntry(SerialNo: Code[20]; LotNo: Code[20]; ContainerNo: Code[20]; QtyToHandleBase: Decimal; ExpirationDate: Date; WarrantyDate: Date; VendorLotNo: Code[20])
    var
        ReservEntry: Record "Reservation Entry";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemTrackingForm: Page "Item Tracking Lines";
        LotNoInformation: Record "Lot No. Information";
        //ItemTrackingCU: Codeunit Item tracking Lines (NAS);
        TmpKgQuantity: Decimal;
    begin
        TrackingSpecification."Serial No." := SerialNo;
        TrackingSpecification."Lot No." := LotNo;
        //TrackingSpecification."Container No." := ContainerNo;
        TrackingSpecification."Quantity Handled (Base)" := 0;
        TrackingSpecification."Quantity Invoiced (Base)" := 0;
        //TmpKgQuantity := TrackingSpecification."Kg-Quantity to Handle";
        TrackingSpecification.VALIDATE("Quantity (Base)", QtyToHandleBase);
        Item.GET(TrackingSpecification."Item No.");
        // IF Item."Catch Weight Item" THEN BEGIN
        //     IF TrackingSpecification."Source Type" = DATABASE::"Item Journal Line" THEN BEGIN
        //         ItemJournalTemplate.GET(TrackingSpecification."Source ID");
        //         IF (ItemJournalTemplate.Type = ItemJournalTemplate.Type::"Phys. Inventory") THEN BEGIN
        //             IF (TmpKgQuantity <> 0) THEN
        //                 TrackingSpecification.VALIDATE("Kg-Quantity", TmpKgQuantity);
        //         END ELSE BEGIN
        //             IF QtyToHandleBase <> 0 THEN
        //                 TrackingSpecification.VALIDATE("Kg-Quantity to Handle", (QtyToHandleBase / TrackingSpecification."Qty. per Unit of Measure")
        //                 * TrackingSpecification."Net Weight")
        //         END;
        //     END ELSE BEGIN
        //         IF QtyToHandleBase <> 0 THEN
        //             TrackingSpecification.VALIDATE("Kg-Quantity to Handle", (QtyToHandleBase / TrackingSpecification."Qty. per Unit of Measure")
        //             * TrackingSpecification."Net Weight")
        //     END;

        // END ELSE
        //     TrackingSpecification.VALIDATE("Kg-Quantity to Handle", 0);
        // //

        TrackingSpecification."Expiration Date" := ExpirationDate;
        TrackingSpecification."Warranty Date" := WarrantyDate;
        //TrackingSpecification."Vendor Lot No." := VendorLotNo;
        IF (TrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
           (TrackingSpecification."Source Subtype" = 4) THEN BEGIN // Transfer
            IF NewLotNo <> '' THEN
                TrackingSpecification."New Lot No." := NewLotNo
            ELSE BEGIN
                TrackingSpecification."New Lot No." := LotNo;
                TrackingSpecification."New Expiration Date" := ExpirationDate;
            END;
            // IF NewContainerNo <> '' THEN
            //     TrackingSpecification."New Container No." := NewContainerNo
            // ELSE
            //     TrackingSpecification."New Container No." := ContainerNo;
            // IF LotNoInformation.GET(TrackingSpecification."Item No.", TrackingSpecification."Variant Code",
            //                         TrackingSpecification."Lot No.") THEN
            //     TrackingSpecification."New Inspection Status" := LotNoInformation."Inspection Status";
            // IF NewInspectionStatus <> '' THEN
            //     TrackingSpecification."New Inspection Status" := NewInspectionStatus;
            // IF NewExpirationDate <> 0D THEN
            //     TrackingSpecification."New Expiration Date" := NewExpirationDate;
        END;

        IF ApplToItemEntryNo <> 0 THEN
            TrackingSpecification."Appl.-to Item Entry" := ApplToItemEntryNo;
        IF ApplFromItemEntryNo <> 0 THEN
            TrackingSpecification."Appl.-from Item Entry" := ApplFromItemEntryNo;

        ReservEntry.TRANSFERFIELDS(TrackingSpecification);
        ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
        ReservEntry."Entry No." := NextReservEntryNo;
        ReservEntry.Positive := ReservEntry."Quantity (Base)" > 0;

        IF GUIALLOWED THEN BEGIN
            CLEAR(ItemTrackingForm);
            ItemTrackingForm.SetBlockCommit(TRUE);
            IF (TrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
               (TrackingSpecification."Source Subtype" = 4) THEN // Transfer
                ItemTrackingForm.SetFormRunMode(1); // Reclass
            ItemTrackingForm.SetSourceSpec(TrackingSpecification, AvailDate);
            ItemTrackingForm.TempItemTrackingDefFW(TrackingSpecification);
        END ELSE BEGIN
            //CLEAR(ItemTrackingCU);
            // ItemTrackingCU.SetBlockCommit(TRUE);
            // IF (TrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND
            //    (TrackingSpecification."Source Subtype" = 4) THEN // Transfer
            //     ItemTrackingCU.SetFormRunMode(1); // Reclass
            // ItemTrackingCU.SetSourceSpec(TrackingSpecification, AvailDate);
            // ItemTrackingCU.TempItemTrackingDef(TrackingSpecification);
        END;

    end;

    procedure InsertResEntryPurchLine(PurchLine: Record "Purchase Line"; SerialNo: Code[20]; LotNo: Code[20]; QtyToHandleBase: Decimal; ExpirationDate: Date; WarrantyDate: Date; VendorLotNo: Code[20])
    var
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
        AvailDate := PurchLine."Expected Receipt Date";

        InitTempTrackingSpecification(PurchLine."Shipment Unit", PurchLine."Qty. per Shipment Unit", PurchLine."Shipment Container", PurchLine."Qty. per Shipment Container", PurchLine."Net Weight", '');
        TrackingSpecification.SetTempTrackingSpecification(TempTrackingSpecification);
        //TrackingSpecification.InitFromPurchLine(PurchLine);
        PurchLineReserve.InitFromPurchLine(TrackingSpecification, PurchLine);

        InsertReservationEntry(SerialNo, LotNo, '', QtyToHandleBase, ExpirationDate, WarrantyDate, VendorLotNo);
    end;

    LOCAL procedure NextReservEntryNo(): Integer
    var
        ReservEntry: Record "Reservation Entry";
    begin
        IF ReservEntry.FINDLAST THEN
            EXIT(ReservEntry."Entry No." + 1)
        ELSE
            EXIT(1);
    end;

    var
        TrackingSpecification: Record "Tracking Specification";
        TempTrackingSpecification: Record "Tracking Specification";
        Item: Record Item;
        AvailDate: date;
        InternalTransfer: Boolean;
        NewContainerNo: Code[20];
        NewLotNo: Code[20];
        NewExpirationDate: date;
        NewInspectionStatus: Code[20];
        ApplToItemEntryNo: integer;
        ApplFromItemEntryNo: Integer;
}
