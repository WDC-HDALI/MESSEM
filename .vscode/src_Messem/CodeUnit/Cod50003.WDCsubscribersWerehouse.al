namespace MESSEM.MESSEM;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Ledger;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Journal;

codeunit 50003 "WDC subscribers Werehouse"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnBeforePostLineByEntryType', '', FALSE, FALSE)]
    local procedure OnBeforePostLineByEntryType(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean)
    var
        LotAttributeManagement: Codeunit "WDC Lot Attribute Mngmt";
    begin
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." THEN
            LotAttributeManagement.DeleteDocumentAttributesForItemJournalLine(ItemJournalLine);
    end;


    /////////Bonus*************************

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnBeforeSetDocumentLineNo', '', FALSE, FALSE)]
    local procedure OnInitValueEntryOnBeforeSetDocumentLineNo(ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry"; var ValueEntry: Record "Value Entry")
    var
    begin
        ValueEntry."Source Subtype" := ItemJournalLine."Source Subtype";
        CASE ValueEntry."Item Ledger Entry Type" OF
            ValueEntry."Item Ledger Entry Type"::Purchase:
                IF ValueEntry."Source Subtype" = ValueEntry."Source Subtype"::"2" THEN
                    RebateSignFactor := 1
                ELSE
                    RebateSignFactor := -1;
        END;
        ValueEntry."Rebate Accrual Amount (LCY)" := RebateSignFactor * ItemJournalLine."Rebate Accrual Amount (LCY)";
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnInsertVarValueEntryOnAfterInitValueEntryFields', '', FALSE, FALSE)]
    local procedure OnInsertVarValueEntryOnAfterInitValueEntryFields(var ValueEntry: record "Value Entry")
    var
    begin
        ValueEntry."Rebate Accrual Amount (LCY)" := 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnAfterSetupTempSplitItemJnlLineSetQty', '', FALSE, FALSE)]
    local procedure OnAfterSetupTempSplitItemJnlLineSetQty(var TempSplitItemJnlLine: Record "Item Journal Line" temporary; ItemJournalLine: Record "Item Journal Line"; SignFactor: Integer; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        lGLSetup: record "General Ledger Setup";
    begin
        lGLSetup.get;
        if SignFactor < 1 then   //à vérifier FloatingFactor lors le test car il est remplacé par SignFactor 
            TempSplitItemJnlLine."Rebate Accrual Amount (LCY)" := ROUND(ItemJournalLine."Rebate Accrual Amount (LCY)" * SignFactor, lGLSetup."Amount Rounding Precision")

        else
            TempSplitItemJnlLine."Rebate Accrual Amount (LCY)" := ItemJournalLine."Rebate Accrual Amount (LCY)";
    end;

    var
        RebateSignFactor: Decimal;
}
