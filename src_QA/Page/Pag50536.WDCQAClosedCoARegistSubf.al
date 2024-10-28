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
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                }
                field("Text Description"; Rec."Text Description")
                {
                }
                field("Parameter Group Code"; Rec."Parameter Group Code")
                {
                }
                field("Method No."; Rec."Method No.")
                {
                }
                field("Method Description"; Rec."Method Description")
                {
                }
                field("Specification Remark"; Rec."Specification Remark")
                {
                }
                field("Item No. HF"; Rec."Item No. HF")
                {
                }
                field("Lot No. HF"; Rec."Lot No. HF")
                {
                }
                field("Item No. EP"; Rec."Item No. EP")
                {
                }
                field("Lot No. EP"; Rec."Lot No. EP")
                {
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                }
                field("Type of Result"; Rec."Type of Result")
                {
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                }
                field("Target Result value"; Rec."Target Result value")
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
                field(Formula; Rec.Formula)
                {
                }
                field("CoA Type Value"; Rec."CoA Type Value")
                {
                }
                field("Result Value"; Rec."Result Value")
                {
                }
                field("Result Value UOM"; Rec."Result Value UOM")
                {
                }
                field("Average Result Value"; Rec."Average Result Value")
                {
                }
                field("Result Option"; Rec."Result Option")
                {
                }
                field("Average Result Option"; Rec."Average Result Option")
                {
                }
                field("Conclusion Result"; Rec."Conclusion Result")
                {
                }
                field("Conclusion Average Result"; Rec."Conclusion Average Result")
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
                field(Controller; Rec.Controller)
                {
                }
            }
        }
    }
}
