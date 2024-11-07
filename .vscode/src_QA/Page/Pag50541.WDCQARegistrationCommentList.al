namespace MessemMA.MessemMA;

page 50541 "WDC-QA RegistrationCommentList"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Registration Comment List', FRA = 'Liste des commentaires';
    Editable = false;
    PageType = List;
    SourceTable = "WDC-QA RegistrationCommentLine";
    CardPageId = "WDC-QARegistrationCommentSheet";
    DataCaptionFields = "Document Type";
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
                field(Comments; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
