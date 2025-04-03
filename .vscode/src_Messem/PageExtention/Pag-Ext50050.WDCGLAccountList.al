namespace Messem.Messem;

using Microsoft.Finance.GeneralLedger.Account;
using System.Security.User;

pageextension 50050 "WDC G/L Account List" extends "G/L Account List"
{
    trigger OnOpenPage()
    var
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        UserSetup.get(UserId);
        // if not UserSetup."Check Accounting" then
        //     Error(lText01);


        IF (NOT UserSetup."Check Accounting") AND (NOT UserSetup."G/L Account 2/6") THEN
            ERROR(Err);           //WDC01

        IF UserSetup."G/L Account 2/6" AND NOT UserSetup."Check Accounting" THEN
            Rec.SETFILTER("No.", '%1|%2', '2*', '6*');

    END;

    trigger OnAfterGetRecord()
    begin
        IF UserSetup.GET(USERID) THEN BEGIN
            IF UserSetup."G/L Account 2/6" AND NOT UserSetup."Check Accounting" THEN
                Rec.SETFILTER("No.", '%1|%2', '2*', '6*');
        END ELSE BEGIN
            ERROR(Err);
        END;
    end;


    var
        UserSetup: Record "User Setup";
        Err: TextConst ENU = 'Access denied on the G/L Accounts',
                       FRA = 'Accès interdit sur les comptes comptables';
}
