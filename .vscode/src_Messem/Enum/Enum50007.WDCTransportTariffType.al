namespace MESSEM.MESSEM;

enum 50007 "WDC Transport Tariff Type"
{

    Extensible = true;


    value(0; Customer)
    {
        CaptionML = ENU = 'Customer', FRA = 'Client';
    }
    value(1; Vendor)
    {
        CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
    }

}
