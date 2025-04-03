namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Customer;
using Microsoft.Sales.History;

tableextension 50408 "WDC-TRS Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {

        field(50401; "Transport order created"; Boolean)
        {
            CaptionML = ENU = 'Transport order created', FRA = 'Ordre transport crée';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("WDC-TRS Trasport Order Header" where
                            ("Origin Order No." = field("No.")));

        }
    }
}
