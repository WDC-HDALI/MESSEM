namespace MESSEM.MESSEM;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Customer;
using Microsoft.Finance.Currency;
using System.Utilities;
using Microsoft.Finance.GeneralLedger.Preview;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Purchases.Payables;
using Microsoft.Sales.Receivables;
using Microsoft.Purchases.Vendor;

codeunit 50902 Bordereaux
{
    procedure PmtTolPaymentLine(var NewPaymentLine: Record "WDC-ED Payment Line"): Boolean

    begin
        MaxPmtTolAmount := 0;
        PmtDiscAmount := 0;
        AppliedAmount := 0;
        ApplyingAmount := 0;
        AmounttoApply := 0;
        PaymentLine := NewPaymentLine;

        GLSetup.Get();
        if PaymentLine."Applies-to Doc. No." = '' then
            if PaymentLine."Applies-to ID" <> '' then
                GenJnlLineApplID := PaymentLine."Applies-to ID";

        if (PaymentLine."Account Type" = PaymentLine."Account Type"::Customer) then begin
            NewCustLedgEntry."Posting Date" := PaymentLine."Posting Date";
            NewCustLedgEntry."Document No." := PaymentLine."Document No.";
            NewCustLedgEntry."Customer No." := PaymentLine."Account No.";
            NewCustLedgEntry."Currency Code" := PaymentLine."Currency Code";
            if PaymentLine."Applies-to Doc. No." <> '' then
                NewCustLedgEntry."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
            DelCustPmtTolAcc(NewCustLedgEntry, GenJnlLineApplID);
            NewCustLedgEntry.Amount := PaymentLine.Amount;
            NewCustLedgEntry."Remaining Amount" := PaymentLine.Amount;
            NewCustLedgEntry."Document Type" := PaymentLine."Applies-to Doc. Type"::Payment;
            CalcCustApplnAmount(
              NewCustLedgEntry, GLSetup, AppliedAmount, ApplyingAmount, AmounttoApply, PmtDiscAmount,
              MaxPmtTolAmount, GenJnlLineApplID, ApplnRoundingPrecision);
        end else begin
            NewVendLedgEntry."Posting Date" := PaymentLine."Posting Date";
            NewVendLedgEntry."Document No." := PaymentLine."Document No.";
            NewVendLedgEntry."Vendor No." := PaymentLine."Account No.";
            NewVendLedgEntry."Currency Code" := PaymentLine."Currency Code";
            if PaymentLine."Applies-to Doc. No." <> '' then
                NewVendLedgEntry."Applies-to Doc. No." := PaymentLine."Applies-to Doc. No.";
            DelVendPmtTolAcc(NewVendLedgEntry, GenJnlLineApplID);
            NewVendLedgEntry.Amount := PaymentLine.Amount;
            NewVendLedgEntry."Remaining Amount" := PaymentLine.Amount;
            NewVendLedgEntry."Document Type" := PaymentLine."Applies-to Doc. Type"::Payment;
            CalcVendApplnAmount(
              NewVendLedgEntry, GLSetup, AppliedAmount, ApplyingAmount, AmounttoApply, PmtDiscAmount,
              MaxPmtTolAmount, GenJnlLineApplID,
              ApplnRoundingPrecision);
        end;

        if GLSetup."Pmt. Disc. Tolerance Warning" then
            case PaymentLine."Account Type" of
                PaymentLine."Account Type"::Customer:
                    if not ManagePaymentDiscToleranceWarningCustomer(
                         NewCustLedgEntry, GenJnlLineApplID, AppliedAmount, AmounttoApply, PaymentLine."Applies-to Doc. No.")
                    then
                        exit(false);
                PaymentLine."Account Type"::Vendor:
                    if not ManagePaymentDiscToleranceWarningVendor(
                         NewVendLedgEntry, GenJnlLineApplID, AppliedAmount, AmounttoApply, PaymentLine."Applies-to Doc. No.")
                    then
                        exit(false);
            end;

        if Abs(AmounttoApply) >= Abs(AppliedAmount - PmtDiscAmount - MaxPmtTolAmount) then begin
            AppliedAmount := AppliedAmount - PmtDiscAmount;
            if Abs(AppliedAmount) > Abs(AmounttoApply) then
                AppliedAmount := AmounttoApply;

            if ((Abs(AppliedAmount + ApplyingAmount) - ApplnRoundingPrecision) <= Abs(MaxPmtTolAmount)) and
              (MaxPmtTolAmount <> 0) and ((Abs(AppliedAmount + ApplyingAmount) - ApplnRoundingPrecision) <> 0) and
              ((Abs(AppliedAmount + ApplyingAmount) > ApplnRoundingPrecision))
            then begin
                if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                    if GLSetup."Payment Tolerance Warning" then begin
                        if CallPmtTolWarning(
                             PaymentLine."Posting Date", PaymentLine."Account No.", PaymentLine."Document No.",
                             PaymentLine."Currency Code", ApplyingAmount, AppliedAmount, "Payment Tolerance Account Type"::Customer)
                        then begin
                            if (AppliedAmount <> 0) and (ApplyingAmount <> 0) then
                                PutCustPmtTolAmount(NewCustLedgEntry, ApplyingAmount, AppliedAmount, GenJnlLineApplID)
                            else
                                DelCustPmtTolAcc(NewCustLedgEntry, GenJnlLineApplID);
                        end else
                            exit(false);
                    end else
                        PutCustPmtTolAmount(NewCustLedgEntry, ApplyingAmount, AppliedAmount, GenJnlLineApplID);
                end else begin
                    if GLSetup."Payment Tolerance Warning" then begin
                        if CallPmtTolWarning(
                             PaymentLine."Posting Date", PaymentLine."Account No.", PaymentLine."Document No.",
                             PaymentLine."Currency Code", ApplyingAmount, AppliedAmount, "Payment Tolerance Account Type"::Vendor)
                        then begin
                            if (AppliedAmount <> 0) and (ApplyingAmount <> 0) then
                                PutVendPmtTolAmount(NewVendLedgEntry, ApplyingAmount, AppliedAmount, GenJnlLineApplID)
                            else
                                DelVendPmtTolAcc(NewVendLedgEntry, GenJnlLineApplID);
                        end else begin
                            DelVendPmtTolAcc(NewVendLedgEntry, GenJnlLineApplID);
                            exit(false);
                        end;
                    end else
                        PutVendPmtTolAmount(NewVendLedgEntry, ApplyingAmount, AppliedAmount, GenJnlLineApplID);
                end;
            end;

        end;
        exit(true);
    end;

    local procedure DelCustPmtTolAcc(CustledgEntry: Record "Cust. Ledger Entry"; CustEntryApplID: Code[50])
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if CustledgEntry."Applies-to Doc. No." <> '' then begin
            AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
            AppliedCustLedgEntry.SetRange("Customer No.", CustledgEntry."Customer No.");
            AppliedCustLedgEntry.SetRange(Open, true);
            AppliedCustLedgEntry.SetRange("Document No.", CustledgEntry."Applies-to Doc. No.");
            AppliedCustLedgEntry.LockTable();
            if AppliedCustLedgEntry.Find('-') then begin
                AppliedCustLedgEntry."Accepted Payment Tolerance" := 0;
                AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                AppliedCustLedgEntry.Modify();
                //if not SuppressCommit then
                Commit();
            end;
        end;

        if CustEntryApplID <> '' then begin
            AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
            AppliedCustLedgEntry.SetRange("Customer No.", CustledgEntry."Customer No.");
            AppliedCustLedgEntry.SetRange(Open, true);
            AppliedCustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);
            AppliedCustLedgEntry.LockTable();
            if AppliedCustLedgEntry.Find('-') then begin
                repeat
                    AppliedCustLedgEntry."Accepted Payment Tolerance" := 0;
                    AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                    AppliedCustLedgEntry.Modify();
                until AppliedCustLedgEntry.Next() = 0;
                //if not SuppressCommit then
                Commit();
            end;
        end;
    end;

    local procedure CalcCustApplnAmount(CustledgEntry: Record "Cust. Ledger Entry"; GLSetup: Record "General Ledger Setup"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal; var AmounttoApply: Decimal; var PmtDiscAmount: Decimal; var MaxPmtTolAmount: Decimal; CustEntryApplID: Code[50]; var ApplnRoundingPrecision: Decimal)
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        TempAppliedCustLedgerEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntry2: Record "Cust. Ledger Entry";
        ApplnCurrencyCode: Code[10];
        ApplnDate: Date;
        AmountRoundingPrecision: Decimal;
        TempAmount: Decimal;
        i: Integer;
        PositiveFilter: Boolean;
        SetPositiveFilter: Boolean;
        ApplnInMultiCurrency: Boolean;
        UseDisc: Boolean;
        RemainingPmtDiscPossible: Decimal;
        AvailableAmount: Decimal;
    begin
        ApplnCurrencyCode := CustledgEntry."Currency Code";
        ApplnDate := CustledgEntry."Posting Date";
        ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision";
        AmountRoundingPrecision := GLSetup."Amount Rounding Precision";

        if CustEntryApplID <> '' then begin
            AppliedCustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive);
            AppliedCustLedgEntry.SetRange("Customer No.", CustledgEntry."Customer No.");
            AppliedCustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);
            AppliedCustLedgEntry.SetRange(Open, true);
            CustLedgEntry2 := CustledgEntry;
            PositiveFilter := CustledgEntry."Remaining Amount" < 0;
            AppliedCustLedgEntry.SetRange(Positive, PositiveFilter);
            if CustledgEntry."Entry No." <> 0 then
                AppliedCustLedgEntry.SetFilter("Entry No.", '<>%1', CustledgEntry."Entry No.");

            // Find Application Rounding Precision
            GetCustApplicationRoundingPrecisionForAppliesToID(
              AppliedCustLedgEntry, ApplnRoundingPrecision, AmountRoundingPrecision, ApplnInMultiCurrency, ApplnCurrencyCode);

            if AppliedCustLedgEntry.Find('-') then begin
                ApplyingAmount := CustledgEntry."Remaining Amount";
                TempAmount := CustledgEntry."Remaining Amount";
                AppliedCustLedgEntry.SetRange(Positive);
                AppliedCustLedgEntry.Find('-');
                repeat
                    UpdateCustAmountsForApplication(AppliedCustLedgEntry, CustledgEntry, TempAppliedCustLedgerEntry);
                    CheckCustPaymentAmountsForAppliesToID(
                      CustledgEntry, AppliedCustLedgEntry, TempAppliedCustLedgerEntry, MaxPmtTolAmount, AvailableAmount, TempAmount,
                      ApplnRoundingPrecision);
                until AppliedCustLedgEntry.Next() = 0;

                TempAmount := TempAmount + MaxPmtTolAmount;

                PositiveFilter := GetCustPositiveFilter(CustledgEntry."Document Type", TempAmount);
                SetPositiveFilter := true;
                AppliedCustLedgEntry.SetRange(Positive, PositiveFilter);
            end else
                AppliedCustLedgEntry.SetRange(Positive);

            if CustledgEntry."Entry No." <> 0 then
                AppliedCustLedgEntry.SetRange("Entry No.");

            for i := 1 to 2 do begin
                if SetPositiveFilter then begin
                    if i = 2 then
                        AppliedCustLedgEntry.SetRange(Positive, not PositiveFilter);
                end else
                    i := 2;

                with AppliedCustLedgEntry do begin
                    if Find('-') then
                        repeat
                            CalcFields("Remaining Amount");
                            TempAppliedCustLedgerEntry := AppliedCustLedgEntry;
                            if "Currency Code" <> ApplnCurrencyCode then
                                UpdateAmountsForApplication(ApplnDate, ApplnCurrencyCode, false, true);
                            // Check Payment Discount
                            UseDisc := false;
                            if CheckCalcPmtDiscCust(
                                 CustLedgEntry2, AppliedCustLedgEntry, ApplnRoundingPrecision, false, false) and
                               (((CustledgEntry.Amount > 0) and (i = 1)) or
                                (("Remaining Amount" < 0) and (i = 1)) or
                                (Abs(Abs(CustLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) >= Abs(GetRemainingPmtDiscPossible(CustLedgEntry2."Posting Date") + "Max. Payment Tolerance")) or
                                (Abs(Abs(CustLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) <= Abs(GetRemainingPmtDiscPossible(CustLedgEntry2."Posting Date") + MaxPmtTolAmount)))
                            then begin
                                PmtDiscAmount := PmtDiscAmount + GetRemainingPmtDiscPossible(CustLedgEntry2."Posting Date");
                                UseDisc := true;
                            end;

                            // Check Payment Discount Tolerance
                            if "Amount to Apply" = "Remaining Amount" then
                                AvailableAmount := CustLedgEntry2."Remaining Amount"
                            else
                                AvailableAmount := -"Amount to Apply";
                            if CheckPmtDiscTolCust(CustLedgEntry2."Posting Date",
                                 CustledgEntry."Document Type", AvailableAmount,
                                 AppliedCustLedgEntry, ApplnRoundingPrecision, MaxPmtTolAmount) and
                               (((CustledgEntry.Amount > 0) and (i = 1)) or
                                (("Remaining Amount" < 0) and (i = 1)) or
                                (Abs(Abs(CustLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) >= Abs("Remaining Pmt. Disc. Possible" + "Max. Payment Tolerance")) or
                                (Abs(Abs(CustLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) <= Abs("Remaining Pmt. Disc. Possible" + MaxPmtTolAmount)))
                            then begin
                                PmtDiscAmount := PmtDiscAmount + "Remaining Pmt. Disc. Possible";
                                UseDisc := true;
                                "Accepted Pmt. Disc. Tolerance" := true;
                                if CustledgEntry."Currency Code" <> "Currency Code" then begin
                                    RemainingPmtDiscPossible := "Remaining Pmt. Disc. Possible";
                                    "Remaining Pmt. Disc. Possible" := TempAppliedCustLedgerEntry."Remaining Pmt. Disc. Possible";
                                    "Max. Payment Tolerance" := TempAppliedCustLedgerEntry."Max. Payment Tolerance";
                                end;
                                Modify();
                                if CustledgEntry."Currency Code" <> "Currency Code" then
                                    "Remaining Pmt. Disc. Possible" := RemainingPmtDiscPossible;
                            end;

                            if CustledgEntry."Entry No." <> "Entry No." then begin
                                MaxPmtTolAmount := Round(MaxPmtTolAmount, AmountRoundingPrecision);
                                PmtDiscAmount := Round(PmtDiscAmount, AmountRoundingPrecision);
                                AppliedAmount := AppliedAmount + Round("Remaining Amount", AmountRoundingPrecision);
                                if UseDisc then begin
                                    AmounttoApply :=
                                      AmounttoApply +
                                      Round(
                                        ABSMinTol(
                                          "Remaining Amount" -
                                          "Remaining Pmt. Disc. Possible",
                                          "Amount to Apply",
                                          MaxPmtTolAmount),
                                        AmountRoundingPrecision);
                                    CustLedgEntry2."Remaining Amount" :=
                                      CustLedgEntry2."Remaining Amount" +
                                      Round("Remaining Amount" - "Remaining Pmt. Disc. Possible", AmountRoundingPrecision)
                                end else begin
                                    AmounttoApply := AmounttoApply + Round("Amount to Apply", AmountRoundingPrecision);
                                    CustLedgEntry2."Remaining Amount" :=
                                      CustLedgEntry2."Remaining Amount" + Round("Remaining Amount", AmountRoundingPrecision);
                                end;
                                if CustledgEntry."Remaining Amount" > 0 then begin
                                    CustledgEntry."Remaining Amount" := CustledgEntry."Remaining Amount" + "Remaining Amount";
                                    if CustledgEntry."Remaining Amount" < 0 then
                                        CustledgEntry."Remaining Amount" := 0;
                                end;
                                if CustledgEntry."Remaining Amount" < 0 then begin
                                    CustledgEntry."Remaining Amount" := CustledgEntry."Remaining Amount" + "Remaining Amount";
                                    if CustledgEntry."Remaining Amount" > 0 then
                                        CustledgEntry."Remaining Amount" := 0;
                                end;
                            end else
                                ApplyingAmount := "Remaining Amount";
                        until Next() = 0;

                    // if not SuppressCommit then
                    Commit();
                end;
            end;
        end else
            if CustledgEntry."Applies-to Doc. No." <> '' then begin
                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open);
                AppliedCustLedgEntry.SetRange("Customer No.", CustledgEntry."Customer No.");
                AppliedCustLedgEntry.SetRange(Open, true);
                AppliedCustLedgEntry.SetRange("Document No.", CustledgEntry."Applies-to Doc. No.");
                if AppliedCustLedgEntry.Find('-') then begin
                    GetApplicationRoundingPrecisionForAppliesToDoc(
                      AppliedCustLedgEntry."Currency Code", ApplnRoundingPrecision, AmountRoundingPrecision, ApplnCurrencyCode);
                    UpdateCustAmountsForApplication(AppliedCustLedgEntry, CustledgEntry, TempAppliedCustLedgerEntry);
                    CheckCustPaymentAmountsForAppliesToDoc(
                      CustledgEntry, AppliedCustLedgEntry, TempAppliedCustLedgerEntry, MaxPmtTolAmount, ApplnRoundingPrecision, PmtDiscAmount,
                      ApplnCurrencyCode);
                    MaxPmtTolAmount := Round(MaxPmtTolAmount, AmountRoundingPrecision);
                    PmtDiscAmount := Round(PmtDiscAmount, AmountRoundingPrecision);
                    AppliedAmount := Round(AppliedCustLedgEntry."Remaining Amount", AmountRoundingPrecision);
                    AmounttoApply := Round(AppliedCustLedgEntry."Amount to Apply", AmountRoundingPrecision);
                end;
                ApplyingAmount := CustledgEntry.Amount;
            end;
    end;

    local procedure CheckPmtDiscTolCust(NewPostingdate: Date; NewDocType: Enum "Gen. Journal Document Type"; NewAmount: Decimal; OldCustLedgEntry: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; MaxPmtTolAmount: Decimal) Result: Boolean
    var
        ToleranceAmount: Decimal;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if ((NewDocType = NewDocType::Payment) and
            ((OldCustLedgEntry."Document Type" in [OldCustLedgEntry."Document Type"::Invoice,
                                                   OldCustLedgEntry."Document Type"::"Credit Memo"]) and
             (NewPostingdate > OldCustLedgEntry."Pmt. Discount Date") and
             (NewPostingdate <= OldCustLedgEntry."Pmt. Disc. Tolerance Date") and
             (OldCustLedgEntry."Remaining Pmt. Disc. Possible" <> 0))) or
           ((NewDocType = NewDocType::Refund) and
            ((OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::"Credit Memo") and
             (NewPostingdate > OldCustLedgEntry."Pmt. Discount Date") and
             (NewPostingdate <= OldCustLedgEntry."Pmt. Disc. Tolerance Date") and
             (OldCustLedgEntry."Remaining Pmt. Disc. Possible" <> 0)))
        then begin
            ToleranceAmount := (Abs(NewAmount) + ApplnRoundingPrecision) -
              Abs(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible");
            exit((ToleranceAmount >= 0) or (Abs(MaxPmtTolAmount) >= Abs(ToleranceAmount)));
        end;
        exit(false);
    end;

    procedure CheckCalcPmtDiscCust(var NewCustLedgEntry: Record "Cust. Ledger Entry"; var OldCustLedgEntry2: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckFilter: Boolean; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf.CopyFromCustLedgEntry(NewCustLedgEntry);
        OldCustLedgEntry2.CopyFilter(Positive, OldCVLedgEntryBuf2.Positive);
        OldCVLedgEntryBuf2.CopyFromCustLedgEntry(OldCustLedgEntry2);
        exit(
          CheckCalcPmtDisc(
            NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, CheckFilter, CheckAmount));
    end;

    local procedure GetCustPositiveFilter(DocumentType: Enum "Gen. Journal Document Type"; TempAmount: Decimal) PositiveFilter: Boolean
    begin
        PositiveFilter := TempAmount <= 0;
        if ((TempAmount > 0) and (DocumentType = DocumentType::Refund) or (DocumentType = DocumentType::Invoice) or
            (DocumentType = DocumentType::"Credit Memo"))
        then
            PositiveFilter := true;

        exit(PositiveFilter);
    end;

    procedure CheckCalcPmtDisc(var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer"; ApplnRoundingPrecision: Decimal; CheckFilter: Boolean; CheckAmount: Boolean): Boolean
    var
        Handled: Boolean;
        Result: Boolean;
    begin
        if Handled then
            exit(Result);

        if ((NewCVLedgEntryBuf."Document Type" in [NewCVLedgEntryBuf."Document Type"::Refund,
                                                   NewCVLedgEntryBuf."Document Type"::Payment]) and
            (((OldCVLedgEntryBuf2."Document Type" = OldCVLedgEntryBuf2."Document Type"::"Credit Memo") and
              (OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date") <> 0) and
              (NewCVLedgEntryBuf."Posting Date" <= OldCVLedgEntryBuf2."Pmt. Discount Date")) or
             ((OldCVLedgEntryBuf2."Document Type" = OldCVLedgEntryBuf2."Document Type"::Invoice) and
              (OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date") <> 0) and
              (NewCVLedgEntryBuf."Posting Date" <= OldCVLedgEntryBuf2."Pmt. Discount Date"))))
        then begin
            if CheckFilter then begin
                if CheckAmount then begin
                    if (OldCVLedgEntryBuf2.GetFilter(Positive) <> '') or
                       (Abs(NewCVLedgEntryBuf."Remaining Amount") + ApplnRoundingPrecision >=
                        Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2.GetRemainingPmtDiscPossible(NewCVLedgEntryBuf."Posting Date")))
                    then
                        exit(true);

                    exit(false);
                end;

                exit(OldCVLedgEntryBuf2.GetFilter(Positive) <> '');
            end;
            if CheckAmount then
                exit((Abs(NewCVLedgEntryBuf."Remaining Amount") + ApplnRoundingPrecision >=
                      Abs(OldCVLedgEntryBuf2."Remaining Amount" - OldCVLedgEntryBuf2."Remaining Pmt. Disc. Possible")));

            exit(true);
        end;
        exit(false);
    end;

    local procedure CheckCustPaymentAmountsForAppliesToID(CustLedgEntry: Record "Cust. Ledger Entry"; var AppliedCustLedgEntry: Record "Cust. Ledger Entry"; var TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary; var MaxPmtTolAmount: Decimal; var AvailableAmount: Decimal; var TempAmount: Decimal; ApplnRoundingPrecision: Decimal)
    begin
        // Check Payment Tolerance
        if CheckPmtTolCust(CustLedgEntry."Document Type", AppliedCustLedgEntry) then
            MaxPmtTolAmount := MaxPmtTolAmount + AppliedCustLedgEntry."Max. Payment Tolerance";

        // Check Payment Discount
        if CheckCalcPmtDiscCust(CustLedgEntry, AppliedCustLedgEntry, 0, false, false) then
            AppliedCustLedgEntry."Remaining Amount" :=
              AppliedCustLedgEntry."Remaining Amount" - AppliedCustLedgEntry.GetRemainingPmtDiscPossible(CustLedgEntry."Posting Date");

        // Check Payment Discount Tolerance
        if AppliedCustLedgEntry."Amount to Apply" = AppliedCustLedgEntry."Remaining Amount" then
            AvailableAmount := TempAmount
        else
            AvailableAmount := -AppliedCustLedgEntry."Amount to Apply";
        if CheckPmtDiscTolCust(
             CustLedgEntry."Posting Date", CustLedgEntry."Document Type", AvailableAmount, AppliedCustLedgEntry, ApplnRoundingPrecision,
             MaxPmtTolAmount)
        then begin
            AppliedCustLedgEntry."Remaining Amount" :=
              AppliedCustLedgEntry."Remaining Amount" - AppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
            AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance" := true;
            if CustLedgEntry."Currency Code" <> AppliedCustLedgEntry."Currency Code" then begin
                AppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                  TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                AppliedCustLedgEntry."Max. Payment Tolerance" :=
                  TempAppliedCustLedgEntry."Max. Payment Tolerance";
            end;
            AppliedCustLedgEntry.Modify();
        end;
        TempAmount :=
          TempAmount +
          ABSMinTol(
            AppliedCustLedgEntry."Remaining Amount",
            AppliedCustLedgEntry."Amount to Apply",
            MaxPmtTolAmount);
    end;

    local procedure CheckPmtTolCust(NewDocType: Enum "Gen. Journal Document Type"; OldCustLedgEntry: Record "Cust. Ledger Entry"): Boolean
    begin
        if ((NewDocType = NewDocType::Payment) and
            (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice)) or
           ((NewDocType = NewDocType::Refund) and
            (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::"Credit Memo"))
        then
            exit(true);

        exit(false);
    end;

    local procedure UpdateCustAmountsForApplication(var AppliedCustLedgEntry: Record "Cust. Ledger Entry"; var CustLedgEntry: Record "Cust. Ledger Entry"; var TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary)
    begin
        AppliedCustLedgEntry.CalcFields("Remaining Amount");
        TempAppliedCustLedgEntry := AppliedCustLedgEntry;
        if CustLedgEntry."Currency Code" <> AppliedCustLedgEntry."Currency Code" then
            AppliedCustLedgEntry.UpdateAmountsForApplication(CustLedgEntry."Posting Date", CustLedgEntry."Currency Code", true, true);
    end;

    local procedure GetCustApplicationRoundingPrecisionForAppliesToID(var AppliedCustLedgEntry: Record "Cust. Ledger Entry"; var ApplnRoundingPrecision: Decimal; var AmountRoundingPrecision: Decimal; var ApplnInMultiCurrency: Boolean; ApplnCurrencyCode: Code[20])
    begin
        AppliedCustLedgEntry.SetFilter("Currency Code", '<>%1', ApplnCurrencyCode);
        ApplnInMultiCurrency := not AppliedCustLedgEntry.IsEmpty();
        AppliedCustLedgEntry.SetRange("Currency Code");

        GetAmountRoundingPrecision(ApplnRoundingPrecision, AmountRoundingPrecision, ApplnInMultiCurrency, ApplnCurrencyCode);
    end;

    local procedure CheckCustPaymentAmountsForAppliesToDoc(CustLedgEntry: Record "Cust. Ledger Entry"; var AppliedCustLedgEntry: Record "Cust. Ledger Entry"; var TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary; var MaxPmtTolAmount: Decimal; ApplnRoundingPrecision: Decimal; var PmtDiscAmount: Decimal; ApplnCurrencyCode: Code[20])
    begin
        // Check Payment Tolerance
        if CheckPmtTolCust(CustLedgEntry."Document Type", AppliedCustLedgEntry) and
           CheckCustLedgAmt(CustLedgEntry, AppliedCustLedgEntry, AppliedCustLedgEntry."Max. Payment Tolerance", ApplnRoundingPrecision)
        then
            MaxPmtTolAmount := MaxPmtTolAmount + AppliedCustLedgEntry."Max. Payment Tolerance";

        // Check Payment Discount
        if CheckCalcPmtDiscCust(CustLedgEntry, AppliedCustLedgEntry, 0, false, false) and
           CheckCustLedgAmt(CustLedgEntry, AppliedCustLedgEntry, MaxPmtTolAmount, ApplnRoundingPrecision)
        then
            PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntry.GetRemainingPmtDiscPossible(CustLedgEntry."Posting Date");

        // Check Payment Discount Tolerance
        if CheckPmtDiscTolCust(
             CustLedgEntry."Posting Date", CustLedgEntry."Document Type", CustLedgEntry.Amount, AppliedCustLedgEntry,
             ApplnRoundingPrecision, MaxPmtTolAmount) and CheckCustLedgAmt(
             CustLedgEntry, AppliedCustLedgEntry, MaxPmtTolAmount, ApplnRoundingPrecision)
        then begin
            PmtDiscAmount := PmtDiscAmount + AppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
            AppliedCustLedgEntry."Accepted Pmt. Disc. Tolerance" := true;
            if AppliedCustLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                AppliedCustLedgEntry."Max. Payment Tolerance" :=
                  TempAppliedCustLedgEntry."Max. Payment Tolerance";
                AppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                  TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
            end;
            AppliedCustLedgEntry.Modify();
            //if not SuppressCommit then
            Commit();
        end;
    end;

    local procedure CheckCustLedgAmt(CustLedgEntry: Record "Cust. Ledger Entry"; AppliedCustLedgEntry: Record "Cust. Ledger Entry"; MaxPmtTolAmount: Decimal; ApplnRoundingPrecision: Decimal): Boolean
    begin
        exit((Abs(CustLedgEntry.Amount) + ApplnRoundingPrecision >= Abs(AppliedCustLedgEntry."Remaining Amount" -
                AppliedCustLedgEntry."Remaining Pmt. Disc. Possible" - MaxPmtTolAmount)));
    end;


    local procedure CheckVendLedgAmt(VendLedgEntry: Record "Vendor Ledger Entry"; AppliedVendLedgEntry: Record "Vendor Ledger Entry"; MaxPmtTolAmount: Decimal; ApplnRoundingPrecision: Decimal): Boolean
    begin
        exit((Abs(VendLedgEntry.Amount) + ApplnRoundingPrecision >= Abs(AppliedVendLedgEntry."Remaining Amount" -
                AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" - MaxPmtTolAmount)));
    end;

    local procedure DelVendPmtTolAcc(VendLedgEntry: Record "Vendor Ledger Entry"; VendEntryApplID: Code[50])
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        if VendLedgEntry."Applies-to Doc. No." <> '' then begin
            AppliedVendLedgEntry.SetCurrentKey("Document No.");
            AppliedVendLedgEntry.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
            AppliedVendLedgEntry.SetRange(Open, true);
            AppliedVendLedgEntry.SetRange("Document No.", VendLedgEntry."Applies-to Doc. No.");
            AppliedVendLedgEntry.LockTable();
            if AppliedVendLedgEntry.FindFirst() then begin
                AppliedVendLedgEntry."Accepted Payment Tolerance" := 0;
                AppliedVendLedgEntry."Accepted Pmt. Disc. Tolerance" := false;
                AppliedVendLedgEntry.Modify();
                // if not SuppressCommit then
                Commit();
            end;
        end;

        if VendEntryApplID <> '' then begin
            AppliedVendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open, Positive, "Due Date");
            AppliedVendLedgEntry.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
            AppliedVendLedgEntry.SetRange(Open, true);
            AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID);
            AppliedVendLedgEntry.LockTable();
            if not AppliedVendLedgEntry.IsEmpty() then begin
                AppliedVendLedgEntry.ModifyAll("Accepted Payment Tolerance", 0);
                AppliedVendLedgEntry.ModifyAll("Accepted Pmt. Disc. Tolerance", false);
                // if not SuppressCommit then
                Commit();
            end;
        end;
    end;

    local procedure CalcVendApplnAmount(VendledgEntry: Record "Vendor Ledger Entry"; GLSetup: Record "General Ledger Setup"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal; var AmounttoApply: Decimal; var PmtDiscAmount: Decimal; var MaxPmtTolAmount: Decimal; VendEntryApplID: Code[50]; var ApplnRoundingPrecision: Decimal)
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        TempAppliedVendorLedgerEntry: Record "Vendor Ledger Entry" temporary;
        VendLedgEntry2: Record "Vendor Ledger Entry";
        ApplnCurrencyCode: Code[10];
        ApplnDate: Date;
        AmountRoundingPrecision: Decimal;
        TempAmount: Decimal;
        i: Integer;
        PositiveFilter: Boolean;
        SetPositiveFilter: Boolean;
        ApplnInMultiCurrency: Boolean;
        RemainingPmtDiscPossible: Decimal;
        UseDisc: Boolean;
        AvailableAmount: Decimal;
    begin
        ApplnCurrencyCode := VendledgEntry."Currency Code";
        ApplnDate := VendledgEntry."Posting Date";
        ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision";
        AmountRoundingPrecision := GLSetup."Amount Rounding Precision";

        if VendEntryApplID <> '' then begin
            AppliedVendLedgEntry.SetCurrentKey("Vendor No.", "Applies-to ID", Open, Positive);
            AppliedVendLedgEntry.SetRange("Vendor No.", VendledgEntry."Vendor No.");
            AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID);
            AppliedVendLedgEntry.SetRange(Open, true);
            VendLedgEntry2 := VendledgEntry;
            PositiveFilter := VendledgEntry."Remaining Amount" > 0;
            AppliedVendLedgEntry.SetRange(Positive, not PositiveFilter);

            if VendledgEntry."Entry No." <> 0 then
                AppliedVendLedgEntry.SetFilter("Entry No.", '<>%1', VendledgEntry."Entry No.");
            GetVendApplicationRoundingPrecisionForAppliesToID(AppliedVendLedgEntry,
              ApplnRoundingPrecision, AmountRoundingPrecision, ApplnInMultiCurrency, ApplnCurrencyCode);
            if AppliedVendLedgEntry.Find('-') then begin
                ApplyingAmount := VendledgEntry."Remaining Amount";
                TempAmount := VendledgEntry."Remaining Amount";
                AppliedVendLedgEntry.SetRange(Positive);
                AppliedVendLedgEntry.Find('-');
                repeat
                    UpdateVendAmountsForApplication(AppliedVendLedgEntry, VendledgEntry, TempAppliedVendorLedgerEntry);
                    CheckVendPaymentAmountsForAppliesToID(
                      VendledgEntry, AppliedVendLedgEntry, TempAppliedVendorLedgerEntry, MaxPmtTolAmount, AvailableAmount, TempAmount,
                      ApplnRoundingPrecision);
                until AppliedVendLedgEntry.Next() = 0;

                TempAmount := TempAmount + MaxPmtTolAmount;
                PositiveFilter := GetVendPositiveFilter(VendledgEntry."Document Type", TempAmount);
                SetPositiveFilter := true;
                AppliedVendLedgEntry.SetRange(Positive, not PositiveFilter);
            end else
                AppliedVendLedgEntry.SetRange(Positive);

            if VendledgEntry."Entry No." <> 0 then
                AppliedVendLedgEntry.SetRange("Entry No.");

            for i := 1 to 2 do begin
                if SetPositiveFilter then begin
                    if i = 2 then
                        AppliedVendLedgEntry.SetRange(Positive, PositiveFilter);
                end else
                    i := 2;

                with AppliedVendLedgEntry do begin
                    if Find('-') then
                        repeat
                            CalcFields("Remaining Amount");
                            TempAppliedVendorLedgerEntry := AppliedVendLedgEntry;
                            if "Currency Code" <> ApplnCurrencyCode then
                                UpdateAmountsForApplication(ApplnDate, ApplnCurrencyCode, false, true);
                            // Check Payment Discount
                            UseDisc := false;
                            if CheckCalcPmtDiscVend(
                                 VendLedgEntry2, AppliedVendLedgEntry, ApplnRoundingPrecision, false, false) and
                               (((VendledgEntry.Amount < 0) and (i = 1)) or
                                (("Remaining Amount" > 0) and (i = 1)) or
                                (Abs(Abs(VendLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) >= Abs(GetRemainingPmtDiscPossible(VendLedgEntry2."Posting Date") + "Max. Payment Tolerance")) or
                                (Abs(Abs(VendLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) <= Abs(GetRemainingPmtDiscPossible(VendLedgEntry2."Posting Date") + MaxPmtTolAmount)))
                            then begin
                                PmtDiscAmount := PmtDiscAmount + GetRemainingPmtDiscPossible(VendLedgEntry2."Posting Date");
                                UseDisc := true;
                            end;

                            // Check Payment Discount Tolerance
                            if "Amount to Apply" = "Remaining Amount" then
                                AvailableAmount := VendLedgEntry2."Remaining Amount"
                            else
                                AvailableAmount := -"Amount to Apply";

                            if CheckPmtDiscTolVend(
                                 VendLedgEntry2."Posting Date", VendledgEntry."Document Type", AvailableAmount,
                                 AppliedVendLedgEntry, ApplnRoundingPrecision, MaxPmtTolAmount) and
                               (((VendledgEntry.Amount < 0) and (i = 1)) or
                                (("Remaining Amount" > 0) and (i = 1)) or
                                (Abs(Abs(VendLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) >= Abs("Remaining Pmt. Disc. Possible" + "Max. Payment Tolerance")) or
                                (Abs(Abs(VendLedgEntry2."Remaining Amount") + ApplnRoundingPrecision -
                                   Abs("Remaining Amount")) <= Abs("Remaining Pmt. Disc. Possible" + MaxPmtTolAmount)))
                            then begin
                                PmtDiscAmount := PmtDiscAmount + "Remaining Pmt. Disc. Possible";
                                UseDisc := true;
                                "Accepted Pmt. Disc. Tolerance" := true;
                                if VendledgEntry."Currency Code" <> "Currency Code" then begin
                                    RemainingPmtDiscPossible := "Remaining Pmt. Disc. Possible";
                                    "Remaining Pmt. Disc. Possible" := TempAppliedVendorLedgerEntry."Remaining Pmt. Disc. Possible";
                                    "Max. Payment Tolerance" := TempAppliedVendorLedgerEntry."Max. Payment Tolerance";
                                end;
                                Modify();
                                if VendledgEntry."Currency Code" <> "Currency Code" then
                                    "Remaining Pmt. Disc. Possible" := RemainingPmtDiscPossible;
                            end;

                            if VendledgEntry."Entry No." <> "Entry No." then begin
                                PmtDiscAmount := Round(PmtDiscAmount, AmountRoundingPrecision);
                                MaxPmtTolAmount := Round(MaxPmtTolAmount, AmountRoundingPrecision);
                                AppliedAmount := AppliedAmount + Round("Remaining Amount", AmountRoundingPrecision);
                                if UseDisc then begin
                                    AmounttoApply :=
                                      AmounttoApply +
                                      Round(
                                        ABSMinTol(
                                          "Remaining Amount" -
                                          "Remaining Pmt. Disc. Possible",
                                          "Amount to Apply",
                                          MaxPmtTolAmount),
                                        AmountRoundingPrecision);
                                    VendLedgEntry2."Remaining Amount" :=
                                      VendLedgEntry2."Remaining Amount" +
                                      Round("Remaining Amount" - "Remaining Pmt. Disc. Possible", AmountRoundingPrecision)
                                end else begin
                                    AmounttoApply := AmounttoApply + Round("Amount to Apply", AmountRoundingPrecision);
                                    VendLedgEntry2."Remaining Amount" :=
                                      VendLedgEntry2."Remaining Amount" + Round("Remaining Amount", AmountRoundingPrecision);
                                end;
                                if VendledgEntry."Remaining Amount" > 0 then begin
                                    VendledgEntry."Remaining Amount" := VendledgEntry."Remaining Amount" + "Remaining Amount";
                                    if VendledgEntry."Remaining Amount" < 0 then
                                        VendledgEntry."Remaining Amount" := 0;
                                end;
                                if VendledgEntry."Remaining Amount" < 0 then begin
                                    VendledgEntry."Remaining Amount" := VendledgEntry."Remaining Amount" + "Remaining Amount";
                                    if VendledgEntry."Remaining Amount" > 0 then
                                        VendledgEntry."Remaining Amount" := 0;
                                end;
                            end else
                                ApplyingAmount := "Remaining Amount";
                        until Next() = 0;

                    //if not SuppressCommit then
                    Commit();
                end;
                // OnCalcVendApplnAmountOnAfterAppliedVendLedgEntryLoop(AppliedVendLedgEntry);
            end;
        end else
            if VendledgEntry."Applies-to Doc. No." <> '' then begin
                AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open);
                AppliedVendLedgEntry.SetRange("Vendor No.", VendledgEntry."Vendor No.");
                AppliedVendLedgEntry.SetRange(Open, true);
                AppliedVendLedgEntry.SetRange("Document No.", VendledgEntry."Applies-to Doc. No.");
                if AppliedVendLedgEntry.Find('-') then begin
                    GetApplicationRoundingPrecisionForAppliesToDoc(
                      AppliedVendLedgEntry."Currency Code", ApplnRoundingPrecision, AmountRoundingPrecision, ApplnCurrencyCode);
                    UpdateVendAmountsForApplication(AppliedVendLedgEntry, VendledgEntry, TempAppliedVendorLedgerEntry);
                    CheckVendPaymentAmountsForAppliesToDoc(VendledgEntry, AppliedVendLedgEntry, TempAppliedVendorLedgerEntry, MaxPmtTolAmount,
                      ApplnRoundingPrecision, PmtDiscAmount);
                    PmtDiscAmount := Round(PmtDiscAmount, AmountRoundingPrecision);
                    MaxPmtTolAmount := Round(MaxPmtTolAmount, AmountRoundingPrecision);
                    AppliedAmount := Round(AppliedVendLedgEntry."Remaining Amount", AmountRoundingPrecision);
                    AmounttoApply := Round(AppliedVendLedgEntry."Amount to Apply", AmountRoundingPrecision);
                end;
                ApplyingAmount := VendledgEntry.Amount;
            end;
    end;


    local procedure CheckVendPaymentAmountsForAppliesToID(VendLedgEntry: Record "Vendor Ledger Entry"; var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary; var MaxPmtTolAmount: Decimal; var AvailableAmount: Decimal; var TempAmount: Decimal; ApplnRoundingPrecision: Decimal)
    begin
        // Check Payment Tolerance
        if CheckPmtTolVend(VendLedgEntry."Document Type", AppliedVendLedgEntry) then
            MaxPmtTolAmount := MaxPmtTolAmount + AppliedVendLedgEntry."Max. Payment Tolerance";

        // Check Payment Discount
        if CheckCalcPmtDiscVend(VendLedgEntry, AppliedVendLedgEntry, 0, false, false) then
            AppliedVendLedgEntry."Remaining Amount" :=
              AppliedVendLedgEntry."Remaining Amount" - AppliedVendLedgEntry.GetRemainingPmtDiscPossible(VendLedgEntry."Posting Date");

        // Check Payment Discount Tolerance
        if AppliedVendLedgEntry."Amount to Apply" = AppliedVendLedgEntry."Remaining Amount" then
            AvailableAmount := TempAmount
        else
            AvailableAmount := -AppliedVendLedgEntry."Amount to Apply";
        if CheckPmtDiscTolVend(VendLedgEntry."Posting Date", VendLedgEntry."Document Type", AvailableAmount,
             AppliedVendLedgEntry, ApplnRoundingPrecision, MaxPmtTolAmount)
        then begin
            AppliedVendLedgEntry."Remaining Amount" :=
              AppliedVendLedgEntry."Remaining Amount" - AppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
            AppliedVendLedgEntry."Accepted Pmt. Disc. Tolerance" := true;
            if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then begin
                AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" :=
                  TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                AppliedVendLedgEntry."Max. Payment Tolerance" :=
                  TempAppliedVendLedgEntry."Max. Payment Tolerance";
            end;
            AppliedVendLedgEntry.Modify();
        end;
        TempAmount :=
          TempAmount +
          ABSMinTol(
            AppliedVendLedgEntry."Remaining Amount",
            AppliedVendLedgEntry."Amount to Apply",
            MaxPmtTolAmount);
    end;

    local procedure CheckPmtTolVend(NewDocType: Enum "Gen. Journal Document Type"; OldVendLedgEntry: Record "Vendor Ledger Entry"): Boolean
    begin
        if ((NewDocType = NewDocType::Payment) and
            (OldVendLedgEntry."Document Type" = OldVendLedgEntry."Document Type"::Invoice)) or
           ((NewDocType = NewDocType::Refund) and
            (OldVendLedgEntry."Document Type" = OldVendLedgEntry."Document Type"::"Credit Memo"))
        then
            exit(true);

        exit(false);
    end;

    local procedure GetVendPositiveFilter(DocumentType: Enum "Gen. Journal Document Type"; TempAmount: Decimal) PositiveFilter: Boolean
    begin
        PositiveFilter := TempAmount >= 0;
        if ((TempAmount < 0) and (DocumentType = DocumentType::Refund) or (DocumentType = DocumentType::Invoice) or
            (DocumentType = DocumentType::"Credit Memo"))
        then
            PositiveFilter := true;

        exit(PositiveFilter);
    end;

    procedure CheckCalcPmtDiscVend(var NewVendLedgEntry: Record "Vendor Ledger Entry"; var OldVendLedgEntry2: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckFilter: Boolean; CheckAmount: Boolean): Boolean
    var
        NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer";
        OldCVLedgEntryBuf2: Record "CV Ledger Entry Buffer";
    begin
        NewCVLedgEntryBuf.CopyFromVendLedgEntry(NewVendLedgEntry);
        OldVendLedgEntry2.CopyFilter(Positive, OldCVLedgEntryBuf2.Positive);
        OldCVLedgEntryBuf2.CopyFromVendLedgEntry(OldVendLedgEntry2);
        exit(
          CheckCalcPmtDisc(
            NewCVLedgEntryBuf, OldCVLedgEntryBuf2, ApplnRoundingPrecision, CheckFilter, CheckAmount));
    end;

    local procedure CheckPmtDiscTolVend(NewPostingdate: Date; NewDocType: Enum "Gen. Journal Document Type"; NewAmount: Decimal; OldVendLedgEntry: Record "Vendor Ledger Entry"; ApplnRoundingPrecision: Decimal; MaxPmtTolAmount: Decimal): Boolean
    var
        ToleranceAmount: Decimal;
    begin
        if ((NewDocType = NewDocType::Payment) and
            ((OldVendLedgEntry."Document Type" in [OldVendLedgEntry."Document Type"::Invoice,
                                                   OldVendLedgEntry."Document Type"::"Credit Memo"]) and
             (NewPostingdate > OldVendLedgEntry."Pmt. Discount Date") and
             (NewPostingdate <= OldVendLedgEntry."Pmt. Disc. Tolerance Date") and
             (OldVendLedgEntry."Remaining Pmt. Disc. Possible" <> 0))) or
           ((NewDocType = NewDocType::Refund) and
            ((OldVendLedgEntry."Document Type" = OldVendLedgEntry."Document Type"::"Credit Memo") and
             (NewPostingdate > OldVendLedgEntry."Pmt. Discount Date") and
             (NewPostingdate <= OldVendLedgEntry."Pmt. Disc. Tolerance Date") and
             (OldVendLedgEntry."Remaining Pmt. Disc. Possible" <> 0)))
        then begin
            ToleranceAmount := (Abs(NewAmount) + ApplnRoundingPrecision) -
              Abs(OldVendLedgEntry."Remaining Amount" - OldVendLedgEntry."Remaining Pmt. Disc. Possible");
            exit((ToleranceAmount >= 0) or (Abs(MaxPmtTolAmount) >= Abs(ToleranceAmount)));
        end;
        exit(false);
    end;

    procedure ABSMinTol(Decimal1: Decimal; Decimal2: Decimal; Decimal1Tolerance: Decimal): Decimal
    begin
        if Abs(Decimal1) - Abs(Decimal1Tolerance) < Abs(Decimal2) then
            exit(Decimal1);
        exit(Decimal2);
    end;

    local procedure UpdateVendAmountsForApplication(var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var VendLedgEntry: Record "Vendor Ledger Entry"; var TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary)
    begin
        AppliedVendLedgEntry.CalcFields("Remaining Amount");
        TempAppliedVendLedgEntry := AppliedVendLedgEntry;
        if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then
            AppliedVendLedgEntry.UpdateAmountsForApplication(VendLedgEntry."Posting Date", VendLedgEntry."Currency Code", true, true);
    end;

    local procedure CheckVendPaymentAmountsForAppliesToDoc(VendLedgEntry: Record "Vendor Ledger Entry"; var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var TempAppliedVendLedgEntry: Record "Vendor Ledger Entry" temporary; var MaxPmtTolAmount: Decimal; ApplnRoundingPrecision: Decimal; var PmtDiscAmount: Decimal)
    begin
        // Check Payment Tolerance
        if CheckPmtTolVend(VendLedgEntry."Document Type", AppliedVendLedgEntry) and
           CheckVendLedgAmt(VendLedgEntry, AppliedVendLedgEntry, AppliedVendLedgEntry."Max. Payment Tolerance", ApplnRoundingPrecision)
        then
            MaxPmtTolAmount := MaxPmtTolAmount + AppliedVendLedgEntry."Max. Payment Tolerance";

        // Check Payment Discount
        if CheckCalcPmtDiscVend(
             VendLedgEntry, AppliedVendLedgEntry, 0, false, false) and
           CheckVendLedgAmt(VendLedgEntry, AppliedVendLedgEntry, MaxPmtTolAmount, ApplnRoundingPrecision)
        then
            PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntry.GetRemainingPmtDiscPossible(VendLedgEntry."Posting Date");

        // Check Payment Discount Tolerance
        if CheckPmtDiscTolVend(
             VendLedgEntry."Posting Date", VendLedgEntry."Document Type", VendLedgEntry.Amount,
             AppliedVendLedgEntry, ApplnRoundingPrecision, MaxPmtTolAmount) and
           CheckVendLedgAmt(VendLedgEntry, AppliedVendLedgEntry, MaxPmtTolAmount, ApplnRoundingPrecision)
        then begin
            PmtDiscAmount := PmtDiscAmount + AppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
            AppliedVendLedgEntry."Accepted Pmt. Disc. Tolerance" := true;
            if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then begin
                AppliedVendLedgEntry."Remaining Pmt. Disc. Possible" := TempAppliedVendLedgEntry."Remaining Pmt. Disc. Possible";
                AppliedVendLedgEntry."Max. Payment Tolerance" := TempAppliedVendLedgEntry."Max. Payment Tolerance";
            end;
            AppliedVendLedgEntry.Modify();
            //if not SuppressCommit then
            Commit();
        end;
    end;

    procedure GetApplicationRoundingPrecisionForAppliesToDoc(AppliedEntryCurrencyCode: Code[10]; var ApplnRoundingPrecision: Decimal; var AmountRoundingPrecision: Decimal; ApplnCurrencyCode: Code[20])
    var
        Currency: Record Currency;
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init();
            Currency.Code := '';
            Currency.InitRoundingPrecision();
            if AppliedEntryCurrencyCode = '' then
                ApplnRoundingPrecision := 0;
        end else begin
            if ApplnCurrencyCode <> AppliedEntryCurrencyCode then begin
                Currency.Get(ApplnCurrencyCode);
                ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
            end else
                ApplnRoundingPrecision := 0;
        end;
        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    local procedure ManagePaymentDiscToleranceWarningCustomer(var NewCustLedgEntry: Record "Cust. Ledger Entry"; GenJnlLineApplID: Code[50]; var AppliedAmount: Decimal; var AmountToApply: Decimal; AppliesToDocNo: Code[20]): Boolean
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        RemainingAmountTest: Boolean;
    begin
        with AppliedCustLedgEntry do begin
            SetCurrentKey("Customer No.", "Applies-to ID", Open, Positive);
            SetRange("Customer No.", NewCustLedgEntry."Customer No.");
            if AppliesToDocNo <> '' then
                SetRange("Document No.", AppliesToDocNo)
            else
                SetRange("Applies-to ID", GenJnlLineApplID);
            SetRange(Open, true);
            SetRange("Accepted Pmt. Disc. Tolerance", true);
            if FindSet() then
                repeat
                    CalcFields("Remaining Amount");
                    if CallPmtDiscTolWarning(
                         "Posting Date", "Customer No.",
                         "Document No.", "Currency Code",
                         "Remaining Amount", 0,
                         "Remaining Pmt. Disc. Possible", RemainingAmountTest, "Payment Tolerance Account Type"::Customer)
                    then begin
                        if RemainingAmountTest then begin
                            "Accepted Pmt. Disc. Tolerance" := false;
                            Modify();
                            //if not SuppressCommit then
                            Commit();
                            if NewCustLedgEntry."Currency Code" <> "Currency Code" then
                                "Remaining Pmt. Disc. Possible" :=
                                  CurrExchRate.ExchangeAmount(
                                    "Remaining Pmt. Disc. Possible",
                                    "Currency Code",
                                    NewCustLedgEntry."Currency Code",
                                    NewCustLedgEntry."Posting Date");
                            AppliedAmount := AppliedAmount + "Remaining Pmt. Disc. Possible";
                            AmountToApply := AmountToApply + "Remaining Pmt. Disc. Possible";
                        end
                    end else begin
                        DelCustPmtTolAcc(NewCustLedgEntry, GenJnlLineApplID);
                        exit(false);
                    end;
                until Next() = 0;
        end;

        exit(true);
    end;

    local procedure ManagePaymentDiscToleranceWarningVendor(var NewVendLedgEntry: Record "Vendor Ledger Entry"; GenJnlLineApplID: Code[50]; var AppliedAmount: Decimal; var AmountToApply: Decimal; AppliesToDocNo: Code[20]): Boolean
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        RemainingAmountTest: Boolean;
    begin
        with AppliedVendLedgEntry do begin
            SetCurrentKey("Vendor No.", "Applies-to ID", Open, Positive);
            SetRange("Vendor No.", NewVendLedgEntry."Vendor No.");
            if AppliesToDocNo <> '' then
                SetRange("Document No.", AppliesToDocNo)
            else
                SetRange("Applies-to ID", GenJnlLineApplID);
            SetRange(Open, true);
            SetRange("Accepted Pmt. Disc. Tolerance", true);
            if FindSet() then
                repeat
                    CalcFields("Remaining Amount");
                    if CallPmtDiscTolWarning(
                         "Posting Date", "Vendor No.",
                         "Document No.", "Currency Code",
                         "Remaining Amount", 0,
                         "Remaining Pmt. Disc. Possible", RemainingAmountTest, "Payment Tolerance Account Type"::Vendor)
                    then begin
                        if RemainingAmountTest then begin
                            "Accepted Pmt. Disc. Tolerance" := false;
                            Modify();
                            //if not SuppressCommit then
                            Commit();
                            if NewVendLedgEntry."Currency Code" <> "Currency Code" then
                                "Remaining Pmt. Disc. Possible" :=
                                  CurrExchRate.ExchangeAmount(
                                    "Remaining Pmt. Disc. Possible",
                                    "Currency Code",
                                    NewVendLedgEntry."Currency Code", NewVendLedgEntry."Posting Date");
                            AppliedAmount := AppliedAmount + "Remaining Pmt. Disc. Possible";
                            AmountToApply := AmountToApply + "Remaining Pmt. Disc. Possible";
                        end
                    end else begin
                        DelVendPmtTolAcc(NewVendLedgEntry, GenJnlLineApplID);
                        exit(false);
                    end;
                until Next() = 0;
        end;

        exit(true);
    end;

    procedure CallPmtDiscTolWarning(PostingDate: Date; No: Code[20]; DocNo: Code[20]; CurrencyCode: Code[10]; Amount: Decimal; AppliedAmount: Decimal; PmtDiscAmount: Decimal; var RemainingAmountTest: Boolean; AccountType: Enum "Payment Tolerance Account Type") Result: Boolean
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PmtDiscTolWarning: Page "Payment Disc Tolerance Warning";
        ActionType: Integer;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

        if PmtDiscAmount = 0 then begin
            RemainingAmountTest := false;
            exit(true);
        end;

        if GenJnlPostPreview.IsActive() then
            exit(true);

        //if SuppressCommit then
        exit(true);

        //if SuppressWarning then
        exit(true);

        PmtDiscTolWarning.SetValues(PostingDate, No, DocNo, CurrencyCode, Amount, AppliedAmount, PmtDiscAmount);
        PmtDiscTolWarning.SetAccountName(GetAccountName(AccountType, No));
        PmtDiscTolWarning.LookupMode(true);
        if ACTION::Yes = PmtDiscTolWarning.RunModal() then begin
            PmtDiscTolWarning.GetValues(ActionType);
            if ActionType = 2 then
                RemainingAmountTest := true
            else
                RemainingAmountTest := false;
        end else
            exit(false);
        exit(true);
    end;

    procedure CallPmtTolWarning(PostingDate: Date; No: Code[20]; DocNo: Code[20]; CurrencyCode: Code[10]; var Amount: Decimal; AppliedAmount: Decimal; AccountType: Enum "Payment Tolerance Account Type"): Boolean
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        PmtTolWarning: Page "Payment Tolerance Warning";
        ActionType: Integer;
        IsHandled: Boolean;
    begin
        if GenJnlPostPreview.IsActive() then
            exit(true);

        //if SuppressCommit then
        exit(true);

        //if SuppressWarning then
        exit(true);

        IsHandled := false;
        if IsHandled then
            exit(ActionType = 2);

        PmtTolWarning.SetValues(PostingDate, No, DocNo, CurrencyCode, Amount, AppliedAmount, 0);
        PmtTolWarning.SetAccountName(GetAccountName(AccountType, No));
        PmtTolWarning.LookupMode(true);
        if ACTION::Yes = PmtTolWarning.RunModal() then begin
            PmtTolWarning.GetValues(ActionType);
            if ActionType = 2 then
                Amount := 0;
        end else
            exit(false);
        exit(true);
    end;

    local procedure GetAccountName(AccountType: Enum "Payment Tolerance Account Type"; AccountNo: Code[20]): Text
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        Result: Text;
    begin
        case AccountType of
            AccountType::Customer:
                if Customer.Get(AccountNo) then
                    exit(Customer.Name);
            AccountType::Vendor:
                if Vendor.Get(AccountNo) then
                    exit(Vendor.Name);
            else begin
                exit(Result);
            end;
        end;
    end;

    local procedure PutCustPmtTolAmount(CustledgEntry: Record "Cust. Ledger Entry"; Amount: Decimal; AppliedAmount: Decimal; CustEntryApplID: Code[50])
    var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        AppliedCustLedgerEntry2: Record "Cust. Ledger Entry";
        Currency: Record Currency;
        Number: Integer;
        AcceptedTolAmount: Decimal;
        AcceptedEntryTolAmount: Decimal;
        TotalAmount: Decimal;
    begin
        AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
        AppliedCustLedgEntry.SetRange("Customer No.", CustledgEntry."Customer No.");
        AppliedCustLedgEntry.SetRange(Open, true);
        AppliedCustLedgEntry.SetFilter("Max. Payment Tolerance", '<>%1', 0);

        if CustledgEntry."Applies-to Doc. No." <> '' then
            AppliedCustLedgEntry.SetRange("Document No.", CustledgEntry."Applies-to Doc. No.")
        else
            AppliedCustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);

        if CustledgEntry."Document Type" = CustledgEntry."Document Type"::Payment then
            AppliedCustLedgEntry.SetRange(Positive, true)
        else
            AppliedCustLedgEntry.SetRange(Positive, false);

        AppliedCustLedgEntry.SetLoadFields("Currency Code");
        if AppliedCustLedgEntry.FindSet(false, false) then
            repeat
                AppliedCustLedgEntry.CalcFields(Amount);
                if CustledgEntry."Currency Code" <> AppliedCustLedgEntry."Currency Code" then
                    AppliedCustLedgEntry.Amount :=
                      CurrExchRate.ExchangeAmount(
                        AppliedCustLedgEntry.Amount,
                        AppliedCustLedgEntry."Currency Code",
                        CustledgEntry."Currency Code", CustledgEntry."Posting Date");
                TotalAmount := TotalAmount + AppliedCustLedgEntry.Amount;
            until AppliedCustLedgEntry.Next() = 0;

        AppliedCustLedgEntry.LockTable();
        AppliedCustLedgEntry.SetLoadFields();

        AcceptedTolAmount := Amount + AppliedAmount;
        Number := AppliedCustLedgEntry.Count();

        if AppliedCustLedgEntry.FindSet(true, false) then
            repeat
                AppliedCustLedgEntry.CalcFields("Remaining Amount");
                AppliedCustLedgerEntry2 := AppliedCustLedgEntry;
                if AppliedCustLedgEntry."Currency Code" = '' then begin
                    Currency.Init();
                    Currency.Code := '';
                    Currency.InitRoundingPrecision();
                end else
                    if AppliedCustLedgEntry."Currency Code" <> Currency.Code then
                        Currency.Get(AppliedCustLedgEntry."Currency Code");
                if Number <> 1 then begin
                    AppliedCustLedgEntry.CalcFields(Amount);
                    if CustledgEntry."Currency Code" <> AppliedCustLedgEntry."Currency Code" then
                        AppliedCustLedgEntry.Amount :=
                          CurrExchRate.ExchangeAmount(
                            AppliedCustLedgEntry.Amount,
                            AppliedCustLedgEntry."Currency Code",
                            CustledgEntry."Currency Code", CustledgEntry."Posting Date");
                    AcceptedEntryTolAmount := Round((AppliedCustLedgEntry.Amount / TotalAmount) * AcceptedTolAmount);
                    AcceptedEntryTolAmount := GetMinTolAmountByAbsValue(AcceptedEntryTolAmount, AppliedCustLedgEntry."Max. Payment Tolerance");
                    TotalAmount := TotalAmount - AppliedCustLedgEntry.Amount;
                    AcceptedTolAmount := AcceptedTolAmount - AcceptedEntryTolAmount;
                    AppliedCustLedgEntry."Accepted Payment Tolerance" := AcceptedEntryTolAmount;
                end else begin
                    AcceptedEntryTolAmount := AcceptedTolAmount;
                    AppliedCustLedgEntry."Accepted Payment Tolerance" := AcceptedEntryTolAmount;
                end;
                AppliedCustLedgEntry."Max. Payment Tolerance" := AppliedCustLedgerEntry2."Max. Payment Tolerance";
                AppliedCustLedgEntry."Amount to Apply" := AppliedCustLedgerEntry2."Remaining Amount";
                AppliedCustLedgEntry.Modify();
                Number := Number - 1;
            until AppliedCustLedgEntry.Next() = 0;

        //if not SuppressCommit then
        Commit();
    end;

    local procedure GetMinTolAmountByAbsValue(ExpectedEntryTolAmount: Decimal; MaxPmtTolAmount: Decimal) AcceptedEntryTolAmount: Decimal
    var
        Math: Codeunit Math;
        Sign: Integer;
    begin
        if ExpectedEntryTolAmount = 0 then
            Sign := 1
        else
            Sign := ExpectedEntryTolAmount / Abs(ExpectedEntryTolAmount);

        AcceptedEntryTolAmount := Sign * Math.Min(Abs(ExpectedEntryTolAmount), Abs(MaxPmtTolAmount));
    end;

    local procedure PutVendPmtTolAmount(VendLedgEntry: Record "Vendor Ledger Entry"; Amount: Decimal; AppliedAmount: Decimal; VendEntryApplID: Code[50])
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        AppliedVendorLedgerEntry2: Record "Vendor Ledger Entry";
        Currency: Record Currency;
        Number: Integer;
        AcceptedTolAmount: Decimal;
        AcceptedEntryTolAmount: Decimal;
        TotalAmount: Decimal;
    begin
        AppliedVendLedgEntry.SetCurrentKey("Vendor No.", Open, Positive);
        AppliedVendLedgEntry.SetRange("Vendor No.", VendLedgEntry."Vendor No.");
        AppliedVendLedgEntry.SetRange(Open, true);
        AppliedVendLedgEntry.SetFilter("Max. Payment Tolerance", '<>%1', 0);

        if VendLedgEntry."Applies-to Doc. No." <> '' then
            AppliedVendLedgEntry.SetRange("Document No.", VendLedgEntry."Applies-to Doc. No.")
        else
            AppliedVendLedgEntry.SetRange("Applies-to ID", VendEntryApplID);

        if VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Payment then
            AppliedVendLedgEntry.SetRange(Positive, false)
        else
            AppliedVendLedgEntry.SetRange(Positive, true);

        AppliedVendLedgEntry.SetLoadFields("Currency Code");
        if AppliedVendLedgEntry.FindSet(false, false) then
            repeat
                AppliedVendLedgEntry.CalcFields(Amount);
                if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then
                    AppliedVendLedgEntry.Amount :=
                      CurrExchRate.ExchangeAmount(
                        AppliedVendLedgEntry.Amount,
                        AppliedVendLedgEntry."Currency Code",
                        VendLedgEntry."Currency Code", VendLedgEntry."Posting Date");
                TotalAmount := TotalAmount + AppliedVendLedgEntry.Amount;
            until AppliedVendLedgEntry.Next() = 0;

        AppliedVendLedgEntry.LockTable();
        AppliedVendLedgEntry.SetLoadFields();

        AcceptedTolAmount := Amount + AppliedAmount;
        Number := AppliedVendLedgEntry.Count();

        if AppliedVendLedgEntry.FindSet(true, false) then
            repeat
                AppliedVendLedgEntry.CalcFields("Remaining Amount");
                AppliedVendorLedgerEntry2 := AppliedVendLedgEntry;
                if AppliedVendLedgEntry."Currency Code" = '' then begin
                    Currency.Init();
                    Currency.Code := '';
                    Currency.InitRoundingPrecision();
                end else
                    if AppliedVendLedgEntry."Currency Code" <> Currency.Code then
                        Currency.Get(AppliedVendLedgEntry."Currency Code");
                if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then
                    AppliedVendLedgEntry."Max. Payment Tolerance" :=
                      CurrExchRate.ExchangeAmount(
                        AppliedVendLedgEntry."Max. Payment Tolerance",
                        AppliedVendLedgEntry."Currency Code",
                        VendLedgEntry."Currency Code", VendLedgEntry."Posting Date");
                if Number <> 1 then begin
                    AppliedVendLedgEntry.CalcFields(Amount);
                    if VendLedgEntry."Currency Code" <> AppliedVendLedgEntry."Currency Code" then
                        AppliedVendLedgEntry.Amount :=
                          CurrExchRate.ExchangeAmount(
                            AppliedVendLedgEntry.Amount,
                            AppliedVendLedgEntry."Currency Code",
                            VendLedgEntry."Currency Code", VendLedgEntry."Posting Date");
                    AcceptedEntryTolAmount := Round((AppliedVendLedgEntry.Amount / TotalAmount) * AcceptedTolAmount);
                    AcceptedEntryTolAmount := GetMinTolAmountByAbsValue(AcceptedEntryTolAmount, AppliedVendLedgEntry."Max. Payment Tolerance");
                    TotalAmount := TotalAmount - AppliedVendLedgEntry.Amount;
                    AcceptedTolAmount := AcceptedTolAmount - AcceptedEntryTolAmount;
                    AppliedVendLedgEntry."Accepted Payment Tolerance" := AcceptedEntryTolAmount;
                end else begin
                    AcceptedEntryTolAmount := AcceptedTolAmount;
                    AppliedVendLedgEntry."Accepted Payment Tolerance" := AcceptedEntryTolAmount;
                end;
                AppliedVendLedgEntry."Max. Payment Tolerance" := AppliedVendorLedgerEntry2."Max. Payment Tolerance";
                AppliedVendLedgEntry."Amount to Apply" := AppliedVendorLedgerEntry2."Remaining Amount";
                AppliedVendLedgEntry.Modify();
                Number := Number - 1;
            until AppliedVendLedgEntry.Next() = 0;

        // if not SuppressCommit then
        Commit();
    end;

    local procedure GetVendApplicationRoundingPrecisionForAppliesToID(var AppliedVendLedgEntry: Record "Vendor Ledger Entry"; var ApplnRoundingPrecision: Decimal; var AmountRoundingPrecision: Decimal; var ApplnInMultiCurrency: Boolean; ApplnCurrencyCode: Code[20])
    begin
        AppliedVendLedgEntry.SetFilter("Currency Code", '<>%1', ApplnCurrencyCode);
        ApplnInMultiCurrency := not AppliedVendLedgEntry.IsEmpty();
        AppliedVendLedgEntry.SetRange("Currency Code");

        GetAmountRoundingPrecision(ApplnRoundingPrecision, AmountRoundingPrecision, ApplnInMultiCurrency, ApplnCurrencyCode);
    end;

    procedure GetAmountRoundingPrecision(var ApplnRoundingPrecision: Decimal; var AmountRoundingPrecision: Decimal; ApplnInMultiCurrency: Boolean; ApplnCurrencyCode: Code[20])
    var
        Currency: Record Currency;
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init();
            Currency.Code := '';
            Currency.InitRoundingPrecision();
        end else begin
            if ApplnInMultiCurrency then
                Currency.Get(ApplnCurrencyCode)
            else
                Currency.Init();
        end;
        ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        PaymentLine: Record "WDC-ED Payment Line" temporary;
        Customer: Record Customer;
        Vendor: Record Vendor;
        NewCustLedgEntry: Record "Cust. Ledger Entry";
        NewVendLedgEntry: Record "Vendor Ledger Entry";
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        AmounttoApply: Decimal;
        PmtDiscAmount: Decimal;
        MaxPmtTolAmount: Decimal;
        GenJnlLineApplID: Code[50];
        RemainingAmountTest: Boolean;
        ApplnRoundingPrecision: Decimal;
}
