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
                }
                field("Column No."; Rec."Column No.")
                {
                }
                field("Equipment Group Code"; Rec."Equipment Group Code")
                {
                }

                field("Type of Measure"; Rec."Type of Measure")
                {
                }
                field("Measurement Code"; Rec."Measurement Code")
                {
                }
                field("Measurement Description"; Rec."Measurement Description")
                {
                }
                field("Value Measured"; Rec."Value Measured")
                {
                }
                field("Value UOM"; Rec."Value UOM")
                {
                }
                field("Option Measured"; Rec."Option Measured")
                {
                }
                field("Result Option"; Rec."Result Option")
                {
                }
                field(Sample; Rec.Sample)
                {
                }
                field("Method Remark"; Rec."Method Remark")
                {
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
