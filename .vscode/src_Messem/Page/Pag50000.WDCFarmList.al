page 50000 "WDC Farm List"
{

    captionml = ENU = 'Farm List', FRA = 'Liste ferme';
    PageType = List;
    SourceTable = "WDC Farm";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field("Farm No."; rec."Farm No.")
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }

            }
        }
    }


}

