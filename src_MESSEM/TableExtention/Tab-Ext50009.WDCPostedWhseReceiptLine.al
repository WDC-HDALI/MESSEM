tableextension 50009 "WDC Posted Whse. Receipt Line " extends "Posted Whse. Receipt Line"
{
    fields
    {
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            Caption = 'Qty. per Shipment Unit';
            DataClassification = ToBeClassified;
        }
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
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            Caption = 'Qty. per Shipment Container';
            DataClassification = ToBeClassified;
        }
    }
}
