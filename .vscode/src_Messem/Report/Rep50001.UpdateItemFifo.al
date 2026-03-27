namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item;

report 50001 "Update Item Fifo"
{
    ApplicationArea = All;
    Caption = 'Update Item Fifo';
    UsageCategory = Administration;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            column(No; "No.")
            {
            }
            trigger OnPreDataItem()
            begin
                Item.SetFilter("No.", '10*|12*|13*');
            end;

            trigger OnAfterGetRecord()
            begin
                Item."Costing Method" := Item."Costing Method"::"FIFO";
                Item.Modify();
            end;
        }

    }

}
