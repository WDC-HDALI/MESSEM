page 50505 "WDC-QA Specification Steps"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Specification Steps', FRA = 'Etapes de spécification';
    PageType = List;
    SourceTable = "WDC-QA Specification Step";
    UsageCategory = Lists;
    InsertAllowed = true;
    ModifyAllowed = true;
    DelayedInsert = true;
    DeleteAllowed = true;
    SaveValues = true;
    DataCaptionFields = "Document No.";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = true;
                }
                field("Method No."; Rec."Method No.")
                {
                    Editable = true;
                }
                field("Column No."; Rec."Column No.")
                {
                    Editable = true;
                }
                field("Measurement Code"; Rec."Measurement Code")
                {
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                }
                field("Equipment Group"; Rec."Equipment Group")
                {
                    Editable = true;
                }
                field("Type Of Measure"; Rec."Type Of Measure")
                {
                    Editable = true;
                }
                field("Value UOM"; Rec."Value UOM")
                {
                    Editable = true;
                }
                field("Result Option"; Rec."Result Option")
                {
                    Editable = true;
                }
                field(Sample; Rec.Sample)
                {
                    Editable = true;
                }
                field("Method Remark"; Rec."Method Remark")
                {
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        SpecificationHeader: Record "WDC-QA Specification Header";
    begin
        IF SpecificationHeader.GET(Rec."Document Type", Rec."Document No.", Rec."Version No.") THEN
            CurrPage.EDITABLE(SpecificationHeader.Status = SpecificationHeader.Status::Open)
        ELSE
            CurrPage.EDITABLE(FALSE);
    end;
}
