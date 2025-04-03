tableextension 50026 "WDC Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Rebate Code"; Code[20])
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
        field(50009; RIB; Text[30])
        {
            CaptionML = ENU = 'RIB', FRA = 'RIB';
            DataClassification = ToBeClassified;
        }
        field(50010; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Account No.")));
            CaptionML = ENU = 'Vendor Name', FRA = 'Nom fournisseur';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Bank Name"; Text[100])
        {
            CalcFormula = Lookup("Bank Account".Name WHERE("No." = FIELD("Bal. Account No.")));
            CaptionML = ENU = 'Bank Name', FRA = 'Nom  banque';
            FieldClass = FlowField;
        }

        field(50012; "To Post"; Boolean)
        {
            CaptionML = ENU = 'To Post', FRA = 'A valider';
        }
    }
}
