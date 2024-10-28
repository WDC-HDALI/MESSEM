page 50502 "WDC-QA QC Specification"
{
    ApplicationArea = All;
    CaptionML = ENU = 'QC Specification', FRA = 'Spécification CQ';
    PageType = Document;
    SourceTable = "WDC-QA Specification Header";
    SourceTableView = SORTING("Document Type", "No.", "Version No.") WHERE("Document Type" = FILTER(QC), Status = FILTER(<> Closed));
    InsertAllowed = true;
    DeleteAllowed = true;
    ModifyAllowed = true;
    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';
                field("No."; Rec."No.")
                {
                    trigger OnValidate()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {

                }
                field("Item Category Code"; Rec."Item Category Code")
                {

                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
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
                field("Check Point Code"; Rec."Check Point Code")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Specific; Rec.Specific)
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field("Process Description"; Rec."Process Description")
                {
                }
                field("Chemical Standard"; Rec."Chemical Standard")
                {
                }
                field("Sampling Frequency PSF"; Rec."Sampling Frequency PSF")
                {
                }
                field("Sampling Frequency PF"; Rec."Sampling Frequency PF")
                {
                }
            }
            part(CalibrationLines; "WDC-QA QCSpecification Subform")
            {
                SubPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Version No." = FIELD("Version No.");
            }
        }
        area(factboxes)
        {
            systempart(links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Create New Version")
            {
                CaptionML = ENU = 'Create New Version', FRA = 'Créer nouvelle version';
                Image = Versions;
                Ellipsis = true;
                RunPageOnRec = true;
                trigger OnAction()
                var
                    QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
                begin
                    QualityControlMgt.CopySpecification(Rec);
                end;
            }
            action("Production Specification")
            {
                Image = Item;
                trigger OnAction()
                var
                    SpecificationHeader: Record "WDC-QA Specification Header";
                    ProductSpecification: Report "WDC-QA Products Specifications";
                begin
                    CLEAR(ProductSpecification);
                    SpecificationHeader.SETRANGE("No.", Rec."No.");
                    SpecificationHeader.SETRANGE("Version No.", Rec."Version No.");
                    ProductSpecification.SETTABLEVIEW(SpecificationHeader);
                    ProductSpecification.SetValues(Rec."Process Description", Rec."Chemical Standard");
                    ProductSpecification.RUNMODAL
                end;
            }
            action("Formulaire Specification CQ")
            {
                Image = Print;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50502, TRUE, TRUE, Rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Version No." := Rec.InitVersion;
    end;
}
