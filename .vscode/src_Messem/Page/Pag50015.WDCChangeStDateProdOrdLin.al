namespace Messem.Messem;
using Microsoft.Manufacturing.Document;

page 50015 "WDC Change St.Date Prod OrdLin"
{
    CaptionML = ENU = 'Change Start Date on Prod. Order Line', FRA = 'Changer la date début sur les lignes OF';
    PageType = ConfirmationDialog;
    InstructionalTextML = ENU = 'Do you want to change the start date of this Production Order Line?', FRA = 'Voulez-vous changer la date de début de cette ligne OF ?';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(NewStartDate; NewStartDate)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'New Start Date', FRA = 'Nouvelle date début';
                }
            }
        }
    }
    procedure Set(ProdOrderLine: Record "Prod. Order Line")
    begin
        NewStartDate := ProdOrderLine."Starting Date";
    end;

    procedure ReturnPostingInfo(VAR StartDate: Date)
    begin
        StartDate := NewStartDate;
    end;

    var
        NewStartDate: Date;
}
