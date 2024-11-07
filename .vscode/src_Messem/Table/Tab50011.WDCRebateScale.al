table 50011 "WDC Rebate Scale"
{

    CaptionML = ENU = 'Rebate Scales', FRA = 'Régles de Bonus';
    DrillDownPageId = "WDC Rebate Scales";
    fields
    {
        field(1; Type; Enum "WDC Code Rebate type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            TableRelation = "WDC Rebate Code";
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° Ligne';
        }
        field(4; "Minimum Quantity"; Decimal)
        {
            CaptionML = ENU = 'Minimum Quantity', FRA = 'Qte minimum';
            MinValue = 0;

            trigger OnValidate()
            var
                RebateCode: Record "WDC Rebate Code";
            begin
                RebateCode.GET(Type, Code);
                RebateCode.TESTFIELD("Rebate Method", RebateCode."Rebate Method"::Actual);
                TESTFIELD("Minimum Amount", 0);
                //FW-31141-4KMG
                CheckOtherLines(FIELDNO("Minimum Quantity"));
                //
                VALIDATE("Rebate Value");
            end;
        }
        field(5; "Minimum Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CaptionML = ENU = 'Minimum Amount', FRA = 'Montant minimum';
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("Minimum Quantity", 0);
                //FW-31141-4KMG
                CheckOtherLines(FIELDNO("Minimum Amount"));
                //
                VALIDATE("Rebate Value");
            end;
        }
        field(6; "Rebate Value"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CaptionML = ENU = 'Rebate Value', FRA = 'Valeur bonus';

            trigger OnValidate()
            begin
                IF "Rebate Value" <> 0 THEN
                    IF ("Minimum Quantity" = 0) AND ("Minimum Amount" = 0) THEN
                        ERROR(Text000);
            end;
        }
    }

    keys
    {
        key(Key1; Type, "Code", "Line No.")
        {
            Clustered = true;
        }
    }


    var
        Text000: TextConst ENU = 'Minimum Quantity and Minimum Amount cannot both be zero.',
                           FRA = 'Quantité minimum et montant minimum ne peuvent pas être tous les deux à zéro.';
        Text001: TextConst ENU = 'must be 0',
                           FRA = 'doit être 0';


    procedure GetCurrencyCode(): Code[20]
    var
        RebateCode: Record "WDC Rebate Code";
    begin
        IF RebateCode.GET(Type, Code) THEN
            EXIT(RebateCode."Currency Code");
    end;

    procedure CheckOtherLines(FromField: Integer)
    var
        RebateScale2: Record "WDC Rebate Scale";
    begin
        RebateScale2.SETRANGE(Type, Type);
        RebateScale2.SETRANGE(Code, Code);
        RebateScale2.SETFILTER("Line No.", '<>%1', "Line No.");

        CASE FromField OF
            FIELDNO("Minimum Quantity"):
                IF "Minimum Quantity" <> 0 THEN
                    RebateScale2.SETFILTER("Minimum Amount", '<>%1', 0);
            FIELDNO("Minimum Amount"):
                IF "Minimum Amount" <> 0 THEN
                    RebateScale2.SETFILTER("Minimum Quantity", '<>%1', 0);
        END;

        IF NOT RebateScale2.ISEMPTY THEN
            CASE FromField OF
                FIELDNO("Minimum Quantity"):
                    FIELDERROR("Minimum Quantity", Text001);
                FIELDNO("Minimum Amount"):
                    FIELDERROR("Minimum Amount", Text001);
            END;
    end;
}

