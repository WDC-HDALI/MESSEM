namespace MessemMA.MessemMA;

page 50011 "WDC Harbor"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Harbor', FRA = 'Port';
    PageType = List;
    SourceTable = "WDC Harbor";

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Notify Party"; rec."Notify Party")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


}
