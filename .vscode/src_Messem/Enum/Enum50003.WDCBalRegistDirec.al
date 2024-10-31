namespace MESSEM.MESSEM;

enum 50003 "WDC Bal. Regist. Direc"
{
    Extensible = true;

    value(0; "-")
    {
    }
    value(1; Inbound)
    {
        CaptionML = ENU = 'Inbound', FRA = 'Entrant';
    }
    value(2; Outbound)
    {
        CaptionML = ENU = 'Outbound', FRA = 'Sortant';
    }
}
