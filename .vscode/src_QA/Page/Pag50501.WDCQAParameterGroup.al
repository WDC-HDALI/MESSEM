page 50501 "WDC-QA Parameter Group"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Parameter Groups', FRA = 'Groupes de paramètres';
    PageType = List;
    SourceTable = "WDC-QA Parameter Group";
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
