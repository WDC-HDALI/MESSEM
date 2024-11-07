namespace MessemMA.MessemMA;

page 50542 "WDC-QARegistrationCommentSheet"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Comment Sheet', FRA = 'Feuille de commentaires';
    PageType = List;
    SourceTable = "WDC-QA RegistrationCommentLine";
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    DataCaptionFields = "Document Type", "No.";
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = ALL;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = ALL;
                }
                field(Display; Rec.Display)
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.SetUpNewLine;
    end;
}
