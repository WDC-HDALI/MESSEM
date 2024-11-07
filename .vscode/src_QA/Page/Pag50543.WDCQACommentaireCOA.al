namespace MessemMA.MessemMA;

page 50543 "WDC-QA Commentaire COA"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Commentaire COA', FRA = 'Commentaire COA';
    PageType = List;
    SourceTable = "WDC-QA Commentaire COA";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Commentaire COA"; Rec."Commentaire COA")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
