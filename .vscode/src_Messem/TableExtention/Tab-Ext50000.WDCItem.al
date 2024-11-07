tableextension 50000 "WDC Item" extends Item
{
    fields
    {
        field(50000; "Shipment Unit"; Code[20])
        {
            captionml = ENU = 'Shipment Unit', FRA = 'Unité d''expédition';
            TableRelation = "WDC Packaging" WHERE(type = filter("Shipment Unit"));


            trigger OnValidate()
            begin
                IF "Shipment Unit" <> xRec."Shipment Unit" THEN BEGIN
                    IF "Shipment Unit" = '' THEN BEGIN
                        VALIDATE("Qty. per Shipment Unit", 1);
                    END
                END;
            end;
        }
        field(50001; "Qty. per Shipment Unit"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Unit', FRA = 'Qté par unité d''expédition';
            DecimalPlaces = 0 : 2;
            InitValue = 1;

            trigger OnValidate()
            var

            begin
                IF "Qty. per Shipment Unit" <= 0 THEN
                    FIELDERROR("Qty. per Shipment Unit", TextSI000);

                IF "Qty. per Shipment Unit" <> 1 THEN
                    TESTFIELD("Shipment Unit");

                "Qty. per Shipment Container" := "Qty. per Shipment Unit" * "Shipm.Units per Shipm.Containr"
            end;
        }


        field(50002; "Label Type"; enum "WDC Label Type")
        {
            CaptionML = ENU = 'Label Type', FRA = 'Type d''étiquette';
            DataClassification = ToBeClassified;
        }
        field(50003; "Shipment Container"; Code[20])
        {
            CaptionML = ENU = 'Shipment Container', FRA = 'Support logistique';
            TableRelation = "WDC Packaging" WHERE(Type = filter("Shipment Container"));

            trigger OnValidate()
            begin
                IF "Shipment Container" <> xRec."Shipment Container" THEN BEGIN
                    IF "Shipment Container" = '' THEN BEGIN
                        VALIDATE("Shipm.Units per Shipm.Containr", 1);
                    END
                END;
            end;
        }
        field(50004; "Shipm.Units per Shipm.Containr"; Decimal)
        {
            CaptionML = ENU = 'Shipment Units per Shipment Container', FRA = 'Qté unité expédition par support logistique';
            DecimalPlaces = 0 : 0;
            InitValue = 1;

            trigger OnValidate()
            begin
                IF "Shipm.Units per Shipm.Containr" <= 0 THEN
                    FIELDERROR("Shipm.Units per Shipm.Containr", TextSI000);
                IF "Shipm.Units per Shipm.Containr" <> 1 THEN
                    TESTFIELD("Shipment Container");

                "Qty. per Shipment Container" := "Qty. per Shipment Unit" * "Shipm.Units per Shipm.Containr"
            end;
        }
        field(50005; "Qty. per Shipment Container"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Shipment Container', FRA = 'Qté par support logistique';
            DecimalPlaces = 0 : 2;
            Editable = false;
            InitValue = 1;
            trigger OnValidate()
            begin
                IF "Qty. per Shipment Container" <= 0 THEN
                    FIELDERROR("Qty. per Shipment Container", TextSI000);

            end;
        }

        field(50006; "Qty. per Layer"; Integer)
        {
            Captionml = ENU = 'Quantity per Layer', FRA = 'Qté unité expédition par couche';
            MinValue = 0;
        }
        field(50007; "No. of Layers"; Decimal)
        {
            CaptionML = ENU = 'No. of Layers', FRA = 'Nombre de couches';
            DecimalPlaces = 0 : 0;
        }
        field(50008; " Purchases Item Rebate Group"; Code[20])
        {
            CaptionML = ENU = 'Purchases Item Rebate Group', FRA = 'Groupe bonus article achat';
            TableRelation = "WDC Item Rebate Group";
        }


    }
    procedure IsPackagingItem(): Boolean
    var
        Packaging: Record "WDC Packaging";
    begin
        Packaging.RESET;
        Packaging.SETCURRENTKEY("Item No.");
        Packaging.SETFILTER("Item No.", "No.");
        EXIT(NOT Packaging.ISEMPTY);
    end;

    var
        TextSI000: TextConst ENU = 'Must be greater than 0.', FRA = 'Doit être supérieur à 0.';
}
