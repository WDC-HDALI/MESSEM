table 50400 "WDC-TRS Transport Tarifs"
{
    CaptionML = ENU = 'Transport Rates', FRA = 'Tarifs transport';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sequence No."; Integer)
        {
            CaptionML = ENU = 'Sequence No.', FRA = 'N° Sequence';
            Editable = false;
        }
        field(2; Type; Enum "WDC-TRS Transport Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(3; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            TableRelation = IF (Type = CONST(Customer)) Customer ELSE IF (Type = CONST(Vendor)) Vendor WHERE(Transporter = CONST(false));
            trigger OnValidate()
            var
                lVendor: Record Vendor;
                lCustomer: Record Customer;
            begin
                rec.Name := '';
                if rec.Type = rec.Type::Vendor then begin
                    if lVendor.get("No.") Then
                        Rec.Name := lVendor.Name;
                end Else begin
                    if rec.Type = rec.Type::Customer then
                        if lCustomer.get("No.") Then
                            Rec.Name := lCustomer.Name;
                End;
            end;
        }
        field(4; Name; Text[100])
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
            Editable = false;
        }
        field(5; "Ship-to Code"; Code[20])
        {
            CaptionML = ENU = 'Ship-to Code', FRA = 'Code destination';
            TableRelation = IF (Type = CONST(Customer)) "Ship-to Address".Code where("Customer No." = field("No."));
            trigger OnValidate()
            var
                lShipToAdresse: Record "Ship-to Address";
            begin
                rec."Ship-to Name" := '';
                if lShipToAdresse.Get(rec."No.", rec."Ship-to Code") then
                    rec."Ship-to Name" := lShipToAdresse.name + ' ' + lShipToAdresse.Address + ' ' + lShipToAdresse."Address 2";
            end;
        }
        field(6; "Ship-to Name"; Text[500])
        {
            CaptionML = ENU = 'Ship-to Name', FRA = 'Adresse destination';
            Editable = false;
        }
        field(7; "Transport Rate"; Decimal)
        {
            CaptionML = ENU = 'Transport Tariff', FRA = 'Tarif transport';
        }
        field(8; "Currency Code"; code[20])
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            TableRelation = currency;
        }
        field(9; "Transport vendor No."; code[20])
        {
            CaptionML = ENU = 'Transport vendor No.', FRA = 'N° fournisseur transporteur';
            TableRelation = Vendor where(Transporter = const(true));
        }
        field(10; "Shipment Method code"; code[20])
        {
            CaptionML = ENU = 'Shipment Method code', FRA = 'Condition livraison';
            TableRelation = "Shipment Method";
        }
    }
    keys
    {
        key(PK; "Sequence No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        rec."Sequence No." := GetNextSequence;
    end;

    procedure GetNextSequence(): Integer
    var
        lTransportTarifs: record "WDC-TRS Transport Tarifs";
    begin
        lTransportTarifs.Reset();
        lTransportTarifs.SetCurrentKey("Sequence No.");
        if lTransportTarifs.FindLast() Then
            exit(lTransportTarifs."Sequence No." + 1);
        Exit(1)
    end;
}
