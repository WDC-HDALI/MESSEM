pageextension 50006 "WDC Vendor Card " extends "Vendor Card"
{
    layout
    {

        addafter("VAT Registration No.")
        {
            field(ICE; Rec.ICE)
            {
                ApplicationArea = all;
            }
            field("No. RC"; Rec."No. RC")
            {
                ApplicationArea = all;
            }
            field("Convention Y/N"; Rec."Convention Y/N")
            {
                ApplicationArea = all;
            }

            field("Packaging Price"; Rec."Packaging Price")
            {
                ApplicationArea = all;
            }
        }
        addlast(Receiving)
        {
            field(Transporter; Rec.Transporter)
            {
                ApplicationArea = all;
            }

        }
        addfirst(Payments)
        {
            field(Banque; Rec.Banque)
            {
                ApplicationArea = all;
            }
            field(RIB; Rec.RIB)
            {
                ApplicationArea = all;
            }
        }
        addafter("Balance (LCY)")
        {
            field("Solde Bonus"; Rec."Solde Bonus")
            {
                ApplicationArea = all;
            }
            field("Purchases (Qty.)"; Rec."Purchases (Qty.)")
            {
                ApplicationArea = all;
            }

        }
        addafter("Payment Method Code")
        {
            field("Payment Terms Convention"; Rec."Payment Terms Convention")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addafter("Co&mments")
        {

            action("Packaging")
            {
                ApplicationArea = all;
                Captionml = ENU = 'Packaging', FRA = 'Emballage';
                Image = CopyItem;
                RunObject = Page 50002;
                RunPageLink = "Source Type" = CONST(23),
                        "Source No." = FIELD("No.");
                RunPageView = SORTING("Source Type", "Source No.", Code);
            }
            action("Rebate")
            {
                Captionml = ENU = 'Rebate', FRA = 'Bonus';
                ApplicationArea = all;
                Image = Calculate;
                RunObject = Page "WDC Purchase Rebates";
                RunPageLink = "Vendor No." = field("No.");
            }
            action("Rebate Entries")
            {
                Captionml = ENU = 'Rebate Entries', FRA = 'Ecritures Bonus';
                ApplicationArea = all;
                Image = ApplyEntries;
                RunObject = Page "WDC Rebate Entries";
                RunPageLink = "Buy-from No." = field("No.");
            }

        }
    }

}

