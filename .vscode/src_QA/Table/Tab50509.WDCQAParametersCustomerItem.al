table 50509 "WDC-QA ParametersCustomer/Item"
{
    CaptionML = ENU = 'Parameters per Customer/Item', FRA = 'Paramètres par client/article';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            NotBlank = true;
            TableRelation = Item;
        }
        field(3; "Parameter Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Code', FRA = 'Code paramètre';
            NotBlank = true;
            TableRelation = "WDC-QA Parameter".Code WHERE(Type = CONST("QC-specification"));
            trigger OnValidate()
            var
                Parameter: Record "WDC-QA Parameter";
            begin
                IF Parameter.GET(Parameter.Type::"QC-specification", "Parameter Code") THEN
                    Description := Parameter.Description
                ELSE
                    Description := '';
            end;
        }
        field(4; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Customer No.", "Item No.", "Parameter Code")
        {
            Clustered = true;
        }
    }
}
