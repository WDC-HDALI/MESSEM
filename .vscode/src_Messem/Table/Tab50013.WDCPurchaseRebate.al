table 50013 "WDC Purchase Rebate"
{
    CaptionML = ENU = 'Purchase Rebate', FRA = 'Bonus achat';

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
            TableRelation = "WDC Item Rebate Group".Code;
            trigger OnValidate()
            var
                ItemRebateGroup: Record "WDC Item Rebate Group";
                ItemRebateGroupFrm: Page "WDC Item Rebate Groups";
            begin
                IF Code <> xRec.Code THEN
                    TestNoOpenEntriesExist;

            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'No. Fournisseur';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF "Vendor No." <> xRec."Vendor No." THEN
                    TestNoOpenEntriesExist;
            end;
        }
        field(3; "Starting Date"; Date)
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
        field(4; "Ending Date"; Date)
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
            Editable = false;

            trigger OnValidate()
            begin
                VALIDATE("Starting Date");
            end;
        }
        field(5; "Rebate Code"; Code[20])
        {
            CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
            NotBlank = true;
            TableRelation = "WDC Rebate Code".Code;
            trigger OnValidate()
            var
                Invtsetup: Record 313;
                RebateCode: Record "WDC Rebate Code";
            begin
                IF "Rebate Code" <> xRec."Rebate Code" THEN
                    TestNoOpenEntriesExist;

                RebateCode.GET("Rebate Code");

                VALIDATE("Starting Date", RebateCode."Starting Date");
                VALIDATE("Ending Date", RebateCode."Ending Date");
            end;
        }
        field(6; "Accrual Value (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Accrual Value (LCY)', FRA = 'Valeur réservation DS';
            MinValue = 0;

            trigger OnValidate()
            begin
                TESTFIELD("Rebate Code");
            end;
        }
        field(7; "Rebate Scale"; Boolean)
        {
            CalcFormula = Exist("WDC Rebate Scale" WHERE(Code = FIELD("Rebate Code")));
            CaptionML = ENU = 'Rebate Scale', FRA = 'Accord échelonnement';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", "Vendor No.", "Rebate Code", "Starting Date")
        {
            Clustered = true;
        }
        key(Key2; "Vendor No.", "Code", "Rebate Code", "Starting Date")
        {
        }
        key(Key3; "Vendor No.", "Rebate Code", "Code", "Starting Date")
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
        Text000: Textconst ENU = '%1 cannot be after %2',
                           FRA = '%1 ne peut pas être postérieur(e) à %2';
        Text001: Textconst ENU = 'You cannot rename this record because there are one or more open rebate entries.',
                           FRA = 'Vous ne pouvez pas renommer cet enregistrement car il existe une ou plusieurs entrées ouvertes de bonus';
        Text002: Textconst ENU = 'You cannot remove this record because there are one or more rebate entries.',
                           FRA = 'Vous ne pouvez pas supprimer cet enregistrement car il existe une ou plusieurs entrées de bonus';
        SkipOpenEntriesCheck: Boolean;


    procedure TestNoEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        RebateEntry.SETCURRENTKEY("Vendor No.", "Rebate Code", "Starting Date");
        RebateEntry.SETRANGE("Vendor No.", "Vendor No.");
        RebateEntry.SETRANGE("Rebate Code", "Rebate Code");
        RebateEntry.SETRANGE("Starting Date", "Starting Date");
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text002);
    end;


    procedure TestNoOpenEntriesExist()
    var
        RebateEntry: Record "WDC Rebate Entry";
    begin
        IF (Code = '') OR ("Vendor No." = '') OR ("Rebate Code" = '') OR
           ("Starting Date" = 0D) OR SkipOpenEntriesCheck THEN
            EXIT;

        RebateEntry.SETCURRENTKEY("Vendor No.", "Rebate Code", "Starting Date");
        RebateEntry.SETRANGE("Vendor No.", xRec."Vendor No.");
        RebateEntry.SETRANGE("Rebate Code", xRec."Rebate Code");
        RebateEntry.SETRANGE("Starting Date", xRec."Starting Date");
        RebateEntry.SETRANGE(Open, TRUE);
        IF NOT RebateEntry.ISEMPTY THEN
            ERROR(Text001);
        SkipOpenEntriesCheck := TRUE;
        //
    end;
}

