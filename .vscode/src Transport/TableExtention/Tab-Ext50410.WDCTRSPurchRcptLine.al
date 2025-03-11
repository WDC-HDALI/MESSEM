//**********Documentation***********
//WDC01  WDC.HG  03/01/2025  add sales order No.
tableextension 50410 "WDC-TRS Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50400; "External Doc No."; Text[35])
        {
            CaptionML = ENU = '"External Doc No."', FRA = 'N° doc externe';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."Your Reference" where("No." = field("Document No.")));
            Editable = false;
        }
        //<<WDC01   
        field(50401; "sales order"; code[20])
        {
            CaptionML = ENU = 'Sales order No.', FRA = 'N° commande vente';
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Rcpt. Header"."sales Order No." where("No." = field("Document No.")));
            Editable = false;
        }
        //>>WDC01
    }
}
