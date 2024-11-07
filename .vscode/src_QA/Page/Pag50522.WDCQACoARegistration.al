page 50522 "WDC-QA CoA Registration"
{
    ApplicationArea = All;
    CaptionML = ENU = 'CoA Registration', FRA = 'Enregistrement certificat d''analyse';
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(CoA), Status = FILTER(<> Closed));

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
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        LotNoOnAfterValidate;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                }

                field("Item Description2"; Rec."Item Description2")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
            }
            part(CalibrationLines; "WDC-QA CoA RegistrationSubform")
            {
                ApplicationArea = all;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
            }
            part(CalibrationSteps; "WDC-QA Registration Steps")
            {
                ApplicationArea = all;
                Provider = CalibrationLines;
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No."), "Line No." = FIELD("Line No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("%Registration")
            {
                CaptionML = ENU = '&Registration', FRA = '&Enregistrement';
                action("Co&mments")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = page "Wdc-QARegistrationCommentSheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                }
                action("Page Commentaire COA")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = '', FRA = 'Insertion Commentaire COA';
                    Image = CalculateCalendar;
                    trigger OnAction()
                    begin
                        CLEAR(GRegistCommentLine);
                        GRegistCommentLine.SETRANGE("No.", Rec."No.");
                        IF GRegistCommentLine.FINDFIRST THEN
                            GRegistCommentLine.DELETEALL;

                        Gline := 10000;
                        CLEAR(GCommentCOA);
                        IF GCommentCOA.FINDFIRST THEN
                            REPEAT
                                Gline := Gline + 1000;
                                GRegistCommentLine.INIT;
                                GRegistCommentLine."Document Type" := Rec."Document Type";
                                GRegistCommentLine."No." := Rec."No.";
                                GRegistCommentLine."Line No." := Gline;
                                GRegistCommentLine.Date := Rec."QC Date";
                                GRegistCommentLine.Code := '';
                                GRegistCommentLine.Comment := GCommentCOA."Commentaire COA";
                                GRegistCommentLine.Display := FALSE;
                                GRegistCommentLine.INSERT(TRUE);
                            UNTIL GCommentCOA.NEXT = 0;

                        PAGE.RUN(50543);
                    end;
                }
            }
        }
        area(Navigation)
        {
            group(Function)
            {
                action("Get Registration Lines")
                {
                    CaptionML = ENU = 'Get Registration Lines', FRA = 'Extraire lignes enregistrements';
                    Image = GetLines;
                    Ellipsis = true;
                    trigger OnAction()
                    begin
                        QualityControlMgt.GetRegistrationLines(Rec);
                        RegistrationLine.RESET;
                        RegistrationLine.SETRANGE("Document Type", Rec."Document Type");
                        RegistrationLine.SETRANGE("Document No.", Rec."No.");
                        RegistrationLine.SETRANGE("Type of Result", RegistrationLine."Type of Result"::Option);
                        IF RegistrationLine.FINDSET THEN BEGIN
                            REPEAT
                                RegistrationLine.Imprimable := false;
                                RegistrationLine.MODIFY
                            UNTIL RegistrationLine.NEXT = 0;
                        END
                    end;
                }
                action("%Print")
                {
                    CaptionML = ENU = '&Print', FRA = '&Imprimer';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    Ellipsis = true;
                    trigger OnAction()
                    var
                        ManufacturingSetup: Record "Manufacturing Setup";
                    begin
                        ManufacturingSetup.GET;
                        ManufacturingSetup.RESET;
                        ManufacturingSetup."Expiration Date" := Rec."Expiration Date";
                        ManufacturingSetup."Production Date" := Rec."Production Date";
                        ManufacturingSetup.MODIFY;
                        COMMIT;
                        DocPrint.PrintCoAHeader(Rec);
                        PrintCoAHeader(Rec);
                    end;
                }
                action("Imprimer Old")
                {
                    // Visible=false;
                    // Image=Print;
                    // RunObject=report "CoA Registration avant";
                }
            }
        }
    }
    LOCAL procedure StatusOnAfterValidate()
    begin
        CurrPage.UPDATE(TRUE);
    end;

    LOCAL procedure LotNoOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    procedure PrintCoAHeader(RegistrationHeader: Record "WDC-QA Registration Header")
    var
        CertificateOfAnalysis: Record "WDC-QA Certificate of Analysis";
        Customer: Record Customer;
        CustomerList: Page "Customer List";
    begin
        CertificateOfAnalysis.SETCURRENTKEY("Customer No.");
        CLEAR(CustomerList);
        CustomerList.LOOKUPMODE := TRUE;
        IF CustomerList.RUNMODAL = ACTION::LookupOK THEN
            CertificateOfAnalysis.SETFILTER("Customer No.", CustomerList.GetSelectionFilter)
        ELSE
            CertificateOfAnalysis.SETRANGE("Customer No.", '');
        CertificateOfAnalysis.SETFILTER("Report ID", '<>0');
        CertificateOfAnalysis.ASCENDING := FALSE;
        CertificateOfAnalysis.FINDFIRST;

        IF STRLEN(CertificateOfAnalysis.GETFILTER("Customer No.")) = 2 THEN
            REPEAT
                RegistrationHeader.SETRECFILTER;
                RegistrationHeader.SETFILTER("Customer No. Filter", CertificateOfAnalysis.GETFILTER("Customer No."));
                REPORT.RUN(CertificateOfAnalysis."Report ID", TRUE, FALSE, RegistrationHeader);
            UNTIL CertificateOfAnalysis.NEXT = 0
        ELSE BEGIN
            Customer.SETFILTER("No.", CustomerList.GetSelectionFilter);
            Customer.FINDFIRST;
            REPEAT
                CertificateOfAnalysis.RESET;
                CertificateOfAnalysis.SETFILTER("Customer No.", Customer."No.");
                CertificateOfAnalysis.SETFILTER("Report ID", '<>0');
                IF CertificateOfAnalysis.FINDSET THEN
                    REPEAT
                        RegistrationHeader.SETRECFILTER;
                        RegistrationHeader.SETFILTER("Customer No. Filter", Customer."No.");
                        REPORT.RUN(CertificateOfAnalysis."Report ID", TRUE, FALSE, RegistrationHeader);
                    UNTIL CertificateOfAnalysis.NEXT = 0;
            UNTIL Customer.NEXT <= 0;
        END;
    end;

    var
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
        DocPrint: Codeunit "WDC-QA Document-Print";
        GCommentCOA: Record "WDC-QA Commentaire COA";
        GRegistCommentLine: Record "WDC-QA RegistrationCommentLine";
        Gline: Integer;
        RegistrationLine: Record "WDC-QA Registration Line";
}
