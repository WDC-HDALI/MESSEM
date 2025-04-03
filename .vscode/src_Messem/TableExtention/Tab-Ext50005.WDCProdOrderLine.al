tableextension 50005 "WDC Prod. Order Line " extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            CaptionML = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            DataClassification = ToBeClassified;
        }
        field(50001; "Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                VALIDATE(Rec."Total Net Weight", Quantity * "Net Weight");
            end;
        }
        field(50002; "Total Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Total Net Weight', FRA = 'Total poids net';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Sous Traitance"; Boolean)
        {
            CaptionML = ENU = 'Sous Traitance', FRA = 'Incrément suivant';
            FieldClass = Normal;
            Editable = false;
        }
    }
}
