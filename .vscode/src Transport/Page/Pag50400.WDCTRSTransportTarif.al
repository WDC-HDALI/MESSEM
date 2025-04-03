namespace MESSEM.MESSEM;

page 50400 "WDC-TRS Transport Tarif"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Transport Tariff', FRA = 'Tarifs transport';
    PageType = List;
    SourceTable = "WDC-TRS Transport Tarifs";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }

                field("Shipment Method code"; Rec."Shipment Method code")
                {
                    ApplicationArea = All;
                }
                field("Transport vendor No."; Rec."Transport vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Transport Rate"; Rec."Transport Rate")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
