namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Setup;

pageextension 50019 "WDC General Posting Setup Card" extends "General Posting Setup card"
{
    layout
    {
        addlast(Purchases)
        {
            field("Bonus Purchase Account"; Rec."Purchase Rebate Account")
            {
                ApplicationArea = all;
            }
        }
    }
}
