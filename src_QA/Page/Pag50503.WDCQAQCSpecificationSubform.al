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
                }
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                }
                field(Imprimable; Rec.Imprimable)
                {
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Type"; Rec."Type")
                {
                }
                field("Texte Specification Option"; Rec."Texte Specification Option")
                {
                }
                field("Parameter Description"; Rec."Parameter Description")
                {
                    Visible = false;
                }
                field("Method No."; Rec."Method No.")
                {
                }
                field("Method Description"; Rec."Method Description")
                {
                    Visible = false;
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                }
                field("No. Of Samples"; Rec."No. Of Samples")
                {
                }
                field("Type Of Result"; Rec."Type Of Result")
                {
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                }
                field("Target Result Value"; Rec."Target Result Value")
                {
                }
                field("Upper Warning Limit"; Rec."Upper Warning Limit")
                {
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                }
                field("Target Result Option"; Rec."Target Result Option")
                {
                }
                field("Result UOM"; Rec."Result UOM")
                {
                }
                field(Formula; Rec.Formula)
                {
                }
                field(Remark; Rec.Remark)
                {
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
