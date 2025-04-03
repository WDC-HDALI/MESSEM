namespace MESSEM.MESSEM;

page 50514 "WDC-QA Variety"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Variety', FRA = 'Variété';
    PageType = List;
    SourceTable = "WDC-QA Variety";
    //UsageCategory = Lists;
    CardPageId = "WDC-QA Variety";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Variety; Rec.Variety)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
