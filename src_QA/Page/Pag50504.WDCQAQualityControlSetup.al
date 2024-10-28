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
                }
                field("Initial QC Spec. Version"; Rec."Initial QC Spec. Version")
                {
                }
            }
            group(Numbering)
            {
                CaptionML = ENU = 'Numbering', FRA = 'Numérotation';
                field("Equipment No."; Rec."Equipment Nos.")
                {
                }
                field("Calibration Spec.Nos."; Rec."Calibration Spec.Nos.")
                {
                }
                field("QC Specification Nos."; Rec."QC Specification Nos.")
                {
                }
                field("QC Registration Nos. "; Rec."QC Registration Nos.")
                {
                }
                field("Calibration Reg. Nos."; Rec."Calibration Reg. Nos.")
                {
                }
                field("CoA Registration Nos."; Rec."CoA Registration Nos.")
                {
                }
                field("Method Nos."; Rec."Method Nos.")
                {
                }
                field("QC Photo Path"; Rec."QC Photo Path")
                {
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
