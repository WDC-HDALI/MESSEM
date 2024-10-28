tableextension 50013 "WDC Purchase Header TabExt" extends "Purchase Header"
{
    fields
    {
        field(50000; "Farm"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Farm.Code WHERE("Vendor No." = FIELD("Buy-from Vendor No."));
            CaptionML = ENU = 'Farm No.', FRA = 'Fournisseur frais généraux';
        }
        field(50001; "Parcel No."; TEXT[100])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';

        }

    }
}
