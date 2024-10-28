page 50506 "WDC-QA QC Specification List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Specification List', FRA = 'CQ Specifications liste';
    PageType = List;
    SourceTable = "WDC-QA Specification Header";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA QC Specification";
    SourceTableView = SORTING("Document Type", "No.", "Version No.") WHERE("Document Type" = FILTER(QC), Status = FILTER(<> Closed));
    DataCaptionFields = "Document Type";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';
                field(Status; Rec.Status)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                    Visible = false;
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
                field("Version No."; Rec."Version No.")
                {
                }
                field("Version Date"; Rec."Version Date")
                {
                }
                field("Revised By"; Rec."Revised By")
                {
                }
                field("Date Closed"; Rec."Date Closed")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Style = Attention;
                    StyleExpr = true;
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
                var
                    myInt: Integer;
                begin
                    IF Rec.Status = Rec.Status::Closed THEN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Calibration:
                                PAGE.RUN(PAGE::"WDC-QA Closed Calibration Spec", Rec);
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA Closed QC Specification", Rec);
                        END
                    ELSE
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::Calibration:
                                PAGE.RUN(PAGE::"WDC-QA Calibration Specif", Rec);
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA QC Specification", Rec);
                        END;
                end;
            }
            action("QC Specification Formulate")
            {
                CaptionML = ENU = 'QC Specification Formulate', FRA = 'Formulaire Specification CQ';
                Image = Print;
                trigger OnAction()
                var
                    RecGSpecHead: Record "WDC-QA Specification Header";
                begin
                    RecGSpecHead.RESET;
                    RecGSpecHead.SETRANGE("No.", Rec."No.");
                    RecGSpecHead.SETRANGE("Document Type", Rec."Document Type");
                    IF RecGSpecHead.FINDSET THEN BEGIN
                        REPORT.RUN(50502, TRUE, FALSE, RecGSpecHead);
                    END;
                end;
            }
        }
    }
}
