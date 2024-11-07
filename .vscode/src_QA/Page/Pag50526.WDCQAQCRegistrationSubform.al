page 50526 "WDC-QA QC Registration Subform"
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
                field(StepCountText; StepCountText)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionML = ENU = 'Steps Filled In', FRA = 'Étapes remplies';
                }
                field("Parameter Code"; Rec."Parameter Code")
                {
                    ApplicationArea = all;
                }

                field("Method No."; Rec."Method No.")
                {
                    ApplicationArea = all;
                }
                field("Is Second Sampling"; Rec."Is Second Sampling")
                {
                    ApplicationArea = all;
                }
                field("User Code"; Rec."User Code")
                {
                    ApplicationArea = all;
                }
                field("Control Date"; Rec."Control Date")
                {
                    ApplicationArea = all;
                }

                field("Specification Remark"; Rec."Specification Remark")
                {
                    Editable = "Specification RemarkEditable";
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
                field("Result Value"; Rec."Result Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Result Value UOM"; Rec."Result Value UOM")
                {

                    ApplicationArea = all;
                }
                field("Average Result Value"; Rec."Average Result Value")
                {
                    ApplicationArea = all;
                    Editable = FALSE;
                }
                field("Result Option"; Rec."Result Option")
                {
                    ApplicationArea = all;
                    Editable = FALSE;
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
                field("Pallet No."; Rec."Pallet No.")
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
    actions
    {
        area(Processing)
        {
            group(Function)
            {
                CaptionML = ENU = 'Function', FRA = 'Fonction';
                action("Create &Second Sampling")
                {
                    ApplicationArea = all;
                    //Image =;
                    CaptionML = ENU = 'Create &Second Sampling', FRA = 'Créer &deuxième analyse';
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        CreateSecondSample;
                    end;
                }
                action("Export Ligne")
                {
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        RecLLineCQ: Record "WDC-QA Registration Line";
                    begin
                        RecLLineCQ.RESET;
                        RecLLineCQ.SETRANGE("Document No.", Rec."Document No.");
                        IF RecLLineCQ.FINDSET THEN BEGIN
                            XMLPORT.RUN(50501, TRUE, FALSE, RecLLineCQ);
                        END;
                    end;
                }
                action("Update Second Sampling")
                {
                    ApplicationArea = all;
                    Image = UpdateShipment;
                    trigger OnAction()
                    var
                        RegistrationLine: Record "WDC-QA Registration Line";
                    begin
                        RegistrationLine.RESET;
                        RegistrationLine.SETRANGE("Document Type", Rec."Document Type");
                        RegistrationLine.SETRANGE("Document No.", Rec."Document No.");
                        IF RegistrationLine.FINDSET THEN
                            REPEAT
                                RegistrationLine."Is Second Sampling" := FALSE;
                                RegistrationLine.MODIFY
                            UNTIL RegistrationLine.NEXT = 0;
                    end;
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
        GetCounts;
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

    procedure GetCurrentRecord(VAR CalibrationRegistrationLine: Record "WDC-QA Registration Line")
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

    LOCAL procedure GetCounts()
    var
        ModifiedCount: Integer;
        MaxCount: Integer;
        Dummy1: Integer;
        Dummy2: Integer;
    begin
        Rec.GetStepCounts(ModifiedCount, MaxCount, Dummy1, Dummy2);
        StepCountText := STRSUBSTNO(txtXoutofY, ModifiedCount, MaxCount);
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
        StepCountText: Text[20];
        txtXoutofY: TextConst ENU = '%1 / %2', FRA = '%1 / %2';
}
