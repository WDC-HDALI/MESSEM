page 50516 "WDC-QA CoA Template List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'CoA Template List', FRA = 'Liste modèle certificat d''analyse';
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
                }
                field("Type"; Rec."Type")
                {
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Alternative Item No."; Rec."Alternative Item No.")
                {
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                }
                field("Type Value"; Rec."Type Value")
                {
                }
            }
        }
    }
}
