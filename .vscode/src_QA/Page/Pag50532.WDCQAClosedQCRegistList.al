page 50532 "WDC-QA Closed QC Regist List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Registration List', FRA = 'Liste enregistrement CQ clôturé';
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(QC), Status = CONST(Closed));
    PageType = List;
    SourceTable = "WDC-QA Registration Header";
    UsageCategory = Lists;
    Editable = false;
    DataCaptionFields = "Document Type";
    CardPageId = "WDC-QA Closed QC Registration";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Internal Reference No."; Rec."Internal Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
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
            }
        }
    }
    Actions
    {
        area(Navigation)
        {
            action(Card)
            {
                ApplicationArea = all;
                Image = EditLines;
                CaptionML = ENU = 'Card', FRA = 'Fiche';
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    IF Rec.Status = Rec.Status::Closed THEN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Calibration:
                                PAGE.RUN(PAGE::"WDC-QA Closed Calibration Reg.", Rec);
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA Closed QC Registration", Rec);
                            Rec."Document Type"::CoA:
                                PAGE.RUN(PAGE::"WDC-QA Closed CoA Registration", Rec);
                        END
                    ELSE
                        CASE Rec."Document Type" OF
                            // Rec."Document Type"::Calibration:
                            //     PAGE.RUN(PAGE::"WDC-QA Calibration Registratio", Rec);
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA QC Registration", Rec);
                            Rec."Document Type"::CoA:
                                PAGE.RUN(PAGE::"WDC-QA CoA Registration", Rec);
                        END;
                end;
            }
            action(ImpressionSuiviCQ)
            {
                Image = Bank;
                CaptionML = FRA = 'Impression Suivi CQ';
                //RunObject=report "WDC-QA Suivi Enregistrement CQ";
            }
        }
    }
}
