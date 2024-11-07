namespace MESSEM.MESSEM;

enum 50011 "WDC Rebate Doc. Type"
{

    Extensible = true;


    value(0; Accrual)
    {
        CaptionML = ENU = 'Accrual', FRA = 'Accroissement';
    }
    value(1; Payment)
    {
        CaptionML = ENU = 'Payment', FRA = 'Paiement';
    }
    value(2; Correction)
    {
        CaptionML = ENU = 'Correction', FRA = 'Correction';
    }

}
