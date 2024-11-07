tableextension 50026 "WDC Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Rebate Code"; Code[10])
        {
            Caption = 'Rebate Code';
            TableRelation = "WDC Rebate Code".Code;
            DataClassification = ToBeClassified;
        }
        field(50001; "Include Open Rebate Entries"; Boolean)
        {
            Caption = 'Include Open Rebate Entries';
            DataClassification = ToBeClassified;
        }
        field(50002; "Rebate Document Type"; Enum "WDC Rebate Doc. Type")
        {
            Caption = 'Rebate Document Type';
            DataClassification = ToBeClassified;
        }
        field(50003; "Rebate Correction Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Correction Amount (LCY)';
            DataClassification = ToBeClassified;
        }
        field(50004; "Posting Type"; Enum "WDC Rebate Posting type")
        {
            Caption = 'Posting Type';
            DataClassification = ToBeClassified;
        }

        field(50005; PurchaseRebateSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; GenJnlRebateSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; PurchasePaymentSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
