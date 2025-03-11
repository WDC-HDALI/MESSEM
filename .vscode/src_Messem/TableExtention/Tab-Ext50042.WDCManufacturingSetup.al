tableextension 50042 "WDC Manufacturing Setup" extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "Colos Link"; Text[50])
        {
            CaptionML = ENU = 'Colos Link', FRA = 'Colos';
            DataClassification = ToBeClassified;
        }
        field(50001; "Trigger"; Text[50])
        {
            CaptionML = ENU = 'Trigger', FRA = 'Déclencheur';
            DataClassification = ToBeClassified;
        }
        field(50002; "Box No."; Code[10])
        {
            CaptionML = ENU = 'Box No.', FRA = 'N° carton';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin production';
            TableRelation = Location;
        }
        field(50004; "Bin Code"; Code[20])
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement production';
            TableRelation = Bin.Code;
        }
        field(50005; "Location Code Sous taitance"; Code[10])
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin sous traitance';
            TableRelation = Location;
        }
        field(50006; "Bin Code Sous Traitance"; Code[20])
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement sous traitance';
            TableRelation = Bin.Code;
        }
    }
}
