page 50516 "WDC-QA CoA Template List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'CoA Template', FRA = 'Modèles certificat d''analyse';
    PageType = List;
    SourceTable = "WDC-QA CoA Template";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA CoA Template";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Alternative Item No."; Rec."Alternative Item No.")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                    ApplicationArea = all;
                }
                field("Type Value"; Rec."Type Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
