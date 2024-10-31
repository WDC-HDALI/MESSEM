page 50524 "WDC-QA Registration Steps"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Steps', FRA = 'Etapes';
    PageType = ListPart;
    SourceTable = "WDC-QA Registration Step";
    InsertAllowed = false;
    DelayedInsert = true;
    DeleteAllowed = false;
    DataCaptionFields = "Document Type", "Line No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Measure No."; Rec."Measure No.")
                {
                    ApplicationArea = all;
                }
                field("Column No."; Rec."Column No.")
                {
                    ApplicationArea = all;
                }
                field("Equipment Group Code"; Rec."Equipment Group Code")
                {
                    ApplicationArea = all;
                }

                field("Type of Measure"; Rec."Type of Measure")
                {
                    ApplicationArea = all;
                }
                field("Measurement Code"; Rec."Measurement Code")
                {
                    ApplicationArea = all;
                }
                field("Measurement Description"; Rec."Measurement Description")
                {
                    ApplicationArea = all;
                }
                field("Value Measured"; Rec."Value Measured")
                {
                    ApplicationArea = all;
                }
                field("Value UOM"; Rec."Value UOM")
                {
                    ApplicationArea = all;
                }
                field("Option Measured"; Rec."Option Measured")
                {
                    ApplicationArea = all;
                }
                field("Result Option"; Rec."Result Option")
                {
                    ApplicationArea = all;
                }
                field(Sample; Rec.Sample)
                {
                    ApplicationArea = all;
                }
                field("Method Remark"; Rec."Method Remark")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Result")
            {
                //RunObject="XMLport Import Result Line CQ";   
            }
        }
    }
}
