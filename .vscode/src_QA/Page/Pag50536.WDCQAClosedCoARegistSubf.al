page 50536 "WDC-QA Closed CoA Regist Subf"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-QA Registration Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ApplicationArea = all;
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = all;
                }
                field("Text Description"; Rec."Text Description")
                {
                    ApplicationArea = all;
                }
                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Specification Remark"; Rec."Specification Remark")
                {
                    ApplicationArea = all;
                    Editable = "Specification RemarkEditable";
                }
                field("Item No. HF"; Rec."Item No. HF")
                {
                    ApplicationArea = all;
                }
                field("Lot No. HF"; Rec."Lot No. HF")
                {
                    ApplicationArea = all;
                }
                field("Item No. EP"; Rec."Item No. EP")
                {
                    ApplicationArea = all;
                }
                field("Lot No. EP"; Rec."Lot No. EP")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
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
                    Editable = "Lower LimitEditable";
                }
                field("Lower Warning Limit"; Rec."Lower Warning Limit")
                {
                    ApplicationArea = all;
                    Editable = "Lower Warning LimitEditable";
                }
                field("Target Result value"; Rec."Target Result value")
                {
                    ApplicationArea = all;
                    Editable = "Target Result valueEditable";
                }
                field("Upper Warning Limit"; Rec."Upper Warning Limit")
                {
                    ApplicationArea = all;
                    Editable = "Upper Warning LimitEditable";
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = all;
                    Editable = "Upper LimitEditable";
                }
                field("Target Result Option"; Rec."Target Result Option")
                {
                    ApplicationArea = all;
                    Editable = "Target Result OptionEditable";
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field("CoA Type Value"; Rec."CoA Type Value")
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
                    Visible = "Conclusion ResultVisible";
                }
                field("Conclusion Average Result"; Rec."Conclusion Average Result")
                {
                    ApplicationArea = all;
                    Visible = ConclusionAverageResultVisible;
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
        UpdateFieldsVisible;
    end;

    trigger OnAfterGetRecord()
    begin
        IF RegistrationHeader.GET(Rec."Document Type", Rec."Document No.") THEN
            CurrPage.EDITABLE(RegistrationHeader.Status <> RegistrationHeader.Status::Closed)
        ELSE
            CurrPage.EDITABLE(FALSE);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IF RegistrationHeader.GET(Rec."Document Type", Rec."Document No.") THEN
            IF RegistrationHeader.Status <> RegistrationHeader.Status::Closed THEN BEGIN
                "Specification RemarkEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Lower LimitEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Lower Warning LimitEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Target Result valueEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Upper Warning LimitEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Upper LimitEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Value);
                "Target Result OptionEditable" := (Rec."Specification No." = '') AND (Rec."Type of Result" = Rec."Type of Result"::Option);
            END;
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
        ConclusionAverageResultVisible: Boolean;
}
