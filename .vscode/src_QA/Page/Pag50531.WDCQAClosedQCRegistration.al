page 50531 "WDC-QA Closed QC Registration"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Registration', FRA = 'Enregistrement CQ clôturé';
    Editable = false;
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(QC), Status = CONST(Closed));
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
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                    ApplicationArea = all;
                }
                field(Specific; Rec.Specific)
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = all;
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
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
                field("Control Reason"; Rec."Control Reason")
                {
                    ApplicationArea = all;
                }
            }
            part(CalibraionLines; "WDC-QA ClosedQCRegistrationSub")
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
            group(LotInfo)
            {
                CaptionML = ENU = 'Lot Info', FRA = 'Info lot';
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
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
                action("R&ouvrir")
                {
                    CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
                    Image = ReOpen;
                    trigger OnAction()
                    var
                        RegistrationHdr: Record "WDC-QA Registration Header";
                    begin
                        RegistrationHdr := Rec;
                        RegistrationHdr.Status := RegistrationHdr.Status::Open;
                        RegistrationHdr.MODIFY;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("&Print")
            {
                CaptionML = ENU = '&Print', FRA = '&Imprimer';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    DocPrint.PrintQCRegistration(Rec);
                end;
            }
            action("Print QC Reg.")
            {
                CaptionML = ENU = 'Print QC Reg.', FRA = 'Imprimer Enreg. CQ';
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
    LOCAL procedure StatusOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    var
        DocPrint: Codeunit "WDC-QA Document-Print";
}
