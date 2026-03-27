namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;
//******************Documentation*******************
//WDC01  WDC.HG  13/11/2025 Add "Lot No." field 
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
        //<<WDC01
        field(50003; "Lot No."; Code[20])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° Lot';
        }
        //>>WDC01
    }
}

