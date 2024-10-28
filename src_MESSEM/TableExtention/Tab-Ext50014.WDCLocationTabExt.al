tableextension 50014 "WDC Location TabExt" extends Location
{
    fields
    {
        field(50000; "Packaging ReceiveShip Bin Code"; Code[20])
        {
            CaptionML = ENU = 'Packaging Receive/Shipment Bin Code', FRA = 'Emplacement réception/expédition d''emballage';
            DataClassification = ToBeClassified;
            TableRelation = Bin.Code WHERE("Code" = FIELD("Code"));

        }
    }
}
