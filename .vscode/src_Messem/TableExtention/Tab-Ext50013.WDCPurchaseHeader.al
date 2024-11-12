tableextension 50013 "WDC Purchase Header " extends "Purchase Header"
{
    fields
    {
        field(50000; "Farm"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WDC Farm".Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            CaptionML = ENU = 'Farm No.', FRA = 'N° ferme';
        }
        field(50001; "Parcel No."; TEXT[100])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';

        }


    }
}
