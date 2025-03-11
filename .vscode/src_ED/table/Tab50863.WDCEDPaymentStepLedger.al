table 50863 "WDC-ED Payment Step Ledger"
{
    CaptionML = ENU = 'Payment Step Ledger', FRA = 'Etape comptabilisation règlement';

    fields
    {
        field(1; "Payment Class"; Text[30])
        {
            CaptionML = ENU = 'Payment Class', FRA = 'Type de règlement';
            TableRelation = "WDC-ED Payment Class";
        }
        field(2; Line; Integer)
        {
            CaptionML = ENU = 'Line', FRA = 'Ligne';
        }
        field(3; Sign; Option)
        {
            CaptionML = ENU = 'Sign', FRA = 'Sens';
            OptionCaptionML = ENU = 'Debit,Credit', FRA = 'Débit,Crédit';
            OptionMembers = Debit,Credit;
        }
        field(4; Description; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        field(8; "Accounting Type"; Option)
        {
            CaptionML = ENU = 'Accounting Type', FRA = 'Type comptabilisation';
            OptionCaptionML = ENU = 'Payment Line Account,Associated G/L Account,Setup Account,G/L Account / Month,G/L Account / Week,Bal. Account Previous Entry,Header Payment Account',
                            FRA = 'Compte ligne paiement,Compte général associé,Compte paramétré,Compte général par mois échéance,Compte général par semaine échéance,Extourne écriture précédente,Compte en-tête';
            OptionMembers = "Payment Line Account","Associated G/L Account","Setup Account","G/L Account / Month","G/L Account / Week","Bal. Account Previous Entry","Header Payment Account";


            trigger OnValidate()
            begin
                Validate(Root);
            end;
        }
        field(9; "Account Type"; enum "Gen. Journal Account Type")
        {
            CaptionML = ENU = 'Account Type', FRA = 'Type compte';
        }
        field(10; "Account No."; Code[20])
        {
            CaptionML = ENU = 'Account No.', FRA = 'N° compte';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;
        }
        field(11; "Customer Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Customer Posting Group', FRA = 'Groupe compta. client';
            TableRelation = "Customer Posting Group";
        }
        field(12; "Vendor Posting Group"; Code[20])
        {
            CaptionML = ENU = 'Vendor Posting Group', FRA = 'Groupe compta. fournisseur';
            TableRelation = "Vendor Posting Group";
        }
        field(13; Root; Code[20])
        {
            CaptionML = ENU = 'Root', FRA = 'Racine';
        }
        field(14; "Detail Level"; Option)
        {
            CaptionML = ENU = 'Detail Level', FRA = 'Détail';
            OptionCaptionML = ENU = 'Line,Account,Due Date', FRA = 'Ligne,Compte,Date d''échéance';
            OptionMembers = Line,Account,"Due Date";
        }
        field(16; Application; Option)
        {
            CaptionML = ENU = 'Application', FRA = 'Lettrage';
            OptionCaptionML = ENU = 'None,Applied Entry,Entry Previous Step,Memorized Entry',
                              FRA = 'Aucun,Ecriture en cours,Ecriture statut précédent,Ecriture mémorisée';
            OptionMembers = "None","Applied Entry","Entry Previous Step","Memorized Entry";
        }
        field(17; "Memorize Entry"; Boolean)
        {
            CaptionML = ENU = 'Memorize Entry', FRA = 'Mémoriser écriture';
        }
        field(18; "Document Type"; Enum "Gen. Journal Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
        }
        field(19; "Document No."; Option)
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            OptionCaptionML = ENU = 'Header No.,Document ID Line', FRA = 'N° en-tête,N° document ligne';
            OptionMembers = "Header No.","Document ID Line";
        }
    }

    keys
    {
        key(Key1; "Payment Class", Line, Sign)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

