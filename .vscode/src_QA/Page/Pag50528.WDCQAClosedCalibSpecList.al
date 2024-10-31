page 50528 "WDC-QA Closed Calib Spec List"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed Calibration Specification', FRA = 'Spéc. calibration clôturée';
    PageType = List;
    SourceTable = "WDC-QA Specification Header";
    SourceTableView = SORTING("Document Type", "No.", "Version No.") WHERE("Document Type" = FILTER(Calibration), Status = CONST(Closed));
    UsageCategory = Lists;
    Editable = false;
    DataCaptionFields = "Document Type";
    CardPageId = "WDC-QA Closed Calibration Spec";
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = all;
                }
                field("Version Date"; Rec."Version Date")
                {
                    ApplicationArea = all;
                }
                field("Date Closed"; Rec."Date Closed")
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
                CaptionML = ENU = 'Card', FRA = 'Fiche';
                Image = EditLines;
                ShortcutKey = 'Maj+F7';
                trigger OnAction()
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
        }
    }
}
