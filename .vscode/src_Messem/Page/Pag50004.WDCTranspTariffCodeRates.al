page 50004 "WDC Transp. Tariff Code Rates"
{
    CaptionML = ENU = 'Transport Tariff Code Rates', FRA = 'Affectation tarifs transport';
    DataCaptionFields = "No.", "Transport Tariff Code";
    PageType = List;
    SourceTable = "WDC Transport Tariff Code Rate";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;

                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Transport Tariff Code"; Rec."Transport Tariff Code")
                {
                    ApplicationArea = all;
                }
                field("Transport Rate per"; Rec."Transport Rate per")
                {
                    ApplicationArea = all;
                }
                field("Shipment Container"; Rec."Shipment Container")
                {
                    ApplicationArea = all;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = all;
                }
                field("Transport Rate Excl. Rise"; Rec."Transport Rate Excl. Rise")
                {
                    ApplicationArea = all;
                }

                field("Transport Rate"; Rec."Transport Rate")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Stop Rate"; Rec."Stop Rate")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


}

