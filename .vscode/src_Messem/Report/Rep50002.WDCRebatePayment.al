report 50002 "WDC Rebate Payment"
{

    CaptionML = ENU = 'Rebate payment', FRA = 'Paiement bonus';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PaymentRebate.rdlc';
    dataset
    {
        dataitem("Rebate Entry"; "WDC Rebate Entry")
        {
            DataItemTableView = SORTING("Buy-from No.", "Rebate Code", Open)
                                WHERE(Open = CONST(true));
            RequestFilterFields = "Buy-from No.", "Bill-to/Pay-to No.", "Rebate Code";

            trigger OnAfterGetRecord()
            begin
                IF ("Buy-from No." <> PreviousSelltoBuyFromNo) OR
                   ("Rebate Code" <> PreviousRebateCode)
                THEN BEGIN
                    PreviousSelltoBuyFromNo := "Buy-from No.";
                    PreviousRebateCode := "Rebate Code";
                    TempRebateEntry.INIT;
                    TempRebateEntry := "Rebate Entry";
                    TempRebateEntry.INSERT;
                END ELSE BEGIN
                    TempRebateEntry."Base Amount" := TempRebateEntry."Base Amount" + "Base Amount";
                    TempRebateEntry."Base Quantity" := TempRebateEntry."Base Quantity" + "Base Quantity";
                    TempRebateEntry."Accrual Amount (LCY)" := TempRebateEntry."Accrual Amount (LCY)" + "Accrual Amount (LCY)";
                    TempRebateEntry.MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                CreateOrders;
            end;

            trigger OnPreDataItem()
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text000);
                IF DocumentDate = 0D THEN
                    ERROR(Text001);

                SETFILTER("Ending Date", '<%1', WORKDATE); //HD01 0 vérifier pour que le rapport va traiter 
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', FRA = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Document Date', FRA = 'Date document';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        PostingDate := WORKDATE;
        DocumentDate := WORKDATE;
    end;

    var
        Text000: TextConst ENU = 'Posting Date not valid.', FRA = 'Date comptabilisation n''est pas valide';
        Text001: TextConst ENU = 'Document Date not valid.', FRA = 'Date document n''est pas valide';
        Text002: TextConst ENU = 'Rebate Payment %1', FRA = 'Bonus Payment %1';
        Text003: TextConst ENU = 'No Valid Rebate Scale found for Sell-to/Buy-from No. %1, %2 Rebate Code %3.',
                           FRA = 'Pas de règle de bonus valable trouvée pour Donneur d''ordre/Preneur d''ordre n° %1, %2 Code Bonue %3.';
        Text004: TextConst ENU = 'Succesfully added one or more credit memo''s.', FRA = 'Un ou plusieurs avoirs ont bien été ajouté.';
        Text005: TextConst ENU = 'No credit memo''s added.', FRA = 'Aucune facture ajoutée';
        Text006: TextConst ENU = 'Rebate Codes with Currency Code must have a valid Rebate Scale.',
                           FRA = 'Les Codes bonus avec un code devise doivent avoir une Règle de Bonus';
        PreviousSelltoBuyFromNo: Code[20];
        PreviousRebateCode: Code[20];
        TempRebateEntry: Record "WDC Rebate Entry" temporary;
        PostingDate: Date;
        DocumentDate: Date;
        Text007: TextConst ENU = 'Succesfully added one or more credit memo''s.',
                           FRA = 'Un ou plusieurs avoirs ont bien été ajouté.';

    procedure CreateOrders()
    var
        RebateCode: Record "WDC Rebate Code";
        RebateScale: Record "WDC Rebate Scale";
        MinimumQuantity: Decimal;
        RebatePayment: Decimal;
        MinimumAmount: Decimal;
        RebateValue: Decimal;
        SalesHeader: Record 36;
        SalesLine: Record 37;
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
        LineNumber: Integer;
        CreditMemoAdded: Boolean;
        GeneralPostingSetup: Record 252;
        Item: Record 27;
    begin
        PreviousSelltoBuyFromNo := '';
        TempRebateEntry.SETCURRENTKEY("Buy-from No.", "Rebate Code", Open);
        IF TempRebateEntry.FINDSET THEN
            REPEAT
                CLEAR(RebateCode);
                CLEAR(RebateScale);
                MinimumQuantity := 0;
                RebatePayment := 0;
                MinimumAmount := 0;
                RebateValue := 0;
                IF TempRebateEntry."Buy-from No." <> PreviousSelltoBuyFromNo THEN BEGIN
                    LineNumber := 10000;
                    PreviousSelltoBuyFromNo := TempRebateEntry."Buy-from No.";
                END;
                IF LineNumber = 10000 THEN BEGIN
                    PurchaseHeader.INIT;
                    //PurchaseHeader.VALIDATE("Document Type",SalesHeader."Document Type"::"Credit Memo");//okh
                    PurchaseHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
                    PurchaseHeader."No." := '';
                    PurchaseHeader.INSERT(TRUE);

                    PurchaseHeader.VALIDATE("Posting Date", PostingDate);
                    PurchaseHeader.VALIDATE("Document Date", DocumentDate);
                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", TempRebateEntry."Buy-from No.");
                    PurchaseHeader.VALIDATE("Due Date", WORKDATE);
                    PurchaseHeader.VALIDATE("Currency Code", TempRebateEntry."Currency Code");
                    PurchaseHeader.MODIFY(TRUE);

                END;

                RebateCode.GET(TempRebateEntry."Rebate Code");
                RebateCode.TESTFIELD("Rebate GL-Acc. No.");
                PurchaseHeader.TESTFIELD("Currency Code", TempRebateEntry."Currency Code");

                RebateScale.SETRANGE(Code, TempRebateEntry."Rebate Code");
                IF RebateScale.FINDSET THEN BEGIN
                    REPEAT

                        IF RebateCode."Currency Code" = TempRebateEntry."Currency Code" THEN BEGIN
                            IF (RebateScale."Minimum Quantity" <> 0) AND
                               (RebateScale."Minimum Quantity" <= ABS(TempRebateEntry."Base Quantity")) AND
                               (RebateScale."Minimum Quantity" > MinimumQuantity) AND
                               (RebateScale."Rebate Value" > RebateValue)
                            THEN BEGIN
                                RebateValue := RebateScale."Rebate Value";
                                MinimumQuantity := RebateScale."Minimum Quantity";
                            END;

                            IF (RebateScale."Minimum Amount" <> 0) AND
                               (RebateScale."Minimum Amount" <= ABS(TempRebateEntry."Base Amount")) AND
                               (RebateScale."Minimum Amount" > MinimumAmount) AND
                               (RebateScale."Rebate Value" > RebateValue)
                            THEN BEGIN
                                RebateValue := RebateScale."Rebate Value";
                                MinimumQuantity := RebateScale."Minimum Quantity";
                            END;
                        END;

                    UNTIL RebateScale.NEXT <= 0;

                    RebatePayment := TempRebateEntry."Base Quantity" * RebateValue;
                END;

                IF RebatePayment = 0 THEN
                    ERROR(Text003, TempRebateEntry."Buy-from No.", TempRebateEntry."Rebate Code");
                //
                PurchaseLine.INIT;
                PurchaseLine.VALIDATE("System-Created Entry", TRUE);
                PurchaseLine.VALIDATE("Document Type", PurchaseLine."Document Type"::Invoice);
                PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
                PurchaseLine.VALIDATE("Line No.", LineNumber);
                LineNumber := LineNumber + 10000;
                PurchaseLine.VALIDATE("Buy-from Vendor No.", TempRebateEntry."Buy-from No.");
                PurchaseLine.VALIDATE(Type, PurchaseLine.Type::"G/L Account");
                PurchaseLine.VALIDATE("No.", RebateCode."Rebate GL-Acc. No.");
                PurchaseLine.VALIDATE("No.", RebateCode."Rebate GL-Acc. No.2");
                PurchaseLine.VALIDATE(Description, STRSUBSTNO(Text002, TempRebateEntry."Rebate Code"));
                PurchaseLine.VALIDATE(Quantity, 1);
                PurchaseLine.VALIDATE("Direct Unit Cost", RebatePayment);
                PurchaseLine.VALIDATE("Rebate Code", TempRebateEntry."Rebate Code");
                PurchaseLine.INSERT(TRUE);
                //>>HD01



                CreditMemoAdded := TRUE;
            UNTIL TempRebateEntry.NEXT = 0;

        IF CreditMemoAdded THEN
            MESSAGE(Text007)
        ELSE
            MESSAGE(Text005);

    end;
}

