page 50538 "WDC-QA Closed Calib Spec Subfo"
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
                field("Parameter Description"; Rec."Parameter Description")
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
}
