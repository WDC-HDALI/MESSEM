namespace Messem.Messem;

using Microsoft.Manufacturing.Journal;
using Microsoft.Purchases.History;
//********************Documentation*************************
//WDC01  02/04/2025  HG Add new Action to update vendor No.

pageextension 50053 "WDC Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Order No.")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    //<<WDC01
    actions
    {
        addlast(processing)
        {

            action("Mise à Jour Founisseur")
            {
                Image = UpdateShipment;
                CaptionML = FRA = 'Mise à Jour Founisseur', ENU = 'Upadate Vendor';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ReportMAJFourn.Numero(rec."No.");
                    ReportMAJFourn.RUN;
                end;
            }
            action("Mise à Jour Four BO")
            {
                Image = UpdateDescription;
                CaptionML = FRA = 'Mise à Jour Four BO', ENU = 'Update Vendor BO';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ReportMAJFournBO.RUN;
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("MiseàJourFounisseur"; "Mise à Jour Founisseur")
            {

            }
            actionref("MiseàJourFourBO"; "Mise à Jour Four BO")
            {

            }


        }

    }
    var
        ReportMAJFourn: Report "WDC MAJ Fourn donneur d'ordre";
        ReportMAJFournBO: Report "WDC MAJ Fourn BO";
    //>>WDC01

}
