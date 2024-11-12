namespace MESSEM.MESSEM;

using Microsoft.Purchases.Vendor;

pageextension 50033 WDCVendorList extends "Vendor List"
{
    actions
    {

        addlast(navigation)
        {
            action("Pac&kaging")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Pac&kaging', FRA = 'Emballage';
                Image = CopyItem;
                RunObject = Page 50002;
                RunPageLink = "Source Type" = CONST(23),
                                  "Source No." = FIELD("No.");
                RunPageView = SORTING("Source Type", "Source No.", Code);
            }
        }
        addlast(Category_Category5)
        {
            actionref("Pac&kagingref"; "Pac&kaging")
            {

            }
        }
    }

}
