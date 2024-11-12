namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Setup;

pageextension 50018 "WDC General Posting Setup" extends "General Posting Setup"
{
    layout
    {
        addafter("Purch. FA Disc. Account")
        {
            field("Bonus Purchase Account"; Rec."Purchase Rebate Account")
            {
                ApplicationArea = all;
            }
        }
    }
}
