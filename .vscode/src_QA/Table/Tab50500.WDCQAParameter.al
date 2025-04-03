table 50500 "WDC-QA Parameter"
{
    CaptionML = ENU = 'Parameter', FRA = 'Paramètre';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA QC Parameters";

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
        field(3; "Parameter Group Code"; Code[20])
        {
            CaptionML = ENU = 'Parameter Group Code', FRA = 'Code groupe paramètre';
            TableRelation = "WDC-QA Parameter Group";
        }
        field(4; "Method No."; Code[20])
        {
            CaptionML = ENU = 'Method No.', FRA = 'N° Méthode';
            TableRelation = "WDC-QA Method Header";
        }
        field(5; Type; Enum "WDC-QA Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(6; "Decimal Point"; Enum "WDC-QA Decimal Point")
        {
            CaptionML = ENU = 'Decimal Point', FRA = 'Chiffre après virgule';
        }
        field(7; "MicroBio Parameter"; Boolean)
        {
            CaptionML = ENU = 'MicroBio Parameter', FRA = 'Parameter MicroBio';
        }
    }
    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    begin
        CheckCoupledToRegistration(TRUE);
        CheckCoupledToSpecification(TRUE);
    end;

    procedure CheckCoupledToRegistration(ShowError: Boolean): Boolean
    var
        RegistrationLine: Record "WDC-QA Registration Line";
        RegistrationHeader: Record "WDC-QA Registration Header";
    begin
        RegistrationLine.SETRANGE("Parameter Code", Code);
        IF RegistrationLine.FINDSET THEN
            REPEAT
                IF RegistrationHeader.GET(RegistrationLine."Document Type", RegistrationLine."Document No.") THEN BEGIN
                    IF RegistrationHeader.Status = RegistrationHeader.Status::Open THEN BEGIN
                        IF ShowError THEN
                            ERROR(TextSI000, TextSI001, Code, TextSI002);
                        EXIT(TRUE);
                    END;
                END;
            UNTIL RegistrationLine.NEXT <= 0;
    end;

    procedure CheckCoupledToSpecification(ShowError: Boolean): Boolean
    var
        SpecificationHeader: Record "WDC-QA Specification Header";
        SpecificationLine: Record "WDC-QA Specification Line";
    begin
        SpecificationLine.SETRANGE("Parameter Code", Code);
        IF SpecificationLine.FINDSET THEN
            REPEAT
                IF SpecificationHeader.GET(
                     SpecificationLine."Document Type", SpecificationLine."Document No.", SpecificationLine."Version No.") THEN BEGIN
                    IF SpecificationHeader.Status = SpecificationHeader.Status::Open THEN BEGIN
                        IF ShowError THEN
                            ERROR(TextSI000, TextSI001, Code, TextSI003);
                        EXIT(TRUE);
                    END;
                END;
            UNTIL SpecificationLine.NEXT <= 0;
    end;

    var
        TextSI000: TextConst ENU = 'You can not remove %1 %2, because there is at least one %3 for this %1.',
                             FRA = 'Vous ne pouvez pas enlever %1 %2, car il existe au moins un %3 pour ce %1.';
        TextSI001: TextConst ENU = 'QC-Parameter',
                             FRA = 'Paramètre CQ';
        TextSI002: TextConst ENU = 'QC-Registration',
                             FRA = 'Enregistrement CQ';
        TextSI003: TextConst ENU = 'QC-Specification',
                             FRA = 'Spécification CQ';

}
