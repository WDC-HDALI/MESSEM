page 50521 "WDC-QA QC Registration"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Registration', FRA = 'Enregistrement CQ';
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(QC), Status = FILTER(<> Closed));
    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;

                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ItemNoOnAfterValidate;
                    end;

                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CheckPointCodeOnAfterValidate;
                    end;
                }
                field(Specific; Rec.Specific)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        SpecificOnAfterValidate;
                    end;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        SourceNoOnAfterValidate;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Sample No."; Rec."Sample No.")
                {
                    ApplicationArea = all;
                }
                field("Internal Reference No."; Rec."Internal Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
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
                    ApplicationArea = ALL;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
                field("Control Reason"; Rec."Control Reason")
                {
                    ApplicationArea = all;
                }
                field("Source Document Type"; Rec."Source Document Type")
                {
                    ApplicationArea = all;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = all;
                }
                field(Variety; Rec.Variety)
                {
                    ApplicationArea = ALL;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field("Source Document Line No."; Rec."Source Document Line No.")
                {
                    ApplicationArea = all;
                }
            }
            part(CalibraionLines; "WDC-QA QC Registration Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(CalibrationSteps; "WDC-QA Registration Steps")
            {
                ApplicationArea = all;
                Provider = CalibraionLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
            }
            group(Infolot)
            {
                CaptionML = ENU = 'Lot info', FRA = 'Info lot';
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = all;
                }
                field("Production Date"; Rec."Production Date")
                {
                    ApplicationArea = all;
                }
                field("Inspection Status"; Rec."Inspection Status")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }

    }
    actions
    {
        area(Navigation)
        {
            action("Co&mments")
            {
                ApplicationArea = all;
                Image = ViewComments;
                CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
                RunObject = page "WDC-QA RegistrationCommentList";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
            }
        }
        area(Processing)
        {
            action("Get Specification Lines")
            {
                CaptionML = ENU = 'Get Specification Lines', FRA = 'Extraire lignes spécification';
                Image = GetLines;
                Ellipsis = true;
                ShortcutKey = F9;
                trigger OnAction()
                begin
                    QualityControlMgt.GetSpecificationLines(Rec);
                end;
            }
            action("Create &Second Sampling Old")
            {
                CaptionML = ENU = 'Create &Second Sampling Old', FRA = 'Ajouter mesure';
                Image = CopyItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    CurrPage.CalibraionLines.Page.CreateSecondSamplingOld();
                end;
            }
            action("Calculate Result and Conclusion")
            {
                CaptionML = ENU = 'Calculate Result and Conclusion', FRA = 'Calculer résultat et conclusion';
                Image = Calculate;
                Ellipsis = true;
                ShortcutKey = 'Ctrl+F11';
                trigger OnAction()
                begin
                    QualityControlMgt.CalculateResult(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        area(Reporting)
        {
            action("&Print")
            {
                CaptionML = ENU = '&Print', FRA = '&Imprimer';
                Image = Print;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                begin
                    DocPrint.PrintQCRegistration(Rec);
                end;
            }
            action("Print Closed QC")
            {
                CaptionML = ENU = 'Print Closed QC', FRA = 'Imprimer Enreg. CQ';
                Image = Print;
                trigger OnAction()
                var
                    lRegistrationLine: Record "WDC-QA Registration Line";
                begin
                    lRegistrationLine.RESET;
                    lRegistrationLine.SETRANGE("Document Type", Rec."Document Type");
                    lRegistrationLine.SETRANGE("Document No.", Rec."No.");
                    IF lRegistrationLine.FINDFIRST THEN
                        REPORT.RUN(50503, TRUE, FALSE, lRegistrationLine);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        ActionReleaseWhseDocAndCloseVisible := FALSE;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ActionReleaseWhseDocAndCloseVisible := Rec."Source Document No." <> '';
    end;

    local procedure StatusOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    local procedure CheckPointCodeOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SpecificOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SourceNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ItemNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    var
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
        DocPrint: Codeunit "WDC-QA Document-Print";
        ActionReleaseWhseDocAndCloseVisible: Boolean;
}
