page 50003 "WDC Transport Tariff Codes"
{
    Caption = 'Transport Tariff Codes';
    PageType = List;
    SourceTable = "WDC Transport Tariff Code";

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
                Caption = '&Transport';
                action("Transport &Tariff Code Rates")
                {
                    ApplicationArea = all;
                    Caption = 'Transport &Tariff Code Rates';
                    Image = RollUpCosts;
                    RunObject = Page "WDC Transp. Tariff Code Rates";
                    RunPageLink = "Transport Tariff Code" = FIELD(Code);
                }
            }
        }
    }
}

