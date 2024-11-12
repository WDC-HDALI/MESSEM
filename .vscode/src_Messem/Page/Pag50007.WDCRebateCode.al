page 50007 "WDC Rebate Code"
{

    CaptionML = ENU = 'Rebate Code', FRA = 'Code bonus';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "WDC Rebate Code";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(StartingDateFilter; StartingDateFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Starting Date Filter', FRA = 'Filtre date début';

                    trigger OnValidate()
                    begin
                        StartingDateFilterOnAfterValid;
                    end;
                }
            }
            repeater(Control1)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Rebate GL-Acc. No."; Rec."Rebate GL-Acc. No.")
                {
                    ApplicationArea = all;
                }
                field("Rebate GL-Acc. No.2"; Rec."Rebate GL-Acc. No.2")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Rebate)
            {
                CaptionML = ENU = 'Rebate', FRA = 'Bonus';
                action("Rebate Scales")
                {
                    CaptionML = ENU = 'Rebate Scales', FRA = 'Accord échelonnement';
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    Image = RollUpCosts;
                    RunObject = Page "WDC Rebate Scales";
                    RunPageLink = Code = FIELD(Code);
                }
                action("E&ntries")
                {
                    CaptionML = ENU = 'E&ntries', FRA = 'Ecritures';
                    Image = CostEntries;
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        RebateEntry: Record "WDC Rebate Entry";
                    begin
                        RebateEntry.SETCURRENTKEY("Rebate Code");
                        RebateEntry.SETRANGE("Rebate Code", rec.Code);
                        PAGE.RUNMODAL(0, RebateEntry);
                    end;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        GetRecFilters;
        SetRecFilters;
    end;

    var
        StartingDateFilter: Text[30];

    procedure SetRecFilters()
    begin

        IF StartingDateFilter <> '' THEN
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            Rec.SETRANGE("Starting Date");

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetRecFilters()
    begin
        IF Rec.GETFILTERS <> '' THEN BEGIN
            EVALUATE(StartingDateFilter, Rec.GETFILTER("Starting Date"));
        END;
    end;

    procedure GetCaption(): Text[250]
    begin
        GetRecFilters;

        EXIT(STRSUBSTNO('%1', Rec.Code));
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        SetRecFilters;
    end;
}

