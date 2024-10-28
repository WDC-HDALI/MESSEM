page 50529 "WDC-QAClosedCoARegistList"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed CoA Registration List', FRA = 'Liste enregistrement certificat d''analyse clôturé';
    PageType = List;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(CoA), Status = CONST(Closed));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA Closed CoA Registration";
    DataCaptionFields = "Document Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Internal Reference No."; Rec."Internal Reference No.")
                {
                }
                field("Lot No."; Rec."Lot No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("QC Date"; Rec."QC Date")
                {
                }
                field("QC Time"; Rec."QC Time")
                {
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Card)
            {
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
        }
    }
}
