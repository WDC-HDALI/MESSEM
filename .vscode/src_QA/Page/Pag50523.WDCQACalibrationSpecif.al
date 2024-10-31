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
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Version Date"; Rec."Version Date")
                {
                    ApplicationArea = all;
                }
                field("Revised By"; Rec."Revised By")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
