tableextension 50501 "WDC-QA Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(50500; "Inspection Status"; Code[20])
        {
            CaptionML = ENU = 'Inspection Status', FRA = 'Statut d''inspection';
            DataClassification = ToBeClassified;
            TableRelation = "WDC-QA Inspection Status";
            Editable = false;
        }
        field(50501; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''éxpiration';
            DataClassification = ToBeClassified;
        }
        field(50502; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date', FRA = 'Date création';
            DataClassification = ToBeClassified;
        }
        field(50503; "Buy-from Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Buy-from Vendor No.', FRA = 'N° fournisseur';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
    }
}
