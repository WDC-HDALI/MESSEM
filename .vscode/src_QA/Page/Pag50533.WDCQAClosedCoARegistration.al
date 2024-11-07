page 50533 "WDC-QA Closed CoA Registration"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed CoA Registration', FRA = 'Enregistrement certificat d''analyse clôturé';
    PageType = Document;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(CoA), Status = CONST(Closed));
    Editable = false;

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
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = all;
                }
                field("QC Date"; Rec."QC Date")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'CoA Date', FRA = 'Date certificat d''analyse';
                }
                field("QC Time"; Rec."QC Time")
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'CoA Time', FRA = 'Heure certificat d''analyse';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StatusOnAfterValidate;
                    end;
                }
            }
            part(CalibrationLines; "WDC-QA Closed CoA Regist Subf")
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
            action("Co&mments")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
                Image = ViewComments;
                RunObject = Page "WDC-QARegistrationCommentSheet";
                RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
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
                Ellipsis = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    DocPrint.PrintCoAHeader(Rec);
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
