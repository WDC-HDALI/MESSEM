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
                }
                field("Measurement Code"; Rec."Measurement Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Equipment Group Code"; Rec."Equipment Group Code")
                {
                }
                field("Type of Measure"; Rec."Type of Measure")
                {
                }
                field("Value UOM"; Rec."Value UOM")
                {
                }
                field(Result; Rec.Result)
                {
                }
                field(Sample; Rec.Sample)
                {
                }
                field(Remark; Rec.Remark)
                {
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
