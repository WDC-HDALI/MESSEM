tableextension 50011 "WDC Sales Invoice Line " extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            Caption = 'Shipment Unit';
            DataClassification = ToBeClassified;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            Caption = 'Shipment Container';
            DataClassification = ToBeClassified;
        }
    }
}
