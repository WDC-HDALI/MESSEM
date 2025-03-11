tableextension 50401 "WDC-TRS Purchase Header " extends "Purchase Header"
{
    fields
    {
        field(50400; "Transport Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Commande Transport', FRA = 'Transport order';
        }
        field(50401; "Transport order created"; Boolean)
        {
            CaptionML = ENU = 'Transport order created', FRA = 'Ordre transport crée';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("WDC-TRS Trasport Order Header" where
                            ("Origin Order No." = field("No.")));

        }
        field(50402; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
            TableRelation = "Shipping Agent";

            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
    }
    trigger OnDelete()
    var
        lTransporOrdHeader: record "WDC-TRS Trasport Order Header";
    begin
        if rec."Transport Order" then begin
            lTransporOrdHeader.Reset();
            lTransporOrdHeader.SetRange("Purchase Order No.", "No.");
            if lTransporOrdHeader.FindFirst() then begin
                lTransporOrdHeader."Purchase Order No." := '';
                lTransporOrdHeader.Modify(true);
            end
        end;
    end;
}
