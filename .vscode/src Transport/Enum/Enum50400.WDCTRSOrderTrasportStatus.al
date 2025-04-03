enum 50400 "WDC-TRS Order Trasport Status"
{
    Extensible = true;
    value(0; Open)
    {
        CaptionML = ENU = 'Open', FRA = 'Open';
    }
    value(1; Released)
    {
        CaptionML = ENU = 'Released', FRA = 'Lancé';
    }
    value(2; Posted)
    {
        CaptionML = ENU = 'Posted', FRA = 'Validé';
    }
}