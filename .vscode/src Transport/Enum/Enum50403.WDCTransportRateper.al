namespace MESSEM.MESSEM;

enum 50403 "WDC Transport Rate per"
{

    Extensible = true;


    value(0; "Shipment Container")
    {
        CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
    }
    value(1; KG)
    {
        CaptionML = ENU = 'KG', FRA = 'KG';
    }
    value(2; Route)
    {
        CaptionML = ENU = 'Route', FRA = 'Itinéraire';
    }
    value(3; "Shipment Container Group")
    {
        CaptionML = ENU = 'Shipment Container Group', FRA = 'Groupe support logistique';
    }
}
