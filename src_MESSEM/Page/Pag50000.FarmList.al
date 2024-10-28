page 50000 "WDC Farm List"
{

    captionml = ENU = 'Farm List', FRA = 'Liste ferme';
    PageType = List;
    SourceTable = Farm;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Code; rec.Code)
                {
                }
                field("Farm No."; rec."Farm No.")
                {
                }
                field(Désignation; rec.Désignation)
                {
                }

            }
        }
    }


}

