namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Purchases.History;

tableextension 50047 "WDC G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(50000; "Purchase Description"; Text[100])
        {
            CaptionML = ENU = 'Purchase Description', FRA = 'Description achat';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."Description" where("Document No." = field("Document No."),
                                                                    "No." = field("G/L Account No."),
                                                                    Type = const("G/L Account")));
        }
    }
}
