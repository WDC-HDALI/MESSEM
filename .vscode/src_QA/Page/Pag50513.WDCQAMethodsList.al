page 50513 "WDC-QA Methods List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Methods', FRA = 'Méthodes';
    PageType = List;
    SourceTable = "WDC-QA Method Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA Methods";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Result Type"; Rec."Result Type")
                {
                    ApplicationArea = all;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                    ApplicationArea = all;
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                    ApplicationArea = all;
                }
                field("Result UOM"; Rec."Result UOM")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
