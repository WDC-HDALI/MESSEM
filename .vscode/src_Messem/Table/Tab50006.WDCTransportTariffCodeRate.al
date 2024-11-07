table 50006 "WDC Transport Tariff Code Rate"
{
    Caption = 'Transport Tariff Code Rate';
    LookupPageID = "WDC Transp. Tariff Code Rates";

    fields
    {
        field(1; Type; Enum "WDC Transport Tariff Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = IF (Type = CONST("WDC Transport Tariff Type"::Customer)) Customer
            ELSE IF (Type = CONST("WDC Transport Tariff Type"::Vendor)) Vendor WHERE(Transporter = CONST(true));
        }
        field(3; "Transport Tariff Code"; Code[20])
        {
            CaptionML = ENU = 'Transport Tariff Code', FRA = 'Code tarif transport';
            ;
            NotBlank = true;
            TableRelation = "WDC Transport Tariff Code";
        }
        field(4; "Transport Rate per"; Enum "WDC Transport Rate per")
        {
            CaptionML = ENU = 'Transport Rate per', FRA = 'Tarif transport par';
            trigger OnValidate()
            begin
                IF ("Transport Rate per" <> xRec."Transport Rate per") THEN BEGIN

                    IF "Transport Rate per" <> "Transport Rate per"::"Shipment Container" THEN
                        "Shipment Container" := '';
                    IF "Transport Rate per" = "Transport Rate per"::Route THEN
                        "Minimum Quantity" := 1
                    ELSE
                        "Stop Rate" := 0;

                END;
            end;
        }
        field(5; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            ;
            TableRelation = IF ("Transport Rate per" = CONST("Shipment Container Group")) "WDC Packaging Group" WHERE(Type = CONST("WDC Packaging Type"::"Shipment Container"))
            ELSE IF ("Transport Rate per" = CONST("WDC Packaging Type"::"Shipment Container")) "WDC Packaging" WHERE(Type = CONST("WDC Packaging Type"::"Shipment Container"));

            trigger OnValidate()
            begin
                IF NOT ("Transport Rate per" IN ["Transport Rate per"::"Shipment Container",
                                                 "Transport Rate per"::"Shipment Container Group"]) THEN
                    FIELDERROR("Transport Rate per");
                //
                TESTFIELD("Shipment Container");
            end;
        }
        field(6; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                IF "Transport Rate per" = "Transport Rate per"::Route THEN
                    TESTFIELD("Minimum Quantity", 1);
            end;
        }
        field(7; "Transport Rate"; Decimal)
        {
            Caption = 'Transport Rate';
            DecimalPlaces = 2 : 2;
        }
        field(8; "Stop Rate"; Decimal)
        {
            Caption = 'Stop Rate';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            begin
                TESTFIELD("Transport Rate per", "Transport Rate per"::Route);
            end;
        }
        field(9; "Transport Rate Excl. Rise"; Decimal)
        {
            Caption = 'Transport Rate Excl. Rise';
            DecimalPlaces = 2 : 2;

            trigger OnValidate()
            var
                Customer: Record 18;
                Vendor: Record 23;
            begin

            end;
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Transport Tariff Code", "Transport Rate per", "Shipment Container", "Minimum Quantity")
        {
            Clustered = true;
        }
    }



}

