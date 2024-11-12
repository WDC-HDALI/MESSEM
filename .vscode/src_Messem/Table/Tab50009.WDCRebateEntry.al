table 50009 "WDC Rebate Entry"
{
    CaptionML = ENU = 'Rebate Entry', FRA = 'Ecritures Bonus';
    DrillDownPageID = "WDC Rebate Entries";
    LookupPageID = "WDC Rebate Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.', FRA = 'No.Séquence';

        }
        field(2; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilistation';
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', FRA = 'No. Document';
        }
        field(4; "Document Type"; enum "Gen. Journal Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
        }
        field(5; "Rebate Code"; Code[20])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code Bonus';
            TableRelation = "WDC Rebate Code".Code;
        }
        field(6; "Rebate Document Type"; enum "WDC Rebate Doc. Type")
        {
            CaptionML = ENU = 'Rebate Document Type', FRA = 'Type document Bonus';
        }
        field(8; "Buy-from No."; Code[20])
        {
            CaptionML = ENU = 'Buy-from No.', FRA = 'N° Fournisseur';
            TableRelation = Vendor;

        }
        field(9; "Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'Base Amount', FRA = 'Montant de Base';
        }
        field(10; "Base Quantity"; Decimal)
        {
            CaptionML = ENU = 'Base Quantity', FRA = 'Qte de base';
        }
        field(11; Open; Boolean)
        {
            CaptionML = ENU = 'Open', FRA = 'Ouvert';
        }
        field(13; "Accrual Value (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Accrual Value (LCY)', FRA = 'Valeur réservation DS';
        }
        field(14; "Accrual Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Accrual Amount (LCY)', FRA = 'Montant réservation DS';
        }
        field(15; "Rebate Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Rebate Amount (LCY)', FRA = 'Montant bonus DS';
        }
        field(16; "Rebate Difference (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Rebate Difference (LCY)', FRA = 'Difference bonus DS';
        }
        field(17; "Bill-to/Pay-to No."; Code[20])
        {
            CaptionML = ENU = 'Bill-to/Pay-to No.', FRA = 'Personne à payer';
            TableRelation = Vendor;

        }
        field(19; "Currency Code"; Code[20])
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            TableRelation = Currency;
        }
        field(26; "Closed by Entry No."; Integer)
        {
            CaptionML = ENU = 'Closed by Entry No.', FRA = 'N° séquence lettrage final';
        }
        field(27; "Correction Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Correction Amount (LCY)', FRA = 'Montant correction (DS)';
        }
        field(28; "Correction Posted"; Boolean)
        {
            CaptionML = ENU = 'Correction Posted', FRA = 'Correction effectuée';
        }
        field(29; "Correction Posted by Entry No."; Integer)
        {
            CaptionML = ENU = 'Correction Posted by Entry No.', FRA = 'Correction effectuée par N° séquence';
        }
        field(30; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        field(31; "Ending Date"; Date)
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        field(32; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            TableRelation = Vendor;
        }
        field(33; "External Document No."; Code[20])
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        field(34; "Document Line No."; Integer)
        {
            CaptionML = ENU = 'Document Line No.', FRA = 'N° ligne Document';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Buy-from No.", "Rebate Code", Open, "Correction Posted")
        {
        }
        key(Key3; "Vendor No.", "Rebate Code", "Starting Date")
        {
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
        key(Key5; "Rebate Code", "Posting Date")
        {
        }
        key(Key6; "Buy-from No.", "Rebate Code", "Rebate Document Type", "Posting Date")
        {
        }
        key(Key7; "Rebate Code", "Posting Date", Open)
        {
        }
    }


}

