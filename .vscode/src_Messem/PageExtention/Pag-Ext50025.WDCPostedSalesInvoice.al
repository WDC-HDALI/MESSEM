namespace MessemMA.MessemMA;

using Microsoft.Sales.History;

pageextension 50025 "WDC Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Order No.")
        {
            field("Pallet Quantity"; Rec."Pallet Quantity")
            {
                CaptionML = ENU = 'Pallet Quantity', FRA = 'Nombre de palette';
                ApplicationArea = all;
            }
        }
        addafter("Location Code")
        {
            field("Container No."; Rec."Container No.")
            {
                CaptionML = ENU = 'Container No.', FRA = 'N° conteneur/matricule';
                ApplicationArea = all;
            }
            field("Forwarding Agent"; Rec."Forwarding Agent")
            {
                captionml = FRA = 'code transitaire', ENU = 'Forwarding Agent';
                ApplicationArea = all;
            }
        }
        addlast("Foreign Trade")
        {
            field("Destination Port"; Rec."Destination Port")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Destination Port', FRA = 'Port destination';
            }
            field("Scelle No."; Rec."Scelle No.")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Scelle No.', FRA = 'N° Scellé';
            }
            field("Notify Party 1"; Rec."Notify Party 1")
            {
                ApplicationArea = all;
            }
            field("Notify Party 2"; Rec."Notify Party 2")
            {
                ApplicationArea = all;
            }


        }




    }
}
