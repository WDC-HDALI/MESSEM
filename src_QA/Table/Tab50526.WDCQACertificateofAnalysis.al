table 50526 "WDC-QA Certificate of Analysis"
{
    CaptionML = ENU = 'Certificate of Analysis', FRA = 'Certificats';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(3; "Customer No."; Code[20])
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            TableRelation = Customer;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Customer.GET("Customer No.") THEN
                    "Customer Name" := Customer.Name
                ELSE
                    "Customer Name" := '';
            end;
        }
        field(4; "Customer Name"; Text[50])
        {
            CaptionML = ENU = 'Customer Name', FRA = 'Nom client';
            Editable = false;
        }
        field(5; "Report ID"; Integer)
        {
            CaptionML = ENU = 'Report ID', FRA = 'ID état';
            //TableRelation = Object.ID WHERE(Type = filter(Report));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Report Name");
            end;
        }
        field(6; "Report Name"; Text[250])
        {
            CaptionML = ENU = 'Report Name', FRA = 'Nom état';
            FieldClass = FlowField;
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report), "Object ID" = FIELD("Report ID")));
            Editable = false;
        }
        field(7; "Automatically Printed"; Enum "WDC-QA Automatically Printed")
        {
            CaptionML = ENU = 'Automatically Printed', FRA = 'Imprimé automatiquement';

        }
        field(8; "Contact No."; Code[20])
        {
            CaptionML = ENU = 'Contact No.', FRA = 'N° contact';
            TableRelation = Contact;
            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                IF "Contact No." <> '' THEN BEGIN
                    Cont.GET("Contact No.");

                    ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                    ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                    ContBusRel.SETRANGE("No.", "Customer No.");
                    ContBusRel.FINDFIRST;

                    IF Cont."Company No." <> ContBusRel."Contact No." THEN
                        ERROR(Text001, Cont."No.", Cont.Name, "Customer No.", "Customer Name");

                END;
            end;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                ContBusRel.SETCURRENTKEY("Link to Table", "No.");
                ContBusRel.SETRANGE("Link to Table", ContBusRel."Link to Table"::Customer);
                ContBusRel.SETRANGE("No.", "Customer No.");
                IF ContBusRel.FINDFIRST THEN
                    Cont.SETRANGE("Company No.", ContBusRel."Contact No.");

                IF "Contact No." <> '' THEN
                    IF Cont.GET("Contact No.") THEN;
                IF PAGE.RUNMODAL(0, Cont) = ACTION::LookupOK THEN
                    VALIDATE("Contact No.", Cont."No.");
            end;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
        key(Key1; "Customer No.")
        { }
    }
    var
        Customer: Record Customer;
        Text001: TextConst ENU = 'Contact %1 %2 is not related to customer %3 %4.', FRA = 'Le contact %1 %2 n''est pas associé au client %3 %4.';
}
