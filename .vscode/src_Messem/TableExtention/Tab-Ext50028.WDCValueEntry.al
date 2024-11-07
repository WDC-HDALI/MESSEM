namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;

tableextension 50028 "WDC Value Entry" extends "Value Entry"
{
    fields
    {
        field(50001; "Rebate Accrual Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Rebate Accrual Amount (LCY)', FRA = 'Montant ajustement bonus DS';
        }
        field(50002; "Source Subtype"; Enum "WDC Lot Attribute Src Subtype")
        {
            CaptionML = ENU = 'Source Subtype', FRA = 'Sous-type origine';
        }
    }
}
