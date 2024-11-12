page 50006 "WDC Item Rebate Groups"
{

    CaptionML = ENU = 'Item Rebate Groups', FRA = 'Groupes bonus article';
    ApplicationArea = all;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "WDC Item Rebate Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
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
            group("Re&bate")
            {
                CaptionML = ENU = 'Re&bate', FRA = 'Bonus';
                action("Re&bates")
                {
                    CaptionML = ENU = 'Re&bates', FRA = 'Bonus';
                    Image = Costs;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        PurchaseRebate: Record "WDC Purchase Rebate";
                        PurchaseRebates: Page "WDC Purchase Rebates";
                    begin
                        PurchaseRebates.SetParameters(Rec.Code);
                        PurchaseRebates.SETTABLEVIEW(PurchaseRebate);
                        PurchaseRebates.RUNMODAL();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
    end;

    var
    procedure GetSelectionFilter(): Code[80]
    var
        ItemRebateGr: Record "WDC Item Rebate Group";
        FirstItemRebateGr: Code[30];
        LastItemRebateGr: Code[30];
        SelectionFilter: Code[250];
        ItemRebateGrCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(ItemRebateGr);
        ItemRebateGrCount := ItemRebateGr.COUNT;
        IF ItemRebateGrCount > 0 THEN BEGIN
            If ItemRebateGr.FindFirst() Then;
            WHILE ItemRebateGrCount > 0 DO BEGIN
                ItemRebateGrCount := ItemRebateGrCount - 1;
                ItemRebateGr.MARKEDONLY(FALSE);
                FirstItemRebateGr := ItemRebateGr.Code;
                LastItemRebateGr := FirstItemRebateGr;
                More := (ItemRebateGrCount > 0);
                WHILE More DO
                    IF ItemRebateGr.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT ItemRebateGr.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastItemRebateGr := ItemRebateGr.Code;
                            ItemRebateGrCount := ItemRebateGrCount - 1;
                            IF ItemRebateGrCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstItemRebateGr = LastItemRebateGr THEN
                    SelectionFilter := SelectionFilter + FirstItemRebateGr
                ELSE
                    SelectionFilter := SelectionFilter + FirstItemRebateGr + '..' + LastItemRebateGr;
                IF ItemRebateGrCount > 0 THEN BEGIN
                    ItemRebateGr.MARKEDONLY(TRUE);
                    ItemRebateGr.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;



}

