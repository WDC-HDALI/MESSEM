page 50518 "WDC-QA Certificates Of Analysi"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Certificates of Analysis', FRA = 'Certificats';
    PageType = List;
    SourceTable = "WDC-QA Certificate of Analysis";
    UsageCategory = Lists;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = all;
                }
                field("Automatically Printed"; Rec."Automatically Printed")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
