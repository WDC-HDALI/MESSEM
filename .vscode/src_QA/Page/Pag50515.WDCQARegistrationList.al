page 50515 "WDC-QA Registration List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Registration List', FRA = 'Liste d''enregistrement';
    DataCaptionFields = "Document Type";
    PageType = List;
    SourceTable = "WDC-QA Registration Header";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Internal Reference No."; Rec."Internal Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Check Point Code"; Rec."Check Point Code")
                {
                    ApplicationArea = all;
                }
                field("Source No."; Rec."Source No.")
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
    actions
    {
        area(Navigation)
        {
            action(Card)
            {
                ApplicationArea = all;
                Image = EditLines;
                CaptionML = ENU = 'Card', FRA = 'Fiche';
                trigger OnAction()
                begin
                    IF Rec.Status = Rec.Status::Closed THEN
                        CASE Rec."Document Type" OF
                            // Rec."Document Type"::Calibration:
                            //     PAGE.RUN(PAGE::"WDC-QA Closed Calibration Reg.", Rec);
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
