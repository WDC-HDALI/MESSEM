table 50528 "WDC-QA Registered Inspec Chang"
{
    CaptionML = ENU = 'Registered Inspection Changes', FRA = 'Modifications inspection enregistré';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        field(2; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
            AutoIncrement = true;
        }
        field(4; "Date Of Change"; Date)
        {
            CaptionML = ENU = 'Date Of Change', FRA = 'Date modification';
        }
        field(5; "Current Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'Current Inspection Status', FRA = 'Statut d''inspection actuel';
            TableRelation = "WDC-QA Inspection Status";
        }
        field(6; "Current Expiration Date"; Date)
        {
            CaptionML = ENU = 'Current Expiration Date', FRA = 'Date d''expiration actuelle';
        }
        field(7; "Current Warranty Date"; Date)
        {
            CaptionML = ENU = 'Current Warranty Date', FRA = 'Date garantie actuelle';
        }
        field(8; "New Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'New Inspection Status', FRA = 'Statut d''inspection nouveau';
            TableRelation = "WDC-QA Inspection Status";
        }
        field(9; "New Expiration Date"; Date)
        {
            CaptionML = ENU = 'New Expiration Date', FRA = 'Nouvelle date expiration';
        }
        field(10; "New Warranty Date"; Date)
        {
            CaptionML = ENU = 'New Warranty Date', FRA = 'Nouvelle date garantie';
        }
        field(11; "Current Vendor Lot No."; Code[20])
        {
            CaptionML = ENU = 'Current Vendor Lot No.', FRA = 'N° lot fournisseur actuel';
        }
        field(12; "New Lot No."; Code[20])
        {
            CaptionML = ENU = 'New Lot No.', FRA = 'Nouveau n° lot';
        }
        field(13; "New Vendor Lot No."; Code[20])
        {
            CaptionML = ENU = 'New Vendor Lot No.', FRA = 'Nouveau N° lot fournisseur';
        }
        field(14; "Variant Code"; Code[20])
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        field(15; "Old Lot No."; Code[20])
        {
            CaptionML = ENU = 'Old Lot No.', FRA = 'Précédent N° lot';
        }
        field(16; "Delete Second Insp. Status"; Boolean)
        {
            CaptionML = ENU = 'Delete Second Insp. Status', FRA = 'Supprimer second statut d''inspection';
        }
        field(17; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
            TableRelation = "Reason Code";
        }
        field(18; "Reason No."; Integer)
        {
            CaptionML = ENU = 'Reason No.', FRA = 'N° motif';
        }
        field(19; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
            TableRelation = User."User Name";
            TestTableRelation = false;
            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //LoginMgt.LookupUserID("User ID");
            end;
        }
        field(20; "Time of Change"; Time)
        {
            CaptionML = ENU = 'Time of Change', FRA = 'Heure modification';
        }
        field(21; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            OptionMembers = " ","Reg. Header";
            OptionCaptionML = ENU = ' ,Reg. Header', FRA = ' ,En-tête enregistrement';
            Editable = false;
        }
        field(22; "Source Subtype"; Option)
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10', FRA = '0,1,2,3,4,5,6,7,8,9,10';
            Editable = false;
        }
        field(23; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF ("Source Type" = CONST("Reg. Header")) "WDC-QA Registration Header"."No." WHERE("Document Type" = FIELD("Source Subtype"));
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}
