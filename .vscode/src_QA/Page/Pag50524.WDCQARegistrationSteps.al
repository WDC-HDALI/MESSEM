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
                    Editable = "Value MeasuredEditable";
                }
                field("Value UOM"; Rec."Value UOM")
                {
                    ApplicationArea = all;
                }
                field("Option Measured"; Rec."Option Measured")
                {
                    ApplicationArea = all;
                    Editable = "Option MeasuredEditable";
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
                RunObject = XMLport "WDC-QA Import Result Line CQ";
            }
        }
    }
    trigger OnInit()
    begin
        "Option MeasuredEditable" := TRUE;
        "Value MeasuredEditable" := TRUE;
    end;

    trigger OnAfterGetCurrRecord()
    var
        MakeValueEditable: Boolean;
        MakeOptionEditable: Boolean;
    begin
        MakeValueEditable := FALSE;
        MakeOptionEditable := FALSE;
        IF RegistrationHeader.GET(Rec."Document Type", Rec."Document No.") THEN BEGIN
            MakeValueEditable := (RegistrationHeader.Status <> RegistrationHeader.Status::Closed) AND
                                 (Rec."Type of Measure" = Rec."Type of Measure"::Value);
            MakeOptionEditable := (RegistrationHeader.Status <> RegistrationHeader.Status::Closed) AND
                                  (Rec."Type of Measure" = Rec."Type of Measure"::Option);
        END;

        "Value MeasuredEditable" := MakeValueEditable;
        "Option MeasuredEditable" := MakeOptionEditable;
    end;

    procedure UpdateForm()
    begin
        CurrPage.UPDATE;
    end;

    var
        RegistrationHeader: Record "WDC-QA Registration Header";
        "Value MeasuredEditable": Boolean;
        "Option MeasuredEditable": Boolean;
}
