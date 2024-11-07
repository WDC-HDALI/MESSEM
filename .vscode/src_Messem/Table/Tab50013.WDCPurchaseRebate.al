table 50013 "WDC Purchase Rebate"
{
    CaptionML = ENU = 'Purchase Rebate', FRA = 'Bonus achat';

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE IF (Type = CONST("Item Rebate Group")) "WDC Item Rebate Group";

            trigger OnLookup()
            var
                ItemRebateGroup: Record "WDC Item Rebate Group";
                ItemRebateGroupFrm: Page "WDC Item Rebate Groups";
            begin
                CASE Type OF
                    Type::Item:
                        BEGIN
                            IF Item.GET(Code) THEN;
                            IF PAGE.RUNMODAL(0, Item) = ACTION::LookupOK THEN
                                VALIDATE(Code, Item."No.");
                        END;
                    Type::"Item Rebate Group":
                        BEGIN
                            ItemRebateGroupFrm.SetTypeFilter(1);
                            ItemRebateGroupFrm.SETTABLEVIEW(ItemRebateGroup);
                            ItemRebateGroupFrm.LOOKUPMODE(TRUE);
                            IF ItemRebateGroupFrm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                ItemRebateGroupFrm.GETRECORD(ItemRebateGroup);
                                VALIDATE(Code, ItemRebateGroup.Code);
                            END;
                        END;
                END;
            end;

            trigger OnValidate()
            begin
                IF Code <> xRec.Code THEN
                    TestNoOpenEntriesExist;
            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'Fournisseur';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF "Vendor No." <> xRec."Vendor No." THEN
                    TestNoOpenEntriesExist;
            end;
        }
        field(4; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
            Editable = false;
            NotBlank = true;

            trigger OnValidate()
            begin
                IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));
            end;
        }
        field(10; "Rebate Code"; Code[20])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
            NotBlank = true;
            TableRelation = "WDC Rebate Code".Code;

            trigger OnLookup()
            var
                RebateCode: Record "WDC Rebate Code";
                RebateCodeFrm: Page "WDC Rebate Code";
            begin
                RebateCodeFrm.SETTABLEVIEW(RebateCode);
                RebateCodeFrm.LOOKUPMODE(TRUE);
                IF RebateCodeFrm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    RebateCodeFrm.GETRECORD(RebateCode);
                    VALIDATE("Rebate Code", RebateCode.Code);
                END;
            end;

            trigger OnValidate()
            var
                Invtsetup: Record 313;
                RebateCode: Record "WDC Rebate Code";
            begin
                IF "Rebate Code" <> xRec."Rebate Code" THEN
                    TestNoOpenEntriesExist;
                CheckRebateRegisterOption;

                RebateCode.GET(RebateCode.Type::Purchase, "Rebate Code");
                VALIDATE("Rebate Method", RebateCode."Rebate Method");

                IF Type = Type::Item THEN BEGIN
                    IF Item."No." <> Code THEN
                        Item.GET(Code);

                    // IF Item."Catch Weight Item" AND Item."Purchase Price per Kg" AND
                    //    ("Rebate Method" = "Rebate Method"::Actual)
                    // THEN BEGIN
                    //     Invtsetup.GET;
                    //     Invtsetup.TESTFIELD("Weight UOM");
                    //     RebateCode.TESTFIELD("Unit of Measure Code", Invtsetup."Weight UOM");
                    // END;
                    VALIDATE("Unit of Measure Code", RebateCode."Unit of Measure Code");
                END;

                VALIDATE("Starting Date", RebateCode."Starting Date");
                VALIDATE("Ending Date", RebateCode."Ending Date");
            end;
        }
        field(11; "Accrual Value (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Accrual Value (LCY)', FRA = 'Valeur réservation DS';
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("Rebate Code");
            end;
        }
        field(12; "Rebate Scale"; Boolean)
        {
            CalcFormula = Exist("WDC Rebate Scale" WHERE(Type = CONST(Purchase),
                                                      Code = FIELD("Rebate Code")));
            CaptionML = ENU = 'Rebate Scale', FRA = 'Accord échelonnement';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Ending Date"; Date)
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Starting Date");
            end;
        }
        field(16; "Rebate Method"; Enum "WDC Rebate Method")
        {
            CaptionML = ENU = 'Rebate Method', FRA = 'Methode bonus';
            Editable = false;
        }
        field(17; "Unit of Measure Code"; Code[20])
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
            Editable = false;
            TableRelation = IF (Type = CONST(Item),
                                "Rebate Method" = CONST(Actual)) "Item Unit of Measure".Code WHERE("Item No." = FIELD(Code));

        }
        field(21; Type; Enum "WDC Rebate Item Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            trigger OnValidate()
            begin
                // SSC.OP04074.1056, FW-14477-76N4
                IF Type <> xRec.Type THEN
                    TestNoOpenEntriesExist;
                CheckRebateRegisterOption;
                //
                IF xRec.Type <> Type THEN BEGIN
                    Code := '';
                    "Unit of Measure Code" := '';
                END;
            end;
        }
    }

    keys
    {
        key(Key1; Type, "Code", "Vendor No.", "Rebate Code", "Starting Date", "Unit of Measure Code")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", Type, "Code", "Rebate Code", "Starting Date", "Unit of Measure Code")
        {
        }
        key(Key3; "Vendor No.", "Rebate Code", Type, "Code", "Starting Date", "Unit of Measure Code")
        {
        }
    }

    trigger OnDelete()
    begin
        TestNoOpenEntriesExist;
        SkipOpenEntriesCheck := FALSE;
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Ending Date");
    end;

    trigger OnModify()
    begin
        TESTFIELD("Ending Date");
    end;

    trigger OnRename()
    begin
        TESTFIELD("Ending Date");
        TestNoOpenEntriesExist;
        SkipOpenEntriesCheck := FALSE;
    end;

    var
        Item: Record 27;
        Text000: Label '%1 cannot be after %2';
        Text001: Label 'You cannot rename this record because there are one or more open rebate entries.';
        Text002: Label 'You cannot remove this record because there are one or more rebate entries.';
        SkipOpenEntriesCheck: Boolean;


    procedure TestNoEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        RebateEntry.SETCURRENTKEY("Item Type", "Item Code", "Vendor No.", "Rebate Code", "Starting Date", "Unit of Measure Code");
        RebateEntry.SETRANGE("Item Type", Type);
        RebateEntry.SETRANGE("Item Code", Code);
        RebateEntry.SETRANGE("Vendor No.", "Vendor No.");
        RebateEntry.SETRANGE("Rebate Code", "Rebate Code");
        RebateEntry.SETRANGE("Starting Date", "Starting Date");
        // SSC.OP04074.1056
        RebateEntry.SETRANGE("Rebate Unit of Measure Code", "Unit of Measure Code");
        //
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text002);
    end;


    procedure TestNoOpenEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        // FW-14477-76N4
        IF (Code = '') OR ("Vendor No." = '') OR ("Rebate Code" = '') OR
           ("Starting Date" = 0D) OR ("Unit of Measure Code" = '') OR
           SkipOpenEntriesCheck
        THEN
            EXIT;
        //

        RebateEntry.SETCURRENTKEY("Item Type", "Item Code", "Vendor No.", "Rebate Code", "Starting Date", "Unit of Measure Code");
        RebateEntry.SETRANGE("Item Type", xRec.Type);
        RebateEntry.SETRANGE("Item Code", xRec.Code);
        RebateEntry.SETRANGE("Vendor No.", xRec."Vendor No.");
        RebateEntry.SETRANGE("Rebate Code", xRec."Rebate Code");
        RebateEntry.SETRANGE("Starting Date", xRec."Starting Date");
        RebateEntry.SETRANGE("Rebate Unit of Measure Code", xRec."Unit of Measure Code");
        RebateEntry.SETRANGE(Open, TRUE);
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text001);
        SkipOpenEntriesCheck := TRUE;
        //
    end;


    procedure CheckRebateRegisterOption()
    var
        RebateCode: Record "WDC Rebate Code";
    begin
        // SSC.OP04074.1056
        IF "Rebate Code" <> '' THEN BEGIN
            RebateCode.GET(RebateCode.Type::Purchase, "Rebate Code");
            CASE RebateCode."Register Option Purchase Rebat" OF
                RebateCode."Register Option Purchase Rebat"::"Item+Vendor No":
                    TESTFIELD(Type, Type::Item);
                RebateCode."Register Option Purchase Rebat"::"Item Rebate Group+Vendor No":
                    TESTFIELD(Type, Type::"Item Rebate Group");
            END;
        END;
        //
    end;
}

