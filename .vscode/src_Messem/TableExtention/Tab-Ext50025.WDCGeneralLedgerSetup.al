namespace MessemMA.MessemMA;

using Microsoft.Finance.GeneralLedger.Setup;

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
    }
}
