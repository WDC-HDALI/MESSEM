tableextension 50508 "WDC-QA Warehouse Shipment Line" extends "Warehouse Shipment Line"
{
    fields
    {
        field(50500; "QC Status"; Enum "WDC-QA QC Status")
        {
            CaptionML = ENU = 'QC Status', FRA = 'Statut CQ';
            Editable = false;
        }
    }
}
