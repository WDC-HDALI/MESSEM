table 50525 "WDC-QA CoA Template"
{
    CaptionML = ENU = 'CoA Template', FRA = 'Modèle certificat d''analyse';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA CoA Template List";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
            NotBlank = true;
        }
        field(2; "Check Point Code"; Code[20])
        {
            CaptionML = ENU = 'Check Point Code', FRA = 'Code point de contrôle';
            TableRelation = IF (Type = CONST(Parameter)) "WDC-QA Check Point";
        }
        field(3; "Type Value"; enum "WDC-QA CoA Type Value")
        {
            CaptionML = ENU = 'Type Value', FRA = 'Type Valeur';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Type Value" = "Type Value"::Average THEN BEGIN
                    IF Parameter.GET(Parameter.Type::"QC-specification", "Parameter Code") THEN BEGIN
                        IF Parameter."Method No." <> '' THEN BEGIN
                            IF MethodHeader.GET(Parameter."Method No.") THEN BEGIN
                                IF MethodHeader."Result Type" = MethodHeader."Result Type"::Option THEN
                                    ERROR(Text0001, FIELDCAPTION("Type Value"), "Type Value",
                                      MethodHeader.FIELDCAPTION("Result Type"), MethodHeader."No.", MethodHeader."Result Type");
                            END;
                        END;
                    END;
                END;
            end;
        }
        field(4; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        field(5; "Type"; Enum "WDC-QA Registration Line Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            trigger OnValidate()
            begin
                "Parameter Code" := '';
                Description := '';
            end;
        }
        field(6; "Parameter Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Code', FRA = 'Code paramètre';
            TableRelation = IF (Type = CONST(Parameter)) "WDC-QA Parameter".Code WHERE(Type = filter('QC-specification'));
            trigger OnValidate()
            begin
                IF Parameter.GET(Parameter.Type::"QC-specification", "Parameter Code") THEN;
                Description := Parameter.Description;
            end;
        }
        field(7; Description; Text[80])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(8; "Alternative Item No."; Code[20])
        {
            CaptionML = ENU = 'Alternative Item No.', FRA = 'Référence de remplacement';
            TableRelation = IF (Type = CONST(Parameter)) Item;
        }
    }
    keys
    {
        key(PK; "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
        Parameter: Record "WDC-QA Parameter";
        MethodHeader: Record "WDC-QA Method Header";
        Text0001: TextConst ENU = '%1 can not be %2 since %3 for method %4 is %5.',
                            FRA = '%1 ne peut pas être %2 car %3 pour méthode %4 est %5.';
}
