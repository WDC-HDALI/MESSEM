table 50010 "WDC Rebate Code"
{
    CaptionML = ENU = 'Rebate Code', FRA = 'Code Bonus';
    DrillDownPageID = "WDC Rebate Code";
    LookupPageID = "WDC Rebate Code";

    fields
    {
        field(1; Type; enum "WDC Code Rebate type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[30])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        field(4; "Rebate GL-Acc. No."; Code[20])
        {
            CaptionML = ENU = 'Rebate GL-Acc. No.', FRA = 'No. GL-Acc. Bonus';
            TableRelation = "G/L Account" WHERE("Rebate G/L Account" = CONST(true));
        }
        field(5; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';

            trigger OnValidate()
            var
                PurchaseRebate: Record "WDC Purchase Rebate";
            begin
                IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));

                IF xRec."Starting Date" = 0D THEN
                    EXIT;

                IF Type = Type::Purchase THEN BEGIN
                    PurchaseRebate.SETRANGE("Rebate Code", Code);
                    IF PurchaseRebate.ISEMPTY THEN
                        EXIT;
                END;

                TestNoEntriesExist;

                IF NOT CONFIRM(Text005, FALSE, Code) THEN
                    ERROR('');

                IF Type = Type::Purchase THEN BEGIN
                    PurchaseRebate.FINDSET(TRUE);
                    REPEAT
                        PurchaseRebate.DELETE;
                        PurchaseRebate."Starting Date" := "Starting Date";
                        PurchaseRebate.INSERT;
                    UNTIL PurchaseRebate.NEXT <= 0;
                END;
            end;
        }
        field(6; "Ending Date"; Date)
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';

            trigger OnValidate()
            var
                RebateEntry: Record "WDC Rebate Entry";
                PurchaseRebate: Record "WDC Purchase Rebate";
            begin
                IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));

                IF xRec."Ending Date" = 0D THEN
                    EXIT;

                IF Type = Type::Purchase THEN BEGIN
                    PurchaseRebate.SETRANGE("Rebate Code", Code);
                    IF PurchaseRebate.ISEMPTY THEN
                        EXIT;
                END;

                RebateEntry.SETCURRENTKEY("Rebate Code", "Posting Type", "Posting Date", Open);
                //RebateEntry.SETRANGE("Posting Type", type.AsInteger() + 1);
                RebateEntry.SETRANGE("Rebate Code", Code);
                RebateEntry.SETFILTER("Posting Date", '>%1', "Ending Date");
                RebateEntry.SETRANGE(Open, TRUE);
                IF NOT RebateEntry.ISEMPTY THEN
                    ERROR(Text001);

                IF NOT CONFIRM(Text005, FALSE, Code) THEN
                    ERROR('');

                RebateEntry.RESET;
                RebateEntry.SETRANGE("Rebate Code", Code);
                IF NOT RebateEntry.ISEMPTY THEN
                    RebateEntry.MODIFYALL("Ending Date", "Ending Date");

                IF Type = Type::Purchase THEN
                    PurchaseRebate.MODIFYALL("Ending Date", "Ending Date")
            end;
        }
        field(7; "Rebate Method"; Enum "WDC Rebate Method")
        {
            CaptionML = ENU = 'Rebate Method', FRA = 'Méthode bonus';

            trigger OnValidate()
            begin
                "Unit of Measure Code" := '';
            end;
        }
        field(8; "Currency Code"; Code[20])
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            TableRelation = Currency;
        }
        field(9; "Unit of Measure Code"; Code[20])
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
            TableRelation = IF ("Rebate Method" = filter("WDC Rebate Method"::Actual)) "Unit of Measure";

            trigger OnValidate()
            begin
                TESTFIELD("Rebate Method", "Rebate Method"::Actual)
            end;
        }
        field(11; "Register Option Purchase Rebat"; Enum "WDC Register opt purch Rebat")
        {
            CaptionML = ENU = 'Register Option Purchase Rebate', FRA = 'Méthode d''enregistrement bonus achat';
            trigger OnValidate()
            var
                PurchaseRebate: Record "WDC Purchase Rebate";
            begin
                TESTFIELD(Type, Type::Purchase);
                IF "Register Option Purchase Rebat" <> xRec."Register Option Purchase Rebat" THEN BEGIN
                    PurchaseRebate.SETRANGE("Rebate Code", Code);
                    IF NOT PurchaseRebate.ISEMPTY THEN
                        ERROR(Text003, FIELDCAPTION("Register Option Purchase Rebat"), Code, Type);
                END;

            end;
        }
        field(12; "Rebate GL-Acc. No.2"; Code[20])
        {
            CaptionML = ENU = 'Rebate GL-Acc. No.', FRA = 'N° compte général bonus 2';
            TableRelation = "G/L Account" WHERE("Rebate G/L Account" = CONST(true));
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        RebateScale: Record "WDC Rebate Scale";
    begin
        TestNoEntriesExist;

        RebateScale.SETRANGE(Type, Type);
        RebateScale.SETRANGE(Code, Code);
        IF NOT RebateScale.ISEMPTY THEN
            RebateScale.DELETEALL;
    end;

    trigger OnInsert()
    begin
        TestForInValidFields;

    end;

    trigger OnModify()
    begin
        TestForInValidFields;
        CheckRebateScales;
    end;

    trigger OnRename()
    begin
        TestForInValidFields;

        TestNoOpenEntriesExist;
        CheckRebateScales;
    end;

    var
        Text000: TextConst ENU = '%1 cannot be after %2',
                           FRA = '%1 ne peut pas être postérieur(e) à %2';
        Text001: TextConst ENU = 'You cannot change End Date; One or more open entries exist with a date later than the New End Date.',
                           FRA = '';
        Text002: TextConst ENU = 'You cannot remove this record because there are one or more rebate entries.',
                           FRA = 'Vous ne pouvez pas renommer cet enregistrement car il existe une ou plusieurs entrées ouvertes de bonus';
        Text003: TextConst ENU = '%1 can not be changed because Rebate Code %2 is used in %3 rebates.',
                           FRA = '%1 ne peut pas être changé parce que le code bonus %2 est utilisé dans %3 bonus.';
        Text004: TextConst ENU = 'Please check rebate scales for Rebate Code %1.',
                           FRA = '';
        Text005: TextConst ENU = 'All rebate lines from Rebate Code %1 wil be modified.\Do you want to continue?',
                           FRA = 'S''il vous plaît vérifier les règles de bonus pour le code de bonus %1.';
        Text006: TextConst ENU = 'You cannot modify End Date because there are one or more open rebate entries with Posting Date past %1.',
                           FRA = 'Vous ne pouvez pas modifier Date de fin car il ya une ou plusieurs entrées ouvertes de bonus avec Date de comptabilisation passé %1.';

    procedure TestForInValidFields()
    begin
        IF "Rebate Method" = "Rebate Method"::Actual THEN
            TESTFIELD("Unit of Measure Code");

        TESTFIELD("Starting Date");
        TESTFIELD("Ending Date");
    end;

    procedure TestNoEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        RebateEntry.SETCURRENTKEY("Rebate Code", "Posting Type", Open);
        //RebateEntry.SETRANGE("Posting Type", Enum::"WDC Rebate Posting type".FromInteger(Rec.Type.AsInteger() + 1));
        RebateEntry.SETRANGE("Rebate Code", Code);
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text002);
    end;

    procedure TestNoOpenEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        RebateEntry.SETCURRENTKEY("Rebate Code", "Posting Type", Open);
        //RebateEntry.SETRANGE("Posting Type", Enum::"WDC Rebate Posting type".FromInteger(Rec.Type.AsInteger() + 1));
        RebateEntry.SETRANGE("Rebate Code", Code);
        RebateEntry.SETRANGE(Open, TRUE);
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text001);
    end;

    procedure CheckRebateScales()
    var
        RebateScale: Record "WDC Rebate Scale";
    begin
        IF ("Rebate Method" <> xRec."Rebate Method") OR
           ("Unit of Measure Code" <> xRec."Unit of Measure Code") OR
           ("Currency Code" <> xRec."Currency Code") THEN BEGIN
            RebateScale.SETRANGE(Type, xRec.Type);
            RebateScale.SETRANGE(Code, xRec.Code);
            IF NOT RebateScale.ISEMPTY THEN
                MESSAGE(Text004, Code);
        END;
    end;
}

