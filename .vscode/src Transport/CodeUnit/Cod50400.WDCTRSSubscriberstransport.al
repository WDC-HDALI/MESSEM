namespace MESSEM.MESSEM;
using Microsoft.Purchases.Posting;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Tracking;
using Microsoft.Warehouse.Document;
using Microsoft.Purchases.History;
//WDC01  WDC.HG  03/01/2025  show field in transport order 

codeunit 50400 "WDC-TRS Subscribers transport"
{

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnAfterInsertReceiptHeader', '', FALSE, FALSE)]
    local procedure OnAfterInsertReceiptHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; CommitIsSuppressed: Boolean)
    var
        lTransportOrder: Record "WDC-TRS Trasport Order Header";
    begin
        if PurchHeader."Transport Order" then begin
            lTransportOrder.reset;
            lTransportOrder.SetRange("Purchase Order No.", PurchHeader."No.");
            if lTransportOrder.FindFirst() then begin
                lTransportOrder.Status := lTransportOrder.Status::Posted;
                lTransportOrder."Purchase Receip No." := PurchRcptHeader."No.";
                lTransportOrder.Modify();
                //<<WDC01
                PurchRcptHeader."Transport Order No." := lTransportOrder."No.";
                PurchRcptHeader."sales Order No." := lTransportOrder."Origin Order No.";
                PurchRcptHeader.modify();
                //>>WDC01
            end;
        end;

    end;

    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnAfterPurchRcptLineInsert', '', FALSE, FALSE)]
    // local procedure OnAfterPurchRcptLineInsert(PurchaseLine: Record "Purchase Line"; var PurchRcptLine: Record "Purch. Rcpt. Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean; CommitIsSupressed: Boolean; PurchInvHeader: Record "Purch. Inv. Header";
    // var TempTrackingSpecification: Record "Tracking Specification" temporary; PurchRcptHeader: Record "Purch. Rcpt. Header"; TempWhseRcptHeader: Record "Warehouse Receipt Header"; xPurchLine: Record "Purchase Line"; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    // begin
    //     PurchRcptLine."External Doc No." := PurchRcptHeader."Your Reference";
    // end;
}
