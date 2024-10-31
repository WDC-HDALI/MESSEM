namespace MessemMA.MessemMA;

enum 50002 "WDC Packaging Type Filter"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Customer)
    {
        CaptionML = ENU = 'Customer', FRA = 'Client';
    }
    value(2; Vendor)
    {
        CaptionML = ENU = 'Vendor', FRA = 'Fournisseur';
    }
    value(3; Item)
    {
        CaptionML = ENU = 'Item', FRA = 'Article';
    }
}
