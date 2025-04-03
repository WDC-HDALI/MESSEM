namespace MESSEM.MESSEM;

page 50523 "WDC-QA Size"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Size', FRA = 'Calibre';
    PageType = List;
    SourceTable = "WDC-QA Size";
    //UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Size; Rec.Size)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
