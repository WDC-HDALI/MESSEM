page 50512 "WDC-QA Methods Subform"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-QA Method Line";
    DelayedInsert = true;
    AutoSplitKey = true;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Column No."; Rec."Column No.")
                {
                    ApplicationArea = all;
                }
                field("Measurement Code"; Rec."Measurement Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Equipment Group Code"; Rec."Equipment Group Code")
                {
                    ApplicationArea = all;
                }
                field("Type of Measure"; Rec."Type of Measure")
                {
                    ApplicationArea = all;
                }
                field("Value UOM"; Rec."Value UOM")
                {
                    ApplicationArea = all;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = all;
                }
                field(Sample; Rec.Sample)
                {
                    ApplicationArea = all;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        MethodHeader: Record "WDC-QA Method Header";
    begin
        IF MethodHeader.GET(Rec."Document No.") THEN BEGIN
            CASE MethodHeader."Result Type" OF
                MethodHeader."Result Type"::Value:
                    Rec."Type of Measure" := Rec."Type of Measure"::Value;
                MethodHeader."Result Type"::Option:
                    Rec."Type of Measure" := Rec."Type of Measure"::Option;
            END;
        END;
    end;
}
