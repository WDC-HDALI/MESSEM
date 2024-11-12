namespace MessemMA.MessemMA;

using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;

tableextension 50025 WDCGeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        field(50000; "Calculation of Tax  0 to 30 D"; Decimal)
        {
            CaptionML = ENU = 'Calculation of Tax  0 to 30 D', FRA = 'Calcul amende entre 0 et 30 J';
            DataClassification = ToBeClassified;
        }
        field(50001; "Calculation of Tax 31 to 60 D"; Decimal)
        {
            CaptionML = ENU = 'Calculation of Tax 31 to 60 D', FRA = 'Calcul amende entre 31 et 60 J';
            DataClassification = ToBeClassified;
        }
        field(50002; "Calculation of Tax 61 to 90 D"; Decimal)
        {
            CaptionML = ENU = 'Calculation of Tax 61 to 90 D', FRA = 'Calcul amende entre 61 et 90 J';
            DataClassification = ToBeClassified;
        }
        field(50003; "Calculation of Tax more 91 D"; Decimal)
        {
            CaptionML = ENU = 'Calculation of Tax more 91 D', FRA = 'Calcul amende supérieur à 91J';
            DataClassification = ToBeClassified;
        }

        field(50004; "Rebate Gen. Jnl. Templ."; Code[20])
        {
            Caption = 'Rebate Gen. Jnl. Templ.';
            TableRelation = "Gen. Journal Template";

            trigger OnValidate()
            begin
                IF "Rebate Gen. Jnl. Templ." <> xRec."Rebate Gen. Jnl. Templ." THEN
                    "Rebate Gen. Jnl. Batch" := '';
            end;
        }
        field(50005; "Rebate Gen. Jnl. Batch"; Code[20])
        {
            Caption = 'Rebate Gen. Jnl. Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Rebate Gen. Jnl. Templ."));
        }
        field(50006; "Rebate Corr. Account No."; Code[20])
        {
            Caption = 'Rebate Corr. Account No.';
            TableRelation = "G/L Account" WHERE("Rebate G/L Account" = CONST(true));
        }
    }
}
