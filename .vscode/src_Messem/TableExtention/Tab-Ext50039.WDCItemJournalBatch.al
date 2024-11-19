namespace MESSEM.MESSEM;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Enums;

tableextension 50039 "WDC Item Journal Batch" extends "Item Journal Batch"
{
    fields
    {
        field(50000; "Source Type by Default"; Enum "Analysis Source Type")
        {
            Captionml = ENU = 'Source Type', FRA = 'Type origine par défaut';
            DataClassification = ToBeClassified;
        }
        field(50001; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Captionml = ENU = 'Entry Type', FRA = 'Type écriture';
            DataClassification = ToBeClassified;
        }
    }
}
