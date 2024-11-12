tableextension 50026 "WDC Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Rebate Code"; Code[10])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
            TableRelation = "WDC Rebate Code".Code;
            DataClassification = ToBeClassified;
        }
        field(50001; "Include Open Rebate Entries"; Boolean)
        {
            CaptionML = ENU = 'Include Open Rebate Entries', FRA = 'Inclus ecritures bonus ouvertes';
            DataClassification = ToBeClassified;
        }
        field(50002; "Rebate Document Type"; Enum "WDC Rebate Doc. Type")
        {
            CaptionML = ENU = 'Rebate Document Type', FRA = 'Type document bonus';
            DataClassification = ToBeClassified;
        }
        field(50003; "Rebate Correction Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Correction Amount (LCY)', FRA = 'Montant (LCY) correction ';
            DataClassification = ToBeClassified;
        }
        field(50004; PurchaseRebateSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; GenJnlRebateSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; PurchasePaymentSet; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Rebate Posted Doc Type"; Enum "Purchase Document Type")
        {
            CaptionML = ENU = 'Rebate Posted Document Type', FRA = 'Type document enreng. bonus';
            DataClassification = ToBeClassified;
        }
        field(50008; "Rebate Purchase Doc No."; code[20])
        {
            CaptionML = ENU = 'Rebate Purchase Doc No.', FRA = 'N° document achat bonus';
            DataClassification = ToBeClassified;
        }
    }
}
