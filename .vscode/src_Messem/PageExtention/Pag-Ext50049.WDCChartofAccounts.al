namespace Messem.Messem;

using Microsoft.Finance.GeneralLedger.Account;
using System.Security.User;
//WDC01  WDC.HG  03/01/2025  show field "Purchase GL account"

pageextension 50049 "WDC Chart of Accounts" extends "Chart of Accounts"
{
    //>>WDC01
    layout
    {
        addafter(Name)
        {
            field("Purchase GL account"; Rec."Purchase GL account")
            {
                ApplicationArea = all;

            }
        }
    }
    //WDC01

    trigger OnOpenPage()
    var
        lUserSetup: Record "User Setup";
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        lUserSetup.get(UserId);
        if not lUserSetup."Check Accounting" then
            Error(lText01);
    end;

    trigger OnAfterGetRecord()
    var
        lUserSetup: Record "User Setup";
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        lUserSetup.get(UserId);
        if not lUserSetup."Check Accounting" then
            Error(lText01);
    end;

}
