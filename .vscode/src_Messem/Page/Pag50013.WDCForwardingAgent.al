namespace MessemMA.MessemMA;

page 50013 "WDC Forwarding Agent"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Forwarding Agent', FRA = 'Transitaire';
    PageType = List;
    SourceTable = "WDC Forwarding Agent";

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
                field("Agent Name"; rec."Agent Name")
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
            }
        }
    }
}
