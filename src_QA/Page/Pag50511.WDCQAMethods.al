page 50511 "WDC-QA Methods"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Methods', FRA = 'Méthodes';
    PageType = Document;
    SourceTable = "WDC-QA Method Header";

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
                        //IF Rec.AssistEdit(xRec) THEN
                        CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                { }
                field("Result Type"; Rec."Result Type")
                { }
                field("Result UOM"; Rec."Result UOM")
                {
                    trigger OnValidate()
                    begin
                        ResultTypeOnAfterValidate;
                    end;
                }
                field(Formula; Rec.Formula)
                { }
                field("Sample Quantity"; Rec."Sample Quantity")
                { }
                field("Sample UOM"; Rec."Sample UOM")
                { }
            }
            part(page; "WDC-QA Methods Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    local procedure ResultTypeOnAfterValidate()
    begin
        CurrPage.Update();
    end;
}
