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
            field("Transport Tariff Code"; Rec."Transport Tariff Code")
            {
                ApplicationArea = all;
            }
        }
        addfirst(Payments)
        {
            field(RIB; Rec.RIB)
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
        }
    }

}

