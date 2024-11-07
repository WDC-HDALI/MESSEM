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
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Result Type"; Rec."Result Type")
                {
                    ApplicationArea = all;
                }
                field("Result UOM"; Rec."Result UOM")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ResultTypeOnAfterValidate;
                    end;
                }
                field(Formula; Rec.Formula)
                {
                    ApplicationArea = all;
                }
                field("Sample Quantity"; Rec."Sample Quantity")
                {
                    ApplicationArea = all;
                }
                field("Sample UOM"; Rec."Sample UOM")
                {
                    ApplicationArea = all;
                }
            }
            part(page; "WDC-QA Methods Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }
    local procedure ResultTypeOnAfterValidate()
    begin
        CurrPage.Update();
    end;
}
