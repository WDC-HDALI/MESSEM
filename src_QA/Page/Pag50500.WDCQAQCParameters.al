page 50500 "WDC-QA QC Parameters"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Parameters', FRA = 'Paramètres CQ';
    PageType = List;
    SourceTable = "WDC-QA Parameter";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field("Type"; Rec."Type")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                }
                field("Method No."; Rec."Method No.")
                {
                }
                field("Decimal Point"; Rec."Decimal Point")
                {
                }
            }
        }
    }
}
