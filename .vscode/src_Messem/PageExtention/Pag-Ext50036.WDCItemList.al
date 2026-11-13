namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item;
//***************Documentation***********************
//WDC01 WDC.HG  12/11/2026  Show net change field 
pageextension 50036 "WDC Item List" extends "Item List"
{
    layout
    {
        addbefore("Unit Cost")
        {
            field(" Purchases Item Rebate Group"; Rec." Purchases Item Rebate Group")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC01
        addafter(InventoryField)
        {
            field("Net Change"; Rec."Net Change")
            {
                CaptionML = ENU = 'Inventory at Date', FRA = 'Stock à date';
                ApplicationArea = all;
            }
        }
        //>>WDC01
    }

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
