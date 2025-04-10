namespace Messem.Messem;

using System.Security.User;
//***************Documentation****************************************
//WDC01  02/04/2025  HG  Add new field "Mise à jour fournisseur"

pageextension 50048 "WDC User Setup" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("Check Accounting"; Rec."Check Accounting")
            {
                ApplicationArea = All;
            }
            field("Item Added"; Rec."Item Added")
            {
                ApplicationArea = All;
            }
            field("G/L Account 2/6"; Rec."G/L Account 2/6")
            {
                ApplicationArea = all;
            }
            field("BOM Modification"; Rec."BOM Modification")
            {
                ApplicationArea = All;
            }
            field("Routing Modification"; Rec."Routing Modification")
            {
                ApplicationArea = All;
            }
            //<<WDC01
            field("Mise à jour fournisseur"; Rec."Mise à jour fournisseur")
            {
                ApplicationArea = All;
            }
            //>>WDC01

        }
    }


}
