page 50009 "WDC Rebate Scales"
{

    AutoSplitKey = true;
    CaptionML = ENU = 'Rebate Scales', FRA = 'Régles Bonus';
    DataCaptionExpression = GetCaption;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "WDC Rebate Scale";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = all;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = all;
                }
                field("Rebate Value"; Rec."Rebate Value")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    procedure GetCaption(): Text[250]
    begin
        EXIT(STRSUBSTNO('%1', Rec.Code));
    end;
}

