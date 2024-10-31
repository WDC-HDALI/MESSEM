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
                    ApplicationArea = all;
                }
                field("Parameter Description"; Rec."Parameter Description")
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
}
