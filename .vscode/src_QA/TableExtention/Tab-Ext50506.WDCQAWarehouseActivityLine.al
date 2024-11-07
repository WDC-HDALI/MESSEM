tableextension 50506 "WDC-QA Warehouse Activity Line" extends "Warehouse Activity Line"
{
    fields
    {
        field(50500; "QC Status"; Enum "WDC-QA QC Status")
        {
            CaptionML = ENU = 'QC Status', FRA = 'Statut CQ';
            Editable = false;
        }
        field(50501; "QC Registration No."; Code[20])
        {
            CaptionML = ENU = 'QC Registration No.', FRA = 'N° enregistrement CQ';
            Editable = false;
        }
    }
}
