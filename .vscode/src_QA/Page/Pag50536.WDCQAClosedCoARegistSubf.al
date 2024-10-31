page 50536 "WDC-QA Closed CoA Regist Subf"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-QA Registration Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field("Text Description"; Rec."Text Description")
                {
                    ApplicationArea = all;
                }
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                    ApplicationArea = all;
                }
                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Method Description"; Rec."Method Description")
                {
                    ApplicationArea = all;
                }
                field("Specification Remark"; Rec."Specification Remark")
                {
                    ApplicationArea = all;
                }
                field("Item No. HF"; Rec."Item No. HF")
                {
                    ApplicationArea = all;
                }
                field("Lot No. HF"; Rec."Lot No. HF")
                {
                    ApplicationArea = all;
                }
                field("Item No. EP"; Rec."Item No. EP")
                {
                    ApplicationArea = all;
                }
                field("Lot No. EP"; Rec."Lot No. EP")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                    ApplicationArea = all;
                }
                field("Type of Result"; Rec."Type of Result")
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
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = all;
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                    ApplicationArea = all;
                }
                field("Target Result value"; Rec."Target Result value")
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
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field("CoA Type Value"; Rec."CoA Type Value")
                {
                    ApplicationArea = all;
                }
                field("Result Value"; Rec."Result Value")
                {
                    ApplicationArea = all;
                }
                field("Result Value UOM"; Rec."Result Value UOM")
                {
                    ApplicationArea = all;
                }
                field("Average Result Value"; Rec."Average Result Value")
                {
                    ApplicationArea = all;
                }
                field("Result Option"; Rec."Result Option")
                {
                    ApplicationArea = all;
                }
                field("Average Result Option"; Rec."Average Result Option")
                {
                    ApplicationArea = all;
                }
                field("Conclusion Result"; Rec."Conclusion Result")
                {
                    ApplicationArea = all;
                }
                field("Conclusion Average Result"; Rec."Conclusion Average Result")
                {
                    ApplicationArea = all;
                }
                field("QC Date"; Rec."QC Date")
                {
                    ApplicationArea = all;
                }
                field("QC Time"; Rec."QC Time")
                {
                    ApplicationArea = all;
                }
                field("Sample Temperature"; Rec."Sample Temperature")
                {
                    ApplicationArea = all;
                }
                field(Controller; Rec.Controller)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
