page 50507 "WDC-QA Equipment Groups"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Equipment Groups', FRA = 'Groupes d''equipements';
    PageType = List;
    SourceTable = "WDC-QA Equipment Group";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
