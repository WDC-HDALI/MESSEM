page 50509 "WDC-QA Check Points"
{
    ApplicationArea = All;
    CaptionML = ENU = 'WDC-QA Check Points', FRA = 'Points de contrôles';
    PageType = List;
    SourceTable = "WDC-QA Check Point";
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
