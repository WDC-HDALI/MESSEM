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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;

                }
                field("Production Line Code"; Rec."Production Line Code")
                {
                    ApplicationArea = all;
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
                field("Source Document Line No."; Rec."Source Document Line No.")
                {
                    ApplicationArea = all;
                }
                field("Reference Source No."; Rec."Reference Source No.")
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
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
            }
            group("Return Order")
            {
                CaptionML = ENU = 'Purchase Return', FRA = 'Retour achat';
                field("Return Order Type"; Rec."Return Order Type")
                {
                    ApplicationArea = all;
                }
                field("Return Order No."; Rec."Return Order No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }

    }
    actions
    {
        area(Navigation)
        {
            group("&Registration")
            {
                captionML = ENU = '&Registration', FRA = '&Enregistrement';
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Image = ViewComments;
                    CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
                    RunObject = page "WDC-QA RegistrationCommentList";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                action("Information &Lot No.s")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Information &Lot No.s', FRA = 'Information N° &lot';
                    Image = LotInfo;
                    trigger OnAction()
                    begin
                        ActivateLotNoInfo;
                    end;
                }
            }
        }
        area(Processing)
        {
            group("Fonction&s")
            {
                CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
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
                action("&Change Lot No. Info")
                {
                    CaptionML = ENU = '&Change Lot No. Info', FRA = '&Modifier info N° lot';
                    Image = Change;
                    Ellipsis = true;
                    trigger OnAction()
                    var
                        LotNoInformation: Record "Lot No. Information";
                        LotInspection: Codeunit "WDC-QA Lot Inspection";
                    begin
                        LotNoInformation.GET(Rec."Item No.", Rec."Variant Code", Rec."Lot No.");
                        LotInspection.SetSourceValues(1, Rec."Document Type".AsInteger(), Rec."No.");
                        LotInspection.ModifyLotInfo(LotNoInformation, TRUE);
                    end;
                }
                action("Create &Return Order")
                {
                    CaptionML = ENU = 'Create &Return Order', FRA = 'Créer &retour';
                    Image = NewWarehouseShipment;
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        CLEAR(QualityControlMgt);
                        QualityControlMgt.CheckExistingReturnOrder(Rec);

                        CLEAR(CreateReturnOrder);
                        CurrPage.SETSELECTIONFILTER(RegistrationHeader);
                        CreateReturnOrder.SETTABLEVIEW(RegistrationHeader);
                        CreateReturnOrder.SetItemNo(Rec."Item No.");
                        CreateReturnOrder.RUNMODAL;
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
                action("&Release Warehouse Documents")
                {
                    CaptionML = ENU = '&Release Warehouse Documents', FRA = 'Lancer Document Entrepôt';
                    Visible = ActionReleaseWhseDocAndCloseVisible;
                    trigger OnAction()
                    begin
                        Rec.ReleaseWhseDocument;
                    end;
                }
                action("&Release Warehouse Documents and Close")
                {
                    CaptionML = ENU = '&Release Warehouse Documents and Close', FRA = '&Lancer document entrepôt et Clôturer';
                    Image = Close;
                    Visible = ActionReleaseWhseDocAndCloseVisible;
                    trigger OnAction()
                    begin
                        Rec.VALIDATE(Status, Rec.Status::Closed);
                        Rec.MODIFY;
                        Rec.ReleaseWhseDocument;
                    end;
                }
            }
            action("&Print")
            {
                CaptionML = ENU = '&Print', FRA = '&Imprimer';
                Image = Print;
                PromotedCategory = Process;
                Promoted = true;
                trigger OnAction()
                var
                    myInt: Integer;
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

    trigger OnAfterGetRecord()
    begin
        // GetAtrributes;
    end;

    procedure ActivateLotNoInfo()
    var
        LotNoInformationList2: Page "WDC-QA Lot No InformationList2";
        LotNoInformation: Record "Lot No. Information";
    begin
        LotNoInformation.SETFILTER("Item No.", Rec."Item No.");
        LotNoInformation.SETFILTER("Variant Code", Rec."Variant Code");
        LotNoInformation.SETFILTER("Lot No.", Rec."Lot No.");
        LotNoInformation.SETFILTER("Item Category Code", Rec."Item Category Code");
        LotNoInformationList2.SETTABLEVIEW(LotNoInformation);
        LotNoInformationList2.SetSourceValues(1, Rec."Document Type".AsInteger(), Rec."No.");
        LotNoInformationList2.RUNMODAL;
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

    local procedure OnTimer()
    begin
        CurrPage.CalibraionLines.PAGE.GetCurrentRecord(RegistrationLine);
        NewPosition := RegistrationLine.GETPOSITION;
        NewMethod := RegistrationLine."Method No.";
        IF (OldPosition <> NewPosition) OR (OldMethod <> NewMethod) THEN BEGIN
            RegistrationStep.SETRANGE("Document Type", RegistrationLine."Document Type");
            RegistrationStep.SETFILTER("Document No.", RegistrationLine."Document No.");
            RegistrationStep.SETRANGE("Line No.", RegistrationLine."Line No.");
            CurrPage.CalibrationSteps.PAGE.SETTABLEVIEW(RegistrationStep);
            CurrPage.CalibrationSteps.PAGE.Update();
            OldPosition := NewPosition;
            OldMethod := NewMethod;
        END;
    end;

    // local procedure GetAtrributes()
    // var
    //     LotAttributeManagement: Codeunit "WDC Lot Attribute Mngmt";
    // begin
    //     CLEAR(LotAttributes);
    //     IF Rec."Lot No." <> '' THEN
    //         LotAttributeManagement.GetLotAttributes(LotAttributes, Rec."Item No.", Rec."Variant Code", Rec."Lot No.", 0, 0, '', 0, '', 0);
    // end;

    var
        RegistrationHeader: Record "WDC-QA Registration Header";
        RegistrationLine: Record "WDC-QA Registration Line";
        RegistrationStep: Record "WDC-QA Registration Step";
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";
        NewPosition: Text[250];
        OldPosition: Text[250];
        NewMethod: Text[30];
        OldMethod: Text[30];
        CreateReturnOrder: Report "WDC-QACreateRegistrReturnOrder";
        LotAttributes: array[5] of Code[20];
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";

        DocPrint: Codeunit "WDC-QA Document-Print";
        ActionReleaseWhseDocAndCloseVisible: Boolean;
}
