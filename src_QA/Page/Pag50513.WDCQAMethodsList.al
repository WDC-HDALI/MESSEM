page 50513 "WDC-QA Methods List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Methods List', FRA = 'Liste de méthodes';
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
                }
                field(Description; Rec.Description)
                {
                }
                field("Result Type"; Rec."Result Type")
                {
                }
                field(Formula; Rec.Formula)
                {
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                }
                field("Result UOM"; Rec."Result UOM")
                {
                }
            }
        }
    }
}
