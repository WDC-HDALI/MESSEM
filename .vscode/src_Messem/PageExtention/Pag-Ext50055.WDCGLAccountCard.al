namespace Messem.Messem;

using Microsoft.Finance.GeneralLedger.Account;
using System.Security.User;

pageextension 50055 "WDC G/L Account Card" extends "G/L Account Card"
{
    trigger OnOpenPage()
    var

        Text01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        UserSetup.get(UserId);
        if not UserSetup."Check Accounting" then
            Error(Text01);

        //WDC01
        IF NOT UserSetup."Check Accounting" AND NOT UserSetup."G/L Account 2/6" THEN ERROR(Text01);           //WDC01

    end;

    trigger OnAfterGetRecord()
    begin
        //>>WDC01
        UserSetup.RESET;
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."G/L Account 2/6" AND NOT UserSetup."Check Accounting" THEN
                Rec.SETFILTER("No.", '%1|%2', '2*', '6*');
        END ELSE BEGIN
            ERROR(Text01);
        END;
        //<<WDC01
    end;




    var
        UserSetup: Record "User Setup";
        Text01: TextConst ENU = 'You are not allowed to check this menu',
                           FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
}
