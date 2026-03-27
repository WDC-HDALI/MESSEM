namespace MESSEM.MESSEM;
using Microsoft.Inventory.Ledger;

page 50021 "WDC Update Data"
{
    ApplicationArea = All;
    CaptionML = FRA = 'WDC Update Data';
    PageType = Card;
    Permissions = tabledata "Value Entry" = rimd;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(ItemLedgerIntryNo; ItemLedgerIntryNo)
                {
                    CaptionML = FRA = 'N° ecriture comptable article';
                    ApplicationArea = all;
                }
                field(DocNo; DocNo)
                {
                    CaptionML = FRA = 'N° document';
                    ApplicationArea = all;
                }
                field(NewAmount; NewAmount)
                {
                    CaptionML = FRA = 'Nouvelle valeur';
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                CaptionML = FRA = 'Valider';
                Image = Post;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgerIntryNo);
                    ValueEntry.SetRange("Document No.", DocNo);
                    ValueEntry.SetRange(Adjustment, false);
                    if ValueEntry.FindSet() then begin
                        ValueEntry."Rebate Accrual Amount (LCY)" := NewAmount;
                        ValueEntry.Modify();
                        Message(('Mise à jour terminé'));
                    end;
                end;
            }
        }
    }
    var
        ItemLedgerIntryNo: Integer;
        DocNo: Code[20];
        ValueEntry: Record "Value Entry";
        NewAmount: Decimal;
}
