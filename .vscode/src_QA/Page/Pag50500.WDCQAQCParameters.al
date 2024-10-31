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
                    ApplicationArea = all;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                    ApplicationArea = all;
                }
                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Decimal Point"; Rec."Decimal Point")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
