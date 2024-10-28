page 50523 "WDC-QA Calibration Specif"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Registration', FRA = 'Enregistrement CQ clôturé';
    PageType = Document;
    SourceTable = "WDC-QA Specification Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(QC), Status = CONST(Closed));
    Editable = false;
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
        }
    }
}
