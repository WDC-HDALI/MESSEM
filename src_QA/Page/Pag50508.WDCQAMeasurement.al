page 50508 "WDC-QA Measurement"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Measurements', FRA = 'Mesures';
    PageType = List;
    SourceTable = "WDC-QA Measurement";
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
