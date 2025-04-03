namespace MessemMA.MessemMA;

using Microsoft.Sales.Document;

pageextension 50028 "WDCSalesCreditMemo" extends "Sales Credit Memo"
{
    layout
    {
        addlast("Foreign Trade")
        {
            field("Destination Port"; Rec."Destination Port")
            {
                CaptionML = ENU = 'Destination Port', FRA = 'Taux maximum remise BQ';
                ApplicationArea = all;
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
