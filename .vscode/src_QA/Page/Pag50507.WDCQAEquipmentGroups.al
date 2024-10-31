page 50507 "WDC-QA Equipment Groups"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Equipment Groups', FRA = 'Groupes d''équipements';
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
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
