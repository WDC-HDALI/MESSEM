namespace MessemMA.MessemMA;

page 50541 "WDC-QA RegistrationCommentList"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Registration Comment List', FRA = 'Liste des commentaires';
    Editable = false;
    PageType = List;
    SourceTable = "WDC-QA RegistrationCommentLine";
    CardPageId = "WDC-QARegistrationCommentSheet";
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
