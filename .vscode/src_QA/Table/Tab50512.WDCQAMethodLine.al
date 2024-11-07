table 50512 "WDC-QA Method Line"
{
    CaptionML = ENU = 'Method Line', FRA = 'Ligne méthode';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
            TableRelation = "WDC-QA Method Header";
        }
        field(2; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        field(3; "Column No."; Code[20])
        {
            CaptionML = ENU = 'Column No.', FRA = 'N° colonne';
            NotBlank = true;
            trigger OnValidate()
            begin
                MethodLine.RESET;
                MethodLine.SETRANGE("Document No.", "Document No.");
                MethodLine.SETRANGE("Column No.", "Column No.");
                IF NOT MethodLine.ISEMPTY THEN
                    FIELDERROR("Column No.");
            end;
        }
        field(4; "Equipment Group Code"; Code[20])
        {
            CaptionML = ENU = 'Equipment Group Code', FRA = 'Code groupe équipement';
            TableRelation = "WDC-QA Equipment Group";
        }
        field(5; "Type of Measure"; Enum "WDC-QA Type Of Result")
        {
            CaptionML = ENU = 'Type of Measure', FRA = 'Type de mesure';
            ValuesAllowed = 1, 2;
            trigger OnValidate()
            begin
                IF "Type of Measure" = "Type of Measure"::Option THEN BEGIN
                    "Value UOM" := '';
                    Sample := FALSE;
                END ELSE BEGIN
                    TESTFIELD(Result, FALSE);
                END;
            end;
        }
        field(6; "Value UOM"; Code[20])
        {
            CaptionML = ENU = 'Value UOM', FRA = 'Unité valeur';
            TableRelation = "Unit of Measure";
            trigger OnValidate()
            begin
                TESTFIELD("Type of Measure", "Type of Measure"::Value)
            end;
        }
        field(7; "Measurement Code"; Code[20])
        {
            CaptionML = ENU = 'Measurement Code', FRA = 'Code mesure';
            TableRelation = "WDC-QA Measurement";
            trigger OnValidate()
            begin
                IF Measurement.GET("Measurement Code") THEN
                    Description := Measurement.Description
                ELSE
                    Description := '';
            end;
        }
        field(8; "Description"; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(9; "Sample"; Boolean)
        {
            CaptionML = ENU = 'Document No.', FRA = 'Échantillon';
        }
        field(10; "Remark"; Text[80])
        {
            CaptionML = ENU = 'Remark', FRA = 'Remarque';
        }
        field(11; "Result"; Boolean)
        {
            CaptionML = ENU = 'Result', FRA = 'Résultat';
            trigger OnValidate()
            begin
                TESTFIELD("Type of Measure", "Type of Measure"::Option);

                MethodHeader.GET("Document No.");
                MethodHeader.TESTFIELD("Result Type", MethodHeader."Result Type"::Option);

                MethodLine.SETFILTER("Document No.", "Document No.");
                MethodLine.SETRANGE(Result, TRUE);
                IF MethodLine.FINDFIRST AND
                  (MethodLine.GETPOSITION <> GETPOSITION)
                   THEN
                    MethodLine.FIELDERROR(Result);
            end;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        TESTFIELD("Column No.");
    end;

    trigger OnModify()
    begin
        TESTFIELD("Column No.");
    end;

    var
        MethodLine: Record "WDC-QA Method Line";
        MethodHeader: Record "WDC-QA Method Header";
        Measurement: Record "WDC-QA Measurement";
}
