namespace MESSEM.MESSEM;

enum 50004 "WDC Label Type"
{
    Extensible = true;
    CaptionML = ENU = 'Label Type', FRA = 'Type d''étiquette';

    value(0; Standard)
    {
        CaptionML = ENU = 'Standard', FRA = 'Standard';
    }
    value(1; FDA)
    {
        CaptionML = ENU = 'FDA', FRA = 'Standard Bio FDA';
    }
    value(2; EU)
    {
        CaptionML = ENU = 'EU', FRA = 'Standard bio EUR';
    }
    value(3; Special)
    {
        CaptionML = ENU = 'Special', FRA = 'Spécial';
    }
    value(4; "Standard + Special")
    {
        CaptionML = ENU = 'Standard + Special', FRA = 'Standard + Spécial';
    }
}
