page 50517 "WDC-QA CoA Template"
{
    ApplicationArea = All;
    CaptionML = ENU = 'CoA Template', FRA = 'Modèle certificat d''analyse';
    PageType = ListPlus;
    SourceTable = "WDC-QA CoA Template";
    InsertAllowed = true;
    DeleteAllowed = true;
    DelayedInsert = true;
    AutoSplitKey = true;

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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type
    end;
}
