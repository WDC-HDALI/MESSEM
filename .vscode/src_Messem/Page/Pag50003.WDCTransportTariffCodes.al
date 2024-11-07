page 50003 "WDC Transport Tariff Codes"
{
    CaptionML = ENU = 'Transport Tariff Codes', FRA = 'Codes tarif transport';
    PageType = List;
    SourceTable = "WDC Transport Tariff Code";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Transport Rate per"; Rec."Transport Rate per")
                {
                    ApplicationArea = all;
                }
                field("Sales Cost Transport Rate 1"; Rec."Sales Cost Transport Rate 1")
                {
                    ApplicationArea = all;
                }
                field("Sales Cost Transport Rate 2"; Rec."Sales Cost Transport Rate 2")
                {
                    ApplicationArea = all;
                }
                field("Sales Cost Transport Rate 3"; Rec."Sales Cost Transport Rate 3")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Transport")
            {
                CaptionML = ENU = '&Transport', FRA = 'Transport';
                action("Transport &Tariff Code Rates")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Transport &Tariff Code Rates', FRA = 'Transport & code tarifs ';
                    Image = RollUpCosts;
                    RunObject = Page "WDC Transp. Tariff Code Rates";
                    RunPageLink = "Transport Tariff Code" = FIELD(Code);
                }
            }
        }
    }
}

