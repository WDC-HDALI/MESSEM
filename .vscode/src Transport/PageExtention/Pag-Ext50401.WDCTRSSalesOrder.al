namespace MESSEM.MESSEM;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Ledger;

pageextension 50401 "WDC-TRS Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Transport order created"; Rec."Transport order created")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addbefore(Release)
        {
            action("Create Transport order")
            {
                CaptionML = ENU = 'Create transport order', FRA = 'Créer ordre transport';
                ApplicationArea = all;
                Image = CreateDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    lText001: TextConst ENU = 'Would you create a transport order?',
                                        FRA = 'Voulez-vous créer un ordre de transport?';
                begin
                    If Confirm(lText001) then
                        CreateTransportOrder();
                end;

            }
        }
    }
    procedure CreateTransportOrder()
    var
        lTransportHeader: Record "WDC-TRS Trasport Order Header";
        lTransportLine: record "WDC-TRS Trasport Order Line";
        lShippingAgent: Record "Shipping Agent";
        lSalesLines: Record "Sales Line";
        ltext001: TextConst ENU = 'Order created with success with the N° %1',
                            FRA = 'Votre commande de transport est créée sous le N° %1';
        ltext002: TextConst ENU = 'Setting tarif is not found for the %1 : %2 ',
                            FRA = 'Tarif transport n''existe pas pour %1 destination %2 ';
        lTransportOrderPage: Page "WDC-TRS Transport order";
        lTransportTarif: Record "WDC-TRS Transport Tarifs";
    begin
        Clear(NewTransportOrder);
        rec.TestField("Shipping Agent Code");
        rec.TestField("Shipment Method Code");
        Rec.TestField("Ship-to Code");
        rec.TestField("External Document No.");
        // rec.TestField("Ship-to Address");
        Rec.TestField(Status, rec.Status::Released);
        rec.TestField("Transport order created", false);

        if lShippingAgent.Get(rec."Shipping Agent Code") Then begin
            lShippingAgent.TestField("Vendor No.");
        end;
        lTransportTarif.Reset();
        lTransportTarif.SetRange("No.", rec."Sell-to Customer No.");
        lTransportTarif.SetRange("Ship-to Code", rec."Ship-to Code");
        lTransportTarif.SetRange("Transport vendor No.", lShippingAgent."Vendor No.");
        lTransportTarif.SetRange("Shipment Method code", rec."Shipment Method Code");
        if Not lTransportTarif.FindFirst() then
            error(lText002, rec."Sell-to Customer No.", rec."Ship-to Code");
        lTransportHeader.init;
        lTransportHeader."Transport Type" := lTransportHeader."Transport Type"::Customer;
        lTransportHeader."Transport To" := rec."Sell-to Customer No.";
        lTransportHeader."Transport to Name" := rec."Sell-to Customer Name";
        lTransportHeader.Desitnation := rec."Ship-to Address" + ' ' + rec."Ship-to Address 2";
        lTransportHeader.City := rec."Ship-to City";
        lTransportHeader."Post Code" := rec."Ship-to Post Code";
        lTransportHeader."Country Code" := rec."Ship-to Country/Region Code";
        lTransportHeader."Phone No." := rec."Ship-to Phone No.";
        lTransportHeader."Shipment Method code" := rec."Shipment Method Code";
        lTransportHeader."Location Code" := rec."Location Code";
        lTransportHeader."Origin Order No." := rec."No.";
        lTransportHeader.Validate("Vendor No.", lShippingAgent."Vendor No.");
        lTransportHeader.Amount := lTransportTarif."Transport Rate";
        lTransportHeader."Currency Code" := lTransportTarif."Currency Code";
        lTransportHeader."External Doc No." := Rec."External Document No.";
        if lTransportHeader.insert(true) then begin
            NewTransportOrder := lTransportHeader."No.";
            lSalesLines.reset;
            lSalesLines.SetRange("Document Type", rec."Document Type");
            lSalesLines.SetRange("Document No.", Rec."No.");
            if lSalesLines.FindFirst() then
                repeat
                    IF lSalesLines."No." <> '' then begin
                        lTransportLine.Init();
                        lTransportLine."Document No." := lTransportHeader."No.";
                        lTransportLine."Line No." := lTransportLine.GetNextLineDocument(lTransportLine."Document No.");
                        lTransportLine.Validate("No.", lSalesLines."No.");
                        lTransportLine.Description := lSalesLines.Description;
                        lTransportLine.Quantity := lSalesLines.Quantity;
                        lTransportLine.Insert(True);
                    end;
                until lSalesLines.Next() = 0;
        end;
        if Confirm(StrSubstNo(ltext001, lTransportHeader."No.")) Then begin
            lTransportHeader.Reset();
            lTransportHeader.SetRange("No.", NewTransportOrder);
            if lTransportHeader.FindFirst() then begin
                lTransportOrderPage.SetTableView(lTransportHeader);
                lTransportOrderPage.Run();
            end;
        end;
    end;

    var
        NewTransportOrder: Code[20];
}
