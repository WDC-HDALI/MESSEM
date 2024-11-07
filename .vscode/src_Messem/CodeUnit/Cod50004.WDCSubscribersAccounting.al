namespace MESSEM.MESSEM;
using Microsoft.Inventory.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Utilities;
using Microsoft.Purchases.Posting;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Inventory.Journal;

codeunit 50004 "WDC Subscribers Accounting"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post line", 'OnAfterInsertGLEntry', '', FALSE, FALSE)]
    local procedure OnAfterInsertGLEntry(GenJnlLine: Record "Gen. Journal Line"; CalcAddCurrResiduals: Boolean)

    begin
        InsertRebateEntry(GenJnlLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Batch", 'OnBeforePostGenJnlLine', '', FALSE, FALSE)]
    local procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; CommitIsSuppressed: Boolean; var Posted: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var PostingGenJournalLine: Record "Gen. Journal Line")
    var
    begin
        GenJournalLine.GenJnlRebateSet := (GenJournalLine."Rebate Code" <> '');
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', FALSE, FALSE)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    var

    begin
        ItemJnlLine."Rebate Accrual Amount (LCY)" := PurchLine."Accrual Amount (LCY)";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnAfterInitPurchLineFields', '', FALSE, FALSE)]
    local procedure OnAfterInitPurchLineFields(var PurchaseLine: Record "Purchase Line")
    var
    begin
        PurchaseLine."Accrual Amount (LCY)" := 0;
    end;

    // PROCEDURE SetGenJnlRebate(GenJnlRebateSet2: Boolean);
    // BEGIN
    //     GenJnlRebateSet := GenJnlRebateSet2;
    // END;



    // PROCEDURE SetPurchaseRebate(PurchaseRebateSet2: Boolean; PurchaseRebate2: Record "WDC Purchase Rebate"; PurchaseLine2: Record 39);
    // BEGIN
    //     PurchaseRebateSet := PurchaseRebateSet2;
    //     PurchaseRebate := PurchaseRebate2;
    //     PurchaseLine := PurchaseLine2;
    // END;



    // PROCEDURE SetPurchasePayment(PurchaseRebateSet2: Boolean; GenJnlLine2: Record 81; PurchaseLine2: Record 39);
    // BEGIN
    //     PurchaseRebateSet := PurchaseRebateSet2;
    //     PurchaseLine := PurchaseLine2;
    // END;

    procedure InsertRebateEntry(var GenJnlLine: Record 81)
    var
        RebateEntry: Record "WDC Rebate Entry";
        RebateEntry2: Record "WDC Rebate Entry";
        Currency: Record 4;
        ItemUOM: Record 5404;
        Item: Record 27;
        RebateDifference: Decimal;
        RemRebateDifference: Decimal;
        NewEntryNo: Integer;
        SumBaseQuantity: Decimal;
        SumBaseAmount: Decimal;
        SumAccrualAmountLCY: Decimal;
        CurrencyExchangeRates: Record 330;
        TotalValidEntries: Integer;
        EntryCounter: Integer;
    begin
        IF NOT (GenJnlLine.PurchaseRebateSet OR GenJnlLine.GenJnlRebateSet) THEN
            EXIT;

        IF RebateEntry.FINDLAST THEN
            NewEntryNo := RebateEntry."Entry No." + 1
        ELSE
            NewEntryNo := 1;

        // Accrual
        RebateEntry.INIT;
        RebateEntry."Entry No." := NewEntryNo;
        RebateEntry."Posting Date" := GenJnlLine."Posting Date";
        RebateEntry."Document No." := GenJnlLine."Document No.";
        RebateEntry."Document Type" := GenJnlLine."Document Type";
        RebateEntry."Sell-to/Buy-from No." := GenJnlLine."Sell-to/Buy-from No.";
        RebateEntry."Bill-to/Pay-to No." := GenJnlLine."Bill-to/Pay-to No.";
        RebateEntry."External Document No." := GenJnlLine."External Document No.";
        // Accrual
        IF GenJnlLine.PurchaseRebateSet AND
           (GenJnlLine."Rebate Document Type" = GenJnlLine."Rebate Document Type"::Accrual)
        THEN BEGIN

            GenJnlLine.PurchaseRebateSet := FALSE;

            RebateEntry."Rebate Document Type" := RebateEntry."Rebate Document Type"::Accrual;
            RebateEntry."Accrual Amount (LCY)" := GenJnlLine.Amount;

            RebateEntry."Posting Type" := RebateEntry."Posting Type"::Purchase;
            RebateEntry."Currency Code" := PurchaseLine."Currency Code";

            Item.GET(PurchaseLine."No.");

            IF PurchaseLine."Unit of Measure Code" <> PurchaseRebate."Unit of Measure Code" THEN BEGIN
                IF PurchaseRebate."Unit of Measure Code" <> '' THEN BEGIN
                    ItemUOM.GET(PurchaseLine."No.", PurchaseRebate."Unit of Measure Code");
                    RebateEntry."Base Quantity" := PurchaseLine."Qty. to Invoice (Base)" / ItemUOM."Qty. per Unit of Measure";
                END ELSE
                    RebateEntry."Base Quantity" := PurchaseLine."Qty. to Invoice (Base)";
            END ELSE
                RebateEntry."Base Quantity" := PurchaseLine."Qty. to Invoice";


            IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::"Credit Memo" THEN BEGIN
                RebateEntry."Base Amount" := -PurchaseLine."VAT Base Amount";
                RebateEntry."Base Quantity" := -RebateEntry."Base Quantity";
            END ELSE
                RebateEntry."Base Amount" := PurchaseLine."VAT Base Amount";

            RebateEntry."Unit of Measure Code" := PurchaseLine."Unit of Measure Code";

            RebateEntry."Rebate Code" := PurchaseRebate."Rebate Code";
            RebateEntry."Item Type" := PurchaseRebate.Type;
            RebateEntry."Item Code" := PurchaseRebate.Code;
            RebateEntry."Rebate Unit of Measure Code" := PurchaseRebate."Unit of Measure Code";
            RebateEntry."Vendor No." := PurchaseRebate."Vendor No.";
            RebateEntry."Rebate Method" := PurchaseRebate."Rebate Method";
            RebateEntry."Accrual Value (LCY)" := PurchaseRebate."Accrual Value (LCY)";
            RebateEntry."Starting Date" := PurchaseRebate."Starting Date";
            RebateEntry."Ending Date" := PurchaseRebate."Ending Date";
            RebateEntry.Open := TRUE;
            RebateEntry."Document Line No." := PurchaseLine."Line No.";

        END;

        // Payment
        IF GenJnlLine.PurchaseRebateSet THEN BEGIN
            RebateEntry."Rebate Code" := PurchaseLine."Rebate Code";
            RebateEntry."Currency Code" := PurchaseLine."Currency Code";
            RebateEntry."Posting Type" := RebateEntry."Posting Type"::Purchase;

        END;

        RebateEntry."Rebate Document Type" := RebateEntry."Rebate Document Type"::Payment;
        RebateEntry."Closed by Entry No." := RebateEntry."Entry No.";

        IF RebateEntry."Currency Code" <> '' THEN BEGIN
            Currency.GET(RebateEntry."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
            RebateEntry."Rebate Amount (LCY)" := ROUND(
              CurrencyExchangeRates.ExchangeAmtFCYToLCY(RebateEntry."Posting Date",
                RebateEntry."Currency Code", GenJnlLine.Amount,
                CurrencyExchangeRates.ExchangeRate(RebateEntry."Posting Date", RebateEntry."Currency Code")),
              Currency."Amount Rounding Precision");
        END ELSE
            RebateEntry."Rebate Amount (LCY)" := GenJnlLine.Amount;

        IF GenJnlLine.PurchaseRebateSet THEN BEGIN
            RebateEntry."Rebate Amount (LCY)" := -RebateEntry."Rebate Amount (LCY)";
            GenJnlLine.PurchaseRebateSet := FALSE;
        END;

        RebateEntry2.SETRANGE("Sell-to/Buy-from No.", GenJnlLine."Sell-to/Buy-from No.");
        RebateEntry2.SETRANGE("Rebate Code", RebateEntry."Rebate Code");
        RebateEntry2.SETRANGE("Rebate Document Type", RebateEntry2."Rebate Document Type"::Accrual);
        RebateEntry2.SETRANGE(Open, TRUE);
        IF RebateEntry2.FINDSET THEN BEGIN
            RebateEntry."Rebate Method" := RebateEntry2."Rebate Method";
            RebateEntry."Rebate Unit of Measure Code" := RebateEntry2."Rebate Unit of Measure Code";
            REPEAT
                SumBaseQuantity += RebateEntry2."Base Quantity";
                SumBaseAmount += RebateEntry2."Base Amount";
                SumAccrualAmountLCY += RebateEntry2."Accrual Amount (LCY)";
                TotalValidEntries := TotalValidEntries + 1;
            UNTIL RebateEntry2.NEXT <= 0;
        END;

        RebateDifference := -(SumAccrualAmountLCY + RebateEntry."Rebate Amount (LCY)");
        RemRebateDifference := RebateDifference;

        Currency.InitRoundingPrecision;

        IF RebateEntry2.FINDSET THEN
            REPEAT
                EntryCounter := EntryCounter + 1;
                IF TotalValidEntries = EntryCounter THEN
                    RebateEntry2."Rebate Difference (LCY)" := RemRebateDifference
                ELSE
                    RebateEntry2."Rebate Difference (LCY)" :=
                      ROUND(RebateDifference * RebateEntry2."Accrual Amount (LCY)" / SumAccrualAmountLCY, Currency."Amount Rounding Precision");

                RemRebateDifference := RemRebateDifference - RebateEntry2."Rebate Difference (LCY)";

                RebateEntry2."Rebate Amount (LCY)" := RebateEntry2."Accrual Amount (LCY)" + RebateEntry2."Rebate Difference (LCY)";
                RebateEntry2."Closed by Entry No." := RebateEntry."Entry No.";
                RebateEntry2.Open := FALSE;
                RebateEntry2.MODIFY;
            UNTIL RebateEntry2.NEXT <= 0;

        RebateEntry."Base Quantity" := -SumBaseQuantity;
        RebateEntry."Base Amount" := -SumBaseAmount;

        // Correction
        IF GenJnlLine.GenJnlRebateSet AND
          (GenJnlLine."Rebate Document Type" = GenJnlLine."Rebate Document Type"::Correction)
        THEN BEGIN
            GenJnlLine.GenJnlRebateSet := FALSE;

            RebateEntry."Rebate Document Type" := RebateEntry."Rebate Document Type"::Correction;
            RebateEntry."Rebate Code" := GenJnlLine."Rebate Code";
            RebateEntry."Correction Amount (LCY)" := GenJnlLine."Rebate Correction Amount (LCY)";
            RebateEntry."Correction Posted by Entry No." := RebateEntry."Entry No.";

            RebateEntry2.SETRANGE("Sell-to/Buy-from No.", RebateEntry."Sell-to/Buy-from No.");
            RebateEntry2.SETRANGE("Rebate Code", RebateEntry."Rebate Code");
            RebateEntry2.SETRANGE("Rebate Document Type", RebateEntry2."Rebate Document Type"::Accrual);
            IF NOT GenJnlLine."Include Open Rebate Entries" THEN
                RebateEntry2.SETRANGE(Open, FALSE);
            RebateEntry2.SETFILTER("Ending Date", '<%1', WORKDATE());
            IF RebateEntry2.FINDSET THEN BEGIN
                RebateEntry."Rebate Method" := RebateEntry2."Rebate Method";
                RebateEntry."Posting Type" := RebateEntry2."Posting Type";
                REPEAT
                    IF (RebateEntry2."Rebate Amount (LCY)" - RebateEntry2."Accrual Amount (LCY)") <> 0 THEN BEGIN
                        RebateEntry2."Correction Amount (LCY)" := -(RebateEntry2."Rebate Amount (LCY)" - RebateEntry2."Accrual Amount (LCY)");
                        RebateEntry2."Rebate Difference (LCY)" := 0;
                        RebateEntry2."Correction Posted by Entry No." := RebateEntry."Entry No.";
                        RebateEntry2."Correction Posted" := TRUE;
                        RebateEntry2.Open := FALSE;
                        RebateEntry2.MODIFY;
                    END;
                UNTIL RebateEntry2.NEXT <= 0;
            END;

        END;

        RebateEntry.INSERT;

    end;

    var

        PurchaseRebate: Record "WDC Purchase Rebate";
        PurchaseLine: Record 39;





}
