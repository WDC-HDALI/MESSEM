page 50537 "WDC-QA Closed QC Specif Subfor"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-QA Specification Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                    ApplicationArea = all;
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                    ApplicationArea = all;
                }
                field("No. Of Samples"; Rec."No. Of Samples")
                {
                    ApplicationArea = all;
                }
                field("Type Of Result"; Rec."Type Of Result")
                {
                    ApplicationArea = all;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = all;
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                    ApplicationArea = all;
                }
                field("Target Result Value"; Rec."Target Result Value")
                {
                    ApplicationArea = all;
                }
                field("Upper Warning Limit"; Rec."Upper Warning Limit")
                {
                    ApplicationArea = all;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = all;
                }
                field("Target Result Option"; Rec."Target Result Option")
                {
                    ApplicationArea = all;
                }
                field("Result UOM"; Rec."Result UOM")
                {
                    ApplicationArea = all;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Specification Steps")
            {
                ApplicationArea = ALL;
                CaptionML = ENU = 'Specification Steps', FRA = 'Etapes de spécification';
                trigger OnAction()
                begin
                    ShowSpecificationSteps;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IF SpecificationHeader.GET(Rec."Document Type", Rec."Document No.", Rec."Version No.") THEN
            CurrPage.EDITABLE(SpecificationHeader.Status <> SpecificationHeader.Status::Closed)
        ELSE
            CurrPage.EDITABLE(FALSE);
    end;

    procedure ShowSpecificationSteps()
    var
    begin
        SpecificationStep.SETRANGE("Document Type", Rec."Document Type");
        SpecificationStep.SETFILTER("Document No.", Rec."Document No.");
        SpecificationStep.SETFILTER("Version No.", Rec."Version No.");
        SpecificationStep.SETRANGE("Line No.", Rec."Line No.");
        PAGE.RUNMODAL(0, SpecificationStep);
    end;

    var
        SpecificationHeader: Record "WDC-QA Specification Header";
        SpecificationStep: Record "WDC-QA Specification Step";
}
