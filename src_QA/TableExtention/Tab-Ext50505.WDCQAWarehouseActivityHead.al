tableextension 50505 "WDC-QA Warehouse Activity Head" extends "Warehouse Activity Header"
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
