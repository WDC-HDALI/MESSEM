tableextension 50506 "WDC-QA Warehouse Activity Line" extends "Warehouse Activity Line"
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
