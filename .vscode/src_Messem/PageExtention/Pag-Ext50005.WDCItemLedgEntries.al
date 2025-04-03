pageextension 50005 "WDC Item Ledg Entries " extends "Item Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("Balance Reg. Customer/Vend.No."; Rec."Balance Reg. Customer/Vend.No.")
            {
                ApplicationArea = all;
            }

        }
        addafter(Quantity)
        {
            field(PFD; Rec.PFD)
            {
                ApplicationArea = all;

            }
            field(Variety; Rec.Variety)
            {
                ApplicationArea = all;
            }
            field(Brix; Rec.Brix)
            {
                ApplicationArea = all;
            }
            field("Package Number"; Rec."Package Number")
            {
                ApplicationArea = all;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = all;
            }
            field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
            {
                ApplicationArea = all;
            }
            field("Purchase Amount (Expected)"; Rec."Purchase Amount (Expected)")
            {
                ApplicationArea = all;
            }
            field("Rebate Accrual Amount (LCY)"; Rec."Rebate Accrual Amount (LCY)")
            {
                ApplicationArea = all;
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = all;
            }

        }
    }
}
