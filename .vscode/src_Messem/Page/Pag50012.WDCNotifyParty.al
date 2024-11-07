namespace MessemMA.MessemMA;

page 50012 "WDC Notify Party"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Notify Party', FRA = 'Partie à notifier';
    PageType = List;
    SourceTable = "WDC Notify Party";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Désignation; rec.Désignation)
                {
                    ApplicationArea = all;
                }
                field(Adress; rec.Adress)
                {
                    ApplicationArea = all;
                }
                field("Phone No."; rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; rec."Mobile No.")
                {
                    ApplicationArea = all;
                }
                field("E-mail"; rec."E-mail")
                {
                    ApplicationArea = all;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                }
                field("Primary Contact No."; rec."Primary Contact No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}
