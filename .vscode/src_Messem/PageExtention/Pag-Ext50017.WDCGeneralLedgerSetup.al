namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;
using Microsoft.Finance.GeneralLedger.Setup;

pageextension 50017 "WDC General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            field("Calculation of Tax  0 to 30 D"; Rec."Calculation of Tax  0 to 30 D")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Calculation of Tax  0 to 30 D', FRA = 'Calcul taxe 0 à 30 D';
            }
            field("Calculation of Tax 31 to 60 D"; Rec."Calculation of Tax 31 to 60 D")
            {
                CaptionML = ENU = 'Calculation of Tax  0 to 60 D', FRA = 'Calcul taxe 0 à 60 D';
                ApplicationArea = all;
            }
            field("Calculation of Tax 61 to 90 D"; Rec."Calculation of Tax 61 to 90 D")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Calculation of Tax  0 to 90 D', FRA = 'Calcul taxe 0 à 90 D';
            }
            field("Calculation of Tax more 91 D"; Rec."Calculation of Tax more 91 D")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Calculation of Tax more 91 D', FRA = 'Calcul de l''impôt plus 91 D';
            }
            field("Rebate Gen. Jnl. Templ."; Rec."Rebate Gen. Jnl. Templ.")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Rebate Gen. Jnl. Templ.', FRA = 'Modèles feuille comptabilité bonus';
            }
            field("Rebate Gen. Jnl. Batch"; Rec."Rebate Gen. Jnl. Batch")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Rebate Gen. Jnl. Batch', FRA = 'Nom feuille comptabilité bonus';
            }
            field("Rebate Corr. Account No."; Rec."Rebate Corr. Account No.")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Rebate Corr. Account No.', FRA = 'N° compte bal. bonus';
            }
        }

    }
}


