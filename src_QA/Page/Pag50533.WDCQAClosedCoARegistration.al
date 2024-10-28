page 50533 "WDC-QA Closed CoA Registration"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed CoA Registration', FRA = 'Enregistrement certificat d''analyse clôturé';
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";

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
                field("Lot No."; Rec."Lot No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("QC Date"; Rec."QC Date")
                {
                }
                field("QC Time"; Rec."QC Time")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            part(CalibrationLines; "WDC-QA Closed CoA Regist Subf")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(CalibrationSteps; "WDC-QA Registration Steps")
            {
                //SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
            }
        }
    }
}
