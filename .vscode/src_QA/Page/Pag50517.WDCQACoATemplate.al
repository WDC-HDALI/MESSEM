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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := xRec.Type
    end;
}
