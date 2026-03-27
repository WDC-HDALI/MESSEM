namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using System.Security.User;
using Microsoft.Inventory.Journal;

pageextension 50035 "WDC Lot No. Information Card" extends "Lot No. Information Card"
{
    layout
    {

        addbefore(Blocked)
        {

            field(PFD; Rec.PFD)
            {
                ApplicationArea = all;

            }
            field(Variety; Rec.Variety)
            {
                ApplicationArea = all;
            }
            field(Brix; Rec.Brix)
            {
                ApplicationArea = all;
            }
            field("Package Number"; Rec."Package Number")
            {
                ApplicationArea = all;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = all;
            }
            field("Purch. Received Quantity"; Rec."Purch. Received Quantity")
            {
                ApplicationArea = all;
            }
            field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            {
                ApplicationArea = all;
            }
        }
        //<<WDC.IM
        addafter(Blocked)
        {
            field("Blocked Quantity"; Rec."Blocked Quantity")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    UserSetup: Record "User Setup";
                    Text001: TextConst ENU = 'You are not allowed to edit the Blocked Quantity. Please contact your administrator.',
                                        FRA = 'Vous n''êtes pas autorisé à modifier la quantité bloquée. Veuillez contacter votre administrateur.';
                    Text002: TextConst ENU = 'The blocked quantity cannot be greater than the inventory quantity. Available inventory: %1',
                                        FRA = 'La quantité bloquée ne peut pas être supérieure à la quantité en stock. Stock disponible : %1';
                begin
                    UserSetup.Get(UserId());
                    if not UserSetup."Bloc Qty Lot" then
                        Error(Text001);
                    Rec.CalcFields(Inventory);
                    if Rec."Blocked Quantity" > Rec.Inventory then
                        Error(Text002, Rec.Inventory);
                end;
            }
            field("Block Reason"; Rec."Block Reason")
            {
                ApplicationArea = all;
                trigger OnValidate()
                var
                    UserSetup: Record "User Setup";
                    Text001: TextConst ENU = 'You are not allowed to edit the Block Reason. Please contact your administrator.',
                    FRA = 'Vous n''êtes pas autorisé à modifier le motif de blocage. Veuillez contacter votre administrateur.';
                begin
                    UserSetup.Get(UserId());
                    if not UserSetup."Bloc Qty Lot" then
                        Error(Text001);
                end;
            }
        }
        //>>WDC.IM
    }
}
