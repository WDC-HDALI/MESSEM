namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Customer;

tableextension 50400 "WDC-TRS Sales Header" extends "Sales Header"
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
