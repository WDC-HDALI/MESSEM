page 50527 "WDC-QAClosedQCSpecifiList"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Specification List', FRA = 'Liste spécification CQ clôturée';
    PageType = List;
    SourceTable = "WDC-QA Specification Header";
    SourceTableView = SORTING("Document Type", "No.", "Version No.") WHERE("Document Type" = FILTER(QC), Status = CONST(Closed));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA Closed QC Specification";
    DataCaptionFields = "Document Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Status; Rec.Status)
                { }
                field("No."; Rec."No.")
                { }
                field(Description; Rec.Description)
                { }
                field("Version No."; Rec."Version No.")
                { }
                field("Version Date"; Rec."Version Date")
                { }
                field("Revised By"; Rec."Revised By")
                { }
                field("Date Closed"; Rec."Date Closed")
                { }
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
