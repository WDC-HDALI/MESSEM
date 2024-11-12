report 50004 "WDC Purchase Rebate Entries"
{

    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/SalesPurchaseRebateEntries.rdlc';
    CaptionML = ENU = 'Purchase Rebate Entries', FRA = 'Ecritures bonus achat';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Rebate Entry"; "WDC Rebate Entry")
        {
            DataItemTableView = SORTING("Buy-from No.", "Rebate Code", "Rebate Document Type", "Posting Date");
            RequestFilterFields = "Buy-from No.", "Rebate Code";
            column(TODAY; TODAY)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Rebate_Entry__Sell_to_Buy_from_No__; "Buy-from No.")
            {
            }
            column(Sell_To_Buy_FromName_; "Sell-To/Buy-FromName")
            {
            }
            column(Sell_To_Buy_FromNoTxt_; "Sell-To/Buy-FromNoTxt")
            {
            }
            column(RebateCode_Description; RebateCode.Description)
            {
            }
            column(Rebate_Entry__Rebate_Code_; "Rebate Code")
            {
            }
            column(AccrualAmount; AccrualAmount)
            {
            }
            column(PaymentAmount____1; PaymentAmount * -1)
            {
            }
            column(CorrectionAmount; CorrectionAmount)
            {
            }
            column(RebatePayment; RebatePayment)
            {
            }
            column(RebateCode__Starting_Date_; RebateCode."Starting Date")
            {
            }
            column(RebateCode__Ending_Date_; RebateCode."Ending Date")
            {
            }
            column(Rebate_Difference__LCY______1; "Rebate Difference (LCY)" * -1)
            {
            }
            column(AccrualAmount_Control1100481012; AccrualAmount)
            {
            }
            column(PaymentAmount____1_Control1100481015; PaymentAmount * -1)
            {
            }
            column(CorrectionAmount_Control1100481028; CorrectionAmount)
            {
            }
            column(Rebate_Difference__LCY______1_Control1000000002; "Rebate Difference (LCY)" * -1)
            {
            }
            column(TotalRebatePayment; TotalRebatePayment)
            {
            }
            column(Rebate_Entry_Accrual_and_PaymentsCaption; Rebate_Entry_Accrual_and_PaymentsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Rebate_CodeCaption; Rebate_CodeCaptionLbl)
            {
            }
            column(Accrual_Amount__LCY_Caption; Accrual_Amount__LCY_CaptionLbl)
            {
            }
            column(Correction_Amount__LCY_Caption; Correction_Amount__LCY_CaptionLbl)
            {
            }
            column(Starting_DateCaption; Starting_DateCaptionLbl)
            {
            }
            column(Ending_DateCaption; Ending_DateCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Rebate_Amount__LCY_Caption; Rebate_Amount__LCY_CaptionLbl)
            {
            }
            column(Payment__Rebate_scale___LCY_Caption; Payment__Rebate_scale___LCY_CaptionLbl)
            {
            }
            column(Rebate_Difference__LCY_Caption; Rebate_Difference__LCY_CaptionLbl)
            {
            }
            column(Rebate_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PostingType := FORMAT('Purchase');

                "Sell-To/Buy-FromName" := '';
                "Sell-To/Buy-FromNoTxt" := '';
                "Sell-To/Buy-FromNoTxt" := Text002;
                IF NOT RebateCode.GET("Rebate Code") THEN
                    RebateCode.INIT;
                IF Vendor.GET("Buy-from No.") THEN
                    "Sell-To/Buy-FromName" := Vendor.Name;


                AccrualAmount := 0;
                PaymentAmount := 0;
                CorrectionAmount := 0;
                CASE "Rebate Document Type" OF
                    "Rebate Document Type"::Accrual:
                        AccrualAmount := AccrualAmount + "Accrual Amount (LCY)";
                    "Rebate Document Type"::Payment:
                        PaymentAmount := PaymentAmount + "Rebate Amount (LCY)";
                    "Rebate Document Type"::Correction:
                        CorrectionAmount := CorrectionAmount + ("Correction Amount (LCY)" * -1);
                END;

                // SI-44258-V6M3
                IF "Sell-To/Buy-FromNo" <> "Buy-from No." THEN
                    TotalRebatePayment := 0;
                "Sell-To/Buy-FromNo" := "Buy-from No.";

                IF RebCode <> "Rebate Code" THEN BEGIN
                    RebatePayment := 0;
                    RebatePayment := 0;
                    RebateValue := 0;
                    MinimumQuantity := 0;

                    RebateEntry.SETRANGE("Buy-from No.", "Buy-from No.");
                    RebateEntry.SETRANGE("Rebate Code", "Rebate Code");
                    RebateEntry.SETFILTER(Open, '%1', TRUE);
                    IF RebateEntry.FINDSET THEN
                        REPEAT
                            RebateCode.GET(RebateEntry."Rebate Code");
                            RebateScale.SETRANGE(Code, RebateEntry."Rebate Code");
                            IF RebateScale.FINDSET THEN BEGIN
                                REPEAT

                                    IF RebateCode."Currency Code" = RebateEntry."Currency Code" THEN BEGIN
                                        IF (RebateScale."Minimum Quantity" <> 0) AND
                                           (RebateScale."Minimum Quantity" <= ABS(RebateEntry."Base Quantity")) AND
                                           (RebateScale."Minimum Quantity" > MinimumQuantity) AND
                                           (RebateScale."Rebate Value" > RebateValue)
                                        THEN BEGIN
                                            RebateValue := RebateScale."Rebate Value";
                                            MinimumQuantity := RebateScale."Minimum Quantity";
                                        END;

                                        IF (RebateScale."Minimum Amount" <> 0) AND
                                           (RebateScale."Minimum Amount" <= ABS(RebateEntry."Base Amount")) AND
                                           (RebateScale."Minimum Amount" > MinimumAmount) AND
                                           (RebateScale."Rebate Value" > RebateValue)
                                        THEN BEGIN
                                            RebateValue := RebateScale."Rebate Value";
                                            MinimumQuantity := RebateScale."Minimum Quantity";
                                        END;
                                    END;

                                UNTIL RebateScale.NEXT <= 0;

                                RebatePayment := RebateEntry."Base Quantity" * RebateValue;
                            END ELSE BEGIN
                                IF RebateEntry."Currency Code" <> '' THEN BEGIN
                                    Currency.GET(RebateEntry."Currency Code");
                                    Currency.TESTFIELD("Amount Rounding Precision");
                                    RebatePayment := ROUND(
                                      CurrencyExchangeRate.ExchangeAmtLCYToFCY(PostingDate, RebateEntry."Currency Code",
                                      RebateEntry."Accrual Amount (LCY)",
                                      CurrencyExchangeRate.ExchangeRate(PostingDate, RebateEntry."Currency Code")), Currency."Amount Rounding Precision");
                                END ELSE
                                    RebatePayment := RebatePayment + RebateEntry."Accrual Amount (LCY)";
                            END;
                        UNTIL RebateEntry.NEXT = 0;

                    IF RebatePayment > 0 THEN
                        RebatePayment := 0;

                    TotalRebatePayment := TotalRebatePayment + RebatePayment;
                END;
                RebCode := "Rebate Code";
                //
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Rebate Code");

                CurrReport.CREATETOTALS(AccrualAmount, PaymentAmount, CorrectionAmount, RebatePayment);
                PostingType := '';
            end;
        }
    }

    trigger OnInitReport()
    begin
        PostingDate := WORKDATE;
    end;

    var
        RebateCode: Record "WDC Rebate Code";
        RebateScale: Record "WDC Rebate Scale";
        Currency: Record 4;
        CurrencyExchangeRate: Record 330;
        Vendor: Record 23;
        "Sell-To/Buy-FromName": Text[50];
        AccrualAmount: Decimal;
        PaymentAmount: Decimal;
        CorrectionAmount: Decimal;
        MinimumQuantity: Decimal;
        RebateValue: Decimal;
        MinimumAmount: Decimal;
        RebatePayment: Decimal;
        TotalRebatePayment: Decimal;
        PostingDate: Date;
        PostingType: Text[30];
        LastFieldNo: Integer;
        RebateEntry: Record "WDC Rebate Entry";
        Text002: Label 'Buy-from No.';
        "Sell-To/Buy-FromNoTxt": Text[30];
        Rebate_Entry_Accrual_and_PaymentsCaptionLbl: Label 'Rebate Entry Accrual and Payments';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Rebate_CodeCaptionLbl: Label 'Rebate Code';
        Accrual_Amount__LCY_CaptionLbl: Label 'Accrual Amount (LCY)';
        Correction_Amount__LCY_CaptionLbl: Label 'Correction Amount (LCY)';
        Starting_DateCaptionLbl: Label 'Starting Date';
        Ending_DateCaptionLbl: Label 'Ending Date';
        DescriptionCaptionLbl: Label 'Description';
        Rebate_Amount__LCY_CaptionLbl: Label 'Rebate Amount (LCY)';
        Payment__Rebate_scale___LCY_CaptionLbl: Label 'Payment (Rebate scale) (LCY)';
        Rebate_Difference__LCY_CaptionLbl: Label 'Rebate Difference (LCY)';
        "Sell-To/Buy-FromNo": Code[20];
        RebCode: Code[20];
}

