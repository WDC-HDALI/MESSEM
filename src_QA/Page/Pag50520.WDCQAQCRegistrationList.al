page 50520 "WDC-QA QC Registration List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Registration List', FRA = 'CQ liste enregistrement';
    PageType = List;
    SourceTable = "WDC-QA Registration Header";
    SourceTableView = SORTING("Document Type", "No.") WHERE("Document Type" = FILTER(QC), Status = FILTER(<> Closed));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA QC Registration";
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
                field("Check Point Code"; Rec."Check Point Code")
                {
                }
                field(Specific; Rec.Specific)
                {
                }
                field("Source No."; Rec."Source No.")
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
                field("Source Document Type"; Rec."Source Document Type")
                {
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                }
                field("Reference Source No."; Rec."Reference Source No.")
                {
                }
                field("Control Reason"; Rec."Control Reason")
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
                CaptionML = ENU = 'Card', FRA = 'Fiche';
                Image = EditLines;
                ShortcutKey = 'Maj+F7';
                trigger OnAction()
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
