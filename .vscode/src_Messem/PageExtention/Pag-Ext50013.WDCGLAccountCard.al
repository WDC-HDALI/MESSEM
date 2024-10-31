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
}
