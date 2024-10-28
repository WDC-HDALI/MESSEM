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
                }
                field(Description; Rec.Description)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Report ID"; Rec."Report ID")
                {
                }
                field("Report Name"; Rec."Report Name")
                {
                }
                field("Automatically Printed"; Rec."Automatically Printed")
                {
                }
            }
        }
    }
}
