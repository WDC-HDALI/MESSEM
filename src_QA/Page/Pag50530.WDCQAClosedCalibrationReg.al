page 50530 "WDC-QA Closed Calibration Reg."
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed Calibration Registration List', FRA = 'Liste enreg. calibration clôturé';
    PageType = List;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(Calibration), Status = CONST(Closed));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA Closed Calibration Reg.";
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
    Actions
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