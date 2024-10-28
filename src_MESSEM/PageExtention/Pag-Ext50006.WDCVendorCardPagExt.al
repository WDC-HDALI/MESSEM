pageextension 50006 "WDC VendorCard PagExt" extends "Vendor Card"
{
    actions
    {
        addafter("Co&mments")
        {

            action("Packaging")
            {
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

