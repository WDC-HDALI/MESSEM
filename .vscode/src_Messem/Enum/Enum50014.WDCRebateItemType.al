namespace MESSEM.MESSEM;

enum 50014 "WDC Rebate Item Type"
{
    Extensible = true;

    value(0; Item)
    {
        CaptionML = ENU = 'Item', FRA = 'Article';
    }
    value(1; "Item Rebate Group")
    {
        CaptionML = ENU = 'Item rebate Group', FRA = 'Groupe bonus article';
    }
    value(2; "None")
    {
        CaptionML = ENU = 'None', FRA = 'None';
    }
}
