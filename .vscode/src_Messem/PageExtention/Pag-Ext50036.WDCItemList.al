namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item;

pageextension 50036 "WDC Item List" extends "Item List"
{

    actions
    {
        addafter(AdjustInventory)
        {

            action("Import Inventory")
            {
                ApplicationArea = all;
                Captionml = ENU = 'Import Inventory', FRA = 'Import stock';
                Image = Import;
                RunObject = XmlPort "WDC Import Stock";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}
