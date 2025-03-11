page 50527 "WDC-QAClosedQCSpecifiList"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Closed QC Specification', FRA = 'Spécifications CQ clôturée';
    PageType = List;
    SourceTable = "WDC-QA Specification Header";
    SourceTableView = SORTING("Document Type", "No.", "Version No.") WHERE("Document Type" = FILTER(QC), Status = CONST(Closed));
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "WDC-QA Closed QC Specification";

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
                field("Revised By"; Rec."Revised By")
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
                begin
                    IF Rec.Status = Rec.Status::Closed THEN
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA Closed QC Specification", Rec);
                        END
                    ELSE
                        CASE Rec."Document Type" OF
                            Rec."Document Type"::QC:
                                PAGE.RUN(PAGE::"WDC-QA QC Specification", Rec);
                        END;
                end;
            }
        }
    }
}
