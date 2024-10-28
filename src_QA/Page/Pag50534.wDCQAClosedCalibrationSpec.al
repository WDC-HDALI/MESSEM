page 50534 "wDC-QA Closed Calibration Spec"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed Calibration Specification', FRA = 'Spéc. calibration clôturée';
    PageType = Document;
    SourceTable = "WDC-QA Specification Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';

                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Version No."; Rec."Version No.")
                {
                }
                field("Version Date"; Rec."Version Date")
                {
                }
                field("Revised By"; Rec."Revised By")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(CalibrationLines; "WDC-QA Closed Calib Spec Subfo")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Version No." = FIELD("Version No.");
            }
        }
    }
}
