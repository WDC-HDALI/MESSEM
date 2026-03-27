namespace MESSEM.MESSEM;

enum 50014 "WDC ProdOrderDetailLineSource"
{
    Extensible = true;

    value(0; "Production Bom")
    {
        Captionml = ENU = 'Production Bom', FRA = 'Composants';
    }
    value(1; "Routing")
    {
        Captionml = ENU = 'Routing', FRA = 'Gamme';
    }
    value(3; "Item")
    {
        Captionml = ENU = 'Item', FRA = 'Article';
    }
}

