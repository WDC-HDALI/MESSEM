namespace Messem.Messem;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Ledger;
using Microsoft.Purchases.Document;

codeunit 50502 "WDC-QA subscribers Werehouse"
{
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    local procedure ItemTrackingLinesOnRegisterChangeOnAfterCreateReservEntry(var ReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification")
    begin
        ReservEntry."Buy-from Vendor No." := OldTrackingSpecification."Buy-from Vendor No.";
        ReservEntry.modify;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', FALSE, FALSE)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry."Buy-from Vendor No." := TrkgSpec."Buy-from Vendor No.";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', FALSE, FALSE)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    begin
        DestTrkgSpec."Buy-from Vendor No." := SourceTrackingSpec."Buy-from Vendor No.";
    end;

    [EventSubscriber(ObjectType::Table, DATABASE::"Tracking Specification", 'OnAfterValidateEvent', "Lot No.", FALSE, FALSE)]
    local procedure OnInsertRecordOnBeforeTempItemTrackLineInsert(var Rec: Record "Tracking Specification")
    begin
        Rec."Buy-from Vendor No." := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure ItemJnlPostLineOnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification"; var TempItemJournalLine: Record "Item Journal Line")
    begin
        TempItemJournalLine."Buy-from Vendor No." := TempTrackingSpecification."Buy-from Vendor No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure ItemJnlPostLineOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    var
        lLotInformation: Record "Lot No. Information";
    begin
        NewItemLedgEntry."Buy-from Vendor No." := ItemJournalLine."Buy-from Vendor No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnAfterCreateLotInformation', '', false, false)]
    local procedure OnAfterCreateLotInformation(var LotNoInfo: Record "Lot No. Information"; var TrackingSpecification: Record "Tracking Specification")
    var
        PurchaseOrder: Record "Purchase Header";
    begin
        LotNoInfo."Buy-from Vendor No." := TrackingSpecification."Buy-from Vendor No.";
        LotNoInfo.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforePostItemJnlLine', '', false, false)]
    local procedure GetCorrectionfields(var ItemJournalLine: Record "Item Journal Line")
    var
        OldItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemJournalLine."Buy-from Vendor No." := OldItemLedgerEntry."Buy-from Vendor No.";
    end;
}
