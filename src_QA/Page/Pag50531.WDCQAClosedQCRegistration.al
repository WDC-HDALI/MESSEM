page 50531 "WDC-QA Closed QC Registration"
{
    ApplicationArea = All;
    Caption = 'WDC-QA Closed QC Registration';
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";

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
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                }
                field("Check Point Code"; Rec."Check Point Code")
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
                field("Sample No."; Rec."Sample No.")
                {
                }
                field("Internal Reference No."; Rec."Internal Reference No.")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("QC Date"; Rec."QC Date")
                {
                }
                field("QC Time"; Rec."QC Time")
                {
                }
                field("Sample Temperature"; Rec."Sample Temperature")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Production Line Code"; Rec."Production Line Code")
                {
                }
                field("Control Reason"; Rec."Control Reason")
                {
                }
                field("Lot No."; Rec."Lot No.")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                }
                field("Production Date"; Rec."Production Date")
                {
                }
            }
        }
    }
}
