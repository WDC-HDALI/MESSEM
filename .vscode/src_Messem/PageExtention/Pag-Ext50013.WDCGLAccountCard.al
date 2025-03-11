pageextension 50013 "WDC G/L Account Card " extends "G/L Account Card"
{
    layout
    {
        addafter("Account Type")
        {
            field("Purchase GL account"; Rec."Purchase GL account")
            {
                ApplicationArea = all;
            }
            field("Rebate G/L Account"; Rec."Rebate G/L Account")
            {
                ApplicationArea = all;
            }
        }
    }
    trigger OnOpenPage()
    var
        lUserSetup: Record "User Setup";
        lText01: TextConst ENU = 'You are not allowed to check this menu', FRA = 'Vous n"avez pas le droit d"ouvrir ce menu';
    begin
        lUserSetup.get(UserId);
        if not lUserSetup."Check Accounting" then
            Error(lText01);
    end;
}
