namespace Messem.Messem;
using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;

codeunit 50501 "WDC-QA Subscriber Purchase"
{
    [EventSubscriber(ObjectType::Page, page::"Item Tracking Lines", 'OnAssignLotNoOnAfterInsert', '', FALSE, FALSE)]
    local procedure OnAssignLotNoOnAfterInsert(var TrackingSpecification: Record "Tracking Specification"; QtyToCreate: Decimal)
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        If PurchaseHeader.get(PurchaseHeader."Document Type"::Order, TrackingSpecification."Source ID") then begin
            TrackingSpecification."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
            TrackingSpecification.Modify();
        end;
    end;
}
