page 50535 "WDC-QA Closed QC Specification"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Specification', FRA = 'Spécification CQ clôturée';
    PageType = Document;
    SourceTable = "WDC-QA Specification Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
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
                field("Check Point Code"; Rec."Check Point Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Specific; Rec.Specific)
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
            }
            part(CalibrationLines; "WDC-QA Closed QC Specif Subfor")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Version No." = FIELD("Version No.");
            }
        }
    }
}
