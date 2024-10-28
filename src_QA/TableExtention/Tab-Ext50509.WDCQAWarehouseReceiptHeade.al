tableextension 50509 "WDC-QA Warehouse Receipt Heade" extends "Warehouse Receipt Header"
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
