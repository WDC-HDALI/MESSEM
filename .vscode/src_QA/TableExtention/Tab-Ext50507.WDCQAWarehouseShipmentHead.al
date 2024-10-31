tableextension 50507 "WDC-QA Warehouse Shipment Head" extends "Warehouse Shipment Header"
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
