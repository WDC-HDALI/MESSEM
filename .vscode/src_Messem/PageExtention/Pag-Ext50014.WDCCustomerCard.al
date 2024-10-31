pageextension 50014 "WDC Customer Card " extends "Customer Card"
{
    layout
    {
        addlast(Invoicing)
        {
            field("Packaging Price"; Rec."Packaging Price")
            {
                ApplicationArea = all;
            }
            field("Transport Tariff Code"; Rec."Transport Tariff Code")
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
                RunPageLink = "Source Type" = CONST(18),
                        "Source No." = FIELD("No.");
                RunPageView = SORTING("Source Type", "Source No.", Code);
            }
        }
    }
}
