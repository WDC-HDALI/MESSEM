namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;

tableextension 50024 WDCSalesHeader extends "Sales Header"
{
    fields
    {
        field(50000; "Pallet Quantity"; Integer)
        {
            CaptionML = ENU = 'Pallet Quantity', FRA = 'par pallet';
            DataClassification = ToBeClassified;
        }
        field(50001; "Scelle No."; code[20])
        {
            CaptionML = ENU = 'Scelle No.', FRA = 'Nombre de points maximum';
            DataClassification = ToBeClassified;
        }

    }
}
