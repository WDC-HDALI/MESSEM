pageextension 50913 "WDC-ED General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {

            field("Posting Allowed To"; Rec."Posting Allowed To")
            {
                ApplicationArea = All;
            }
            field("Posting Allowed From"; Rec."Posting Allowed From")
            {
                ApplicationArea = All;
            }
            // field("Local Currency"; Rec."Local Currency")
            // {
            //     ApplicationArea = All;
            // }
            // field("Currency Euro"; Rec."Currency Euro")
            // {
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
    }
}