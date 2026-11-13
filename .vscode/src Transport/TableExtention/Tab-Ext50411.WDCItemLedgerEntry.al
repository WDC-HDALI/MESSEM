namespace MESSEM.MESSEM;

using Microsoft.Inventory.Ledger;
//********************Documentation*******************
//WDC01  WDC.HG  12/11/2026  Create Current Object
tableextension 50411 "WDC Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50400; "Transport Sales Order"; code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Transport order No.', FRA = 'N° commande vente transport';
            Editable = false;
        }
        field(50401; "Transport External Doc No."; text[35])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Transport External Doc No.', FRA = 'N° doc externe Transport';
            Editable = false;
        }
    }
}
