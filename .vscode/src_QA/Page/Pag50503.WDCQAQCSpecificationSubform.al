page 50503 "WDC-QA QCSpecification Subform"
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
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                    ApplicationArea = all;
                }
                field(Imprimable; Rec.Imprimable)
                {
                    Style = Attention;
                    StyleExpr = true;
                    ApplicationArea = all;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;
                }
                field("Texte Specification Option"; Rec."Texte Specification Option")
                {
                    ApplicationArea = all;
                }
                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Method Description"; Rec."Method Description")
                {
                    ApplicationArea = All;
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
    trigger OnAfterGetRecord()
    var
        SpecificationHeader: Record "WDC-QA Specification Header";
    begin
        If SpecificationHeader.Get(Rec."Document Type", Rec."Document No.", Rec."Version No.") then
            CurrPage.Editable(SpecificationHeader.Status <> SpecificationHeader.Status::Closed)
        else
            CurrPage.Editable(false);
    end;

    procedure ShowSpecificationSteps()
    var
        SpecificationStep: Record "WDC-QA Specification Step";
    begin
        SpecificationStep.SETRANGE("Document Type", Rec."Document Type");
        SpecificationStep.SETFILTER("Document No.", Rec."Document No.");
        SpecificationStep.SETFILTER("Version No.", Rec."Version No.");
        SpecificationStep.SETRANGE("Line No.", Rec."Line No.");
        PAGE.RUNMODAL(0, SpecificationStep);
    end;
}
