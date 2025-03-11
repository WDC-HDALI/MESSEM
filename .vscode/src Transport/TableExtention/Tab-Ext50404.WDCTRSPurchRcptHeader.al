//**********Documentation***********
//WDC01 WDC.HG  03/01/2025  Add Field "sales Order No."
tableextension 50404 "WDC-TRS Purch. Rcpt. Header" extends "Purch. Rcpt. Header"

{
    fields
    {
        field(50400; "Transport Document"; Boolean)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Commande Transport', FRA = 'Transport order';
        }
        // field(50401; "Transport Order No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     CaptionML = ENU = 'Transport order No.', FRA = 'N° Commande Transport';
        //     TableRelation = "WDC-TRS Trasport Order Header" where(Status = filter(Released));
        //     Editable = false;
        // }
        field(50401; "Transport Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Transport order No.', FRA = 'N° commande transport';
            //TableRelation = "WDC-TRS Trasport Order Header"
            Editable = false;
        }
        field(50402; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        //<<WDC01
        field(50403; "sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'sales order No.', FRA = 'N° commande vente';
            Editable = false;
        }
        //>>WDC01

    }
}
