table 50402 "WDC-TRS Trasport Order Line"
{
    CaptionMl = ENU = 'Trasport Order Line', FRA = 'Lignes ordre Transport';
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            CaptionMl = ENU = 'No. Document', FRA = 'N° Document';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            CaptionMl = ENU = 'Line No.', FRA = 'N° Ligne';
            Editable = false;
        }
        field(3; "No."; Code[20])
        {
            CaptionMl = ENU = 'No.', FRA = 'N°';
            TableRelation = Item;
            trigger OnValidate()
            var
                lItem: Record Item;
            begin
                Rec.Description := '';
                if lItem.get("No.") then
                    Rec.Description := lItem.Description;
            end;
        }
        field(4; Description; Text[100])
        {
            CaptionMl = ENU = 'Description', FRA = 'Description';
            Editable = false;
        }
        field(5; "Quantity"; Decimal)
        {
            CaptionMl = ENU = 'Quantity', FRA = 'Quantité';
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure GetNextLineDocument(pDocument: Code[20]): Integer
    var
        lTransportOrderLine: record "WDC-TRS Trasport Order Line";
    begin
        lTransportOrderLine.Reset();
        lTransportOrderLine.SetCurrentKey("Document No.", "Line No.");
        lTransportOrderLine.SetRange("Document No.", pDocument);
        if lTransportOrderLine.FindLast() Then
            exit(lTransportOrderLine."Line No." + 10000);
        Exit(10000)
    end;

}
