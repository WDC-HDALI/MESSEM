tableextension 50406 "WDC-TRS Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50400; "Transport Document"; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Commande Transport', FRA = 'Transport order';
        }
        field(50401; "Transport Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Transport order No.', FRA = 'N° Commande Transport';
            TableRelation = "WDC-TRS Trasport Order Header" where(Status = filter(Released));
            Editable = false;
        }
        field(50402; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
    }
}
