table 50520 "WDC-QA RegistrationCommentLine"
{
    CaptionML = ENU = 'Registration Comment Line', FRA = 'Ligne commentaire enregistrement';
    DataClassification = ToBeClassified;
    LookupPageId = "WDC-QA RegistrationCommentList";
    DrillDownPageId = "WDC-QA RegistrationCommentList";

    fields
    {
        field(1; "Document Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        field(4; "Date"; Date)
        {
            CaptionML = ENU = 'Date', FRA = 'Date';
        }
        field(5; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'code';
        }
        field(6; Comment; Text[80])
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        field(7; Display; Boolean)
        {
            CaptionML = ENU = 'Display', FRA = 'Afficher';
        }
    }
    keys
    {
        key(PK; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure SetUpNewLine()
    begin
        RegistrationCommentLine.SETRANGE("Document Type", "Document Type");
        RegistrationCommentLine.SETRANGE("No.", "No.");
        IF RegistrationCommentLine.ISEMPTY THEN
            Date := WORKDATE;
    end;

    var
        RegistrationCommentLine: Record "WDC-QA RegistrationCommentLine";
}
