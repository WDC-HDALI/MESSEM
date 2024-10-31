namespace MessemMA.MessemMA;

page 50540 "WDC-QA ClosedQCRegistrationSub"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-QA Registration Line";
    DelayedInsert = true;
    LinksAllowed = false;
    AutoSplitKey = true;
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
                field("Measure No."; Rec."Measure No.")
                {
                    ApplicationArea = all;
                }
                field("User Code"; Rec."User Code")
                {
                    ApplicationArea = all;
                }
                field("Method Description"; Rec."Method Description")
                {
                    ApplicationArea = all;
                }
                field("Specification Remark"; Rec."Specification Remark")
                {
                    ApplicationArea = all;
                }
                field("Type of Result"; Rec."Type of Result")
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
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = all;
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                    ApplicationArea = all;
                }
                field("Target Result value"; Rec."Target Result value")
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
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field("Result Value"; Rec."Result Value")
                {
                    ApplicationArea = all;
                }
                field("Result Value UOM"; Rec."Result Value UOM")
                {
                    ApplicationArea = all;
                }
                field("Average Result Value"; Rec."Average Result Value")
                {
                    ApplicationArea = all;
                }
                field("Result Option"; Rec."Result Option")
                {
                    ApplicationArea = all;
                }
                field("Average Result Option"; Rec."Average Result Option")
                {
                    ApplicationArea = all;
                }
                field("Conclusion Result"; Rec."Conclusion Result")
                {
                    ApplicationArea = all;
                }
                field("Conclusion Average Result"; Rec."Conclusion Average Result")
                {
                    ApplicationArea = all;
                }
                field("QC Date"; Rec."QC Date")
                {
                    ApplicationArea = all;
                }
                field("QC Time"; Rec."QC Time")
                {
                    ApplicationArea = all;
                }
                field("Sample Temperature"; Rec."Sample Temperature")
                {
                    ApplicationArea = all;
                }
                field(Controller; Rec.Controller)
                {
                    ApplicationArea = all;
                }
                field("Control Date Average result"; Rec."Control Date Average result")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnInit()
    begin
        "Target Result OptionEditable" := TRUE;
        "Upper LimitEditable" := TRUE;
        "Upper Warning LimitEditable" := TRUE;
        "Target Result valueEditable" := TRUE;
        "Lower Warning LimitEditable" := TRUE;
        "Lower LimitEditable" := TRUE;
        "Specification RemarkEditable" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        UpdateFieldsVisible();
    end;

    trigger OnAfterGetRecord()
    begin
        IF RegistrationHeader.GET(ReC."Document Type", Rec."Document No.") THEN
            CurrPage.EDITABLE(RegistrationHeader.Status <> RegistrationHeader.Status::Closed)
        ELSE
            CurrPage.EDITABLE(FALSE);
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
                                 (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
            MakeOptionEditable := (RegistrationHeader.Status <> RegistrationHeader.Status::Closed) AND
                                 (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Option);
        END;

        "Specification RemarkEditable" := MakeValueEditable;
        "Lower LimitEditable" := MakeValueEditable;
        "Lower Warning LimitEditable" := MakeValueEditable;
        "Target Result valueEditable" := MakeValueEditable;
        "Upper Warning LimitEditable" := MakeValueEditable;
        "Upper LimitEditable" := MakeValueEditable;

        "Target Result OptionEditable" := MakeOptionEditable;
    end;

    procedure GetCurrentRecord(var CalibrationRegistrationLine: Record "WDC-QA Registration Line")
    begin
        CalibrationRegistrationLine := Rec;
    end;

    procedure CreateSecondSample()
    begin
        QualityControlMgt.CreateSecondSampling(Rec);
    end;

    procedure LineUp()
    begin
        IF Rec.NEXT(-1) >= 0 THEN;
        CurrPage.UPDATE(FALSE);
    end;

    procedure LineDown()
    begin
        IF Rec.NEXT <= 0 THEN;
        CurrPage.UPDATE(FALSE);
    end;

    procedure UpdateFieldsVisible()
    begin
        "Conclusion ResultVisible" := TRUE;
        ConclusionAverageResultVisible := TRUE;
    end;

    var
        RegistrationHeader: Record "WDC-QA Registration Header";
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
        "Specification RemarkEditable": Boolean;
        "Lower LimitEditable": Boolean;
        "Lower Warning LimitEditable": Boolean;
        "Target Result valueEditable": Boolean;
        "Upper Warning LimitEditable": Boolean;
        "Upper LimitEditable": Boolean;
        "Target Result OptionEditable": Boolean;
        "Conclusion ResultVisible": Boolean;
        "ConclusionAverageResultVisible": Boolean;
}
