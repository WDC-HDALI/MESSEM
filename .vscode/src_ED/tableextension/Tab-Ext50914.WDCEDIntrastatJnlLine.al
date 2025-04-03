tableextension 50914 "WDC-ED Intrastat Jnl. Line" extends "Intrastat Jnl. Line"
{
    fields
    {
        field(50800; "Shipment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Shipment Method Code', FRA = 'Code condition livraison';
            ObsoleteReason = 'Merge to W1';
            ObsoleteState = Pending;
            TableRelation = "Shipment Method";
            ObsoleteTag = '15.0';
        }
        field(50801; "Cust. VAT Registration No."; Text[20])
        {
            CaptionML = ENU = 'Cust. VAT Registration No.', FRA = 'N° identif intracom. client';
        }
    }

}