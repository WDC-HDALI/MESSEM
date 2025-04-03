namespace MESSEM.MESSEM;

page 50528 "WDC-QA QC Controllers"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Controllers', FRA = 'Contrôleurs CQ';
    PageType = List;
    SourceTable = "WDC-QA QC Controller";
    UsageCategory = Lists;

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
