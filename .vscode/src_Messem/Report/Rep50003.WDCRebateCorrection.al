report 50003 "WDC Rebate Correction"
{
    DefaultLayout = RDLC;
    CaptionML = ENU = 'Rebate Correction', FRA = 'Correction bonus';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Rebate Entry"; "WDC Rebate Entry")
        {
            DataItemTableView = SORTING("Buy-from No.", "Rebate Code", Open, "Correction Posted")
                                WHERE("Rebate Document Type" = CONST(Accrual),
                                      "Correction Posted" = CONST(false));
            RequestFilterFields = "Buy-from No.", "Bill-to/Pay-to No.", "Rebate Code";

            trigger OnAfterGetRecord()
            begin
                IF ("Rebate Code" <> PreviousRebateCode) OR
                   ("Buy-from No." <> PreviousSelltoBuyFromNo) OR
                   FirstRecord
                THEN BEGIN
                    FirstRecord := FALSE;
                    PreviousRebateCode := "Rebate Code";
                    PreviousSelltoBuyFromNo := "Buy-from No.";
                    TempRebateEntry.INIT;
                    TempRebateEntry := "Rebate Entry";
                    TempRebateEntry.INSERT;
                END ELSE BEGIN
                    TempRebateEntry."Rebate Amount (LCY)" := TempRebateEntry."Rebate Amount (LCY)" + "Rebate Amount (LCY)";
                    TempRebateEntry."Accrual Amount (LCY)" := TempRebateEntry."Accrual Amount (LCY)" + "Accrual Amount (LCY)";
                    TempRebateEntry.MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                CreateGenJnlLine;
            end;

            trigger OnPreDataItem()
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text000);
                IF CorrAccountNo = '' THEN
                    ERROR(Text001);

                SETFILTER("Ending Date", '<%1', WORKDATE());
                //IF NOT IncludeOpenRebateEntries THEN
                //  SETRANGE(Open,FALSE);

                IF IncludeOpenRebateEntries THEN
                    SETRANGE(Open, TRUE);

                FirstRecord := TRUE;
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
                        CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
                        ApplicationArea = all;
                    }
                    field(CorrAccountNo; CorrAccountNo)
                    {
                        CaptionML = ENU = 'Corr. Account No.', FRA = 'N° compte Corr.';
                        ApplicationArea = all;
                        TableRelation = "G/L Account" WHERE("Rebate G/L Account" = CONST(true));
                    }
                    field(IncludeOpenRebateEntries; IncludeOpenRebateEntries)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Include Open Rebate Entries', FRA = 'Ecritures bonus ouvertes inclus';
                    }
                }
            }
        }

    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        GLSetup.GET;
        GLSetup.TESTFIELD("Rebate Gen. Jnl. Templ.");
        GLSetup.TESTFIELD("Rebate Gen. Jnl. Batch");
        GLSetup.TESTFIELD("Rebate Corr. Account No.");
        GenJournalTemplate.GET(GLSetup."Rebate Gen. Jnl. Templ.");
        GenJournalBatch.GET(GLSetup."Rebate Gen. Jnl. Templ.", GLSetup."Rebate Gen. Jnl. Batch");
        GenJournalBatch.TESTFIELD("No. Series");
        PostingDate := WORKDATE;
        CorrAccountNo := GLSetup."Rebate Corr. Account No.";

    end;

    var
        PostingDate: Date;
        Text000: Label 'Posting Date not valid.';
        Text001: Label 'Bal. Account No. not valid.';
        GLSetup: Record 98;
        GenJournalTemplate: Record 80;
        GenJournalBatch: Record 232;
        IncludeOpenRebateEntries: Boolean;
        Text002: Label 'Succesfully added one or more Rebate corrections.';
        Text003: Label 'No Rebate corrections added.';
        Text004: Label 'Rebate Correction %1';
        TempRebateEntry: Record "WDC Rebate Entry" temporary;
        PreviousRebateCode: Code[20];
        PreviousSelltoBuyFromNo: Code[20];
        CorrAccountNo: Code[20];
        FirstRecord: Boolean;

    procedure CreateGenJnlLine()
    var
        RebateCode: Record "WDC Rebate Code";
        NoSeriesMgt: Codeunit "No. Series";
        GenJournalLine: Record 81;
        LineNumber: Integer;
        GenJnlLineDocNo: Code[20];
        RebateCorrectionAdded: Boolean;
    begin

        TempRebateEntry.SETCURRENTKEY("Buy-from No.", "Rebate Code", Open, TempRebateEntry."Correction Posted");
        IF TempRebateEntry.FINDSET THEN BEGIN
            GenJournalLine.SETRANGE("Journal Template Name", GLSetup."Rebate Gen. Jnl. Templ.");
            GenJournalLine.SETRANGE("Journal Batch Name", GLSetup."Rebate Gen. Jnl. Batch");
            IF GenJournalLine.FINDLAST THEN
                LineNumber := GenJournalLine."Line No." + 10000
            ELSE
                LineNumber := 10000;

            GenJnlLineDocNo := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", PostingDate, FALSE);
            //
            REPEAT
                IF (TempRebateEntry."Rebate Amount (LCY)" - TempRebateEntry."Accrual Amount (LCY)") <> 0 THEN BEGIN

                    CLEAR(RebateCode);

                    RebateCode.GET(TempRebateEntry."Rebate Code");

                    RebateCode.TESTFIELD("Rebate GL-Acc. No.");

                    GenJournalLine.INIT;
                    GenJournalLine.VALIDATE("Journal Template Name", GLSetup."Rebate Gen. Jnl. Templ.");
                    GenJournalLine.VALIDATE("Journal Batch Name", GLSetup."Rebate Gen. Jnl. Batch");
                    GenJournalLine."Line No." := LineNumber;
                    LineNumber := LineNumber + 10000;

                    GenJournalLine.VALIDATE("Posting Date", PostingDate);
                    GenJournalLine.VALIDATE("Document No.", GenJnlLineDocNo);
                    GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
                    GenJournalLine.VALIDATE(Amount, ABS(TempRebateEntry."Rebate Amount (LCY)" - TempRebateEntry."Accrual Amount (LCY)"));
                    IF (TempRebateEntry."Rebate Amount (LCY)" - TempRebateEntry."Accrual Amount (LCY)") > 0 THEN BEGIN
                        GenJournalLine.VALIDATE("Account No.", RebateCode."Rebate GL-Acc. No.");
                        GenJournalLine.VALIDATE("Bal. Account No.", CorrAccountNo);
                    END ELSE BEGIN
                        GenJournalLine.VALIDATE("Account No.", CorrAccountNo);
                        GenJournalLine.VALIDATE("Bal. Account No.", RebateCode."Rebate GL-Acc. No.");
                    END;
                    GenJournalLine."Rebate Correction Amount (LCY)" := TempRebateEntry."Rebate Amount (LCY)" - TempRebateEntry."Accrual Amount (LCY)";
                    GenJournalLine.VALIDATE("Sell-to/Buy-from No.", TempRebateEntry."Buy-from No.");
                    GenJournalLine."Rebate Code" := TempRebateEntry."Rebate Code";
                    GenJournalLine."Include Open Rebate Entries" := IncludeOpenRebateEntries;
                    GenJournalLine."Source Code" := GenJournalTemplate."Source Code";
                    GenJournalLine."Rebate Document Type" := GenJournalLine."Rebate Document Type"::Correction;
                    GenJournalLine.Description := STRSUBSTNO(Text004, TempRebateEntry."Rebate Code");
                    GenJournalLine.INSERT(TRUE);

                    RebateCorrectionAdded := TRUE;
                END;
            UNTIL TempRebateEntry.NEXT = 0;
        END;

        IF RebateCorrectionAdded THEN
            MESSAGE(Text002)
        ELSE
            MESSAGE(Text003);

    end;
}

