page 50504 "WDC-QA Quality Control Setup"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Quality Control Setup', FRA = 'Configuration contrôle qualité';
    PageType = Card;
    SourceTable = "WDC-QA Quality Control Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';
                field("Initial Calibration Version"; Rec."Initial Calibration Version")
                {
                    ApplicationArea = all;
                }
                field("Initial QC Spec. Version"; Rec."Initial QC Spec. Version")
                {
                    ApplicationArea = all;
                }
            }
            group(Numbering)
            {
                CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
                field("Equipment No."; Rec."Equipment Nos.")
                {
                    ApplicationArea = all;
                }
                field("Calibration Spec.Nos."; Rec."Calibration Spec.Nos.")
                {
                    ApplicationArea = all;
                }
                field("QC Specification Nos."; Rec."QC Specification Nos.")
                {
                    ApplicationArea = all;
                }
                field("QC Registration Nos. "; Rec."QC Registration Nos.")
                {
                    ApplicationArea = all;
                }
                field("Calibration Reg. Nos."; Rec."Calibration Reg. Nos.")
                {
                    ApplicationArea = all;
                }
                field("CoA Registration Nos."; Rec."CoA Registration Nos.")
                {
                    ApplicationArea = all;
                }
                field("Method Nos."; Rec."Method Nos.")
                {
                    ApplicationArea = all;
                }
                field("QC Photo Path"; Rec."QC Photo Path")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.Reset();
        If not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
