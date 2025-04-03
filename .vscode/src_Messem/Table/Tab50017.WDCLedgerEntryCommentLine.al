table 50017 "WDC Ledger Entry Comment Line"
{
    CaptionML = ENU = 'Ledger Entry Comment Line', FRA = 'Ligne commentaire écriture';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Ledger Entry Type"; Integer)
        {
            CaptionML = ENU = 'Ledger Entry Type', FRA = 'Type écriture compta.';
            Editable = false;
        }
        field(2; "Ledger Entry No."; Integer)
        {
            CaptionML = ENU = 'Ledger Entry No.', FRA = 'N° écriture comptable';
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        field(10; Comment; Text[250])
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
    }

    keys
    {
        key(Key1; "Ledger Entry Type", "Ledger Entry No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure DeleteLedgerentryCommentLines(LedgerEntryType: Integer; LedgerEntryNo: Integer)
    var
        LedgerEntryCommentLine: Record "WDC Ledger Entry Comment Line";
    begin
        LedgerEntryCommentLine.SETRANGE("Ledger Entry Type", LedgerEntryType);
        LedgerEntryCommentLine.SETRANGE("Ledger Entry No.", LedgerEntryNo);
        IF NOT LedgerEntryCommentLine.ISEMPTY THEN
            LedgerEntryCommentLine.DELETEALL(TRUE);
    end;

    procedure CreateLedgerEntryCommentLine(LedgerEntryType: Integer; LedgerEntryNo: Integer; CommentText: Text[250])
    var
        LedgerEntryCommentLine: Record "WDC Ledger Entry Comment Line";
    begin
        LedgerEntryCommentLine.INIT;
        LedgerEntryCommentLine."Ledger Entry Type" := LedgerEntryType;
        LedgerEntryCommentLine."Ledger Entry No." := LedgerEntryNo;
        LedgerEntryCommentLine."Line No." := GetLastLineNo(LedgerEntryType, LedgerEntryNo) + 10000;
        LedgerEntryCommentLine.Comment := CommentText;
        LedgerEntryCommentLine.INSERT(TRUE);
    end;

    procedure GetLastLineNo(LedgerEntryType: Integer; LedgerEntryNo: Integer): Integer
    var
        LedgerEntryCommentLine: Record "WDC Ledger Entry Comment Line";
    begin
        LedgerEntryCommentLine.SETRANGE("Ledger Entry Type", LedgerEntryType);
        LedgerEntryCommentLine.SETRANGE("Ledger Entry No.", LedgerEntryNo);
        IF LedgerEntryCommentLine.FINDLAST THEN
            EXIT(LedgerEntryCommentLine."Line No.");

        EXIT(0);
    end;
}
