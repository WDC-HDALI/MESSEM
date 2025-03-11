namespace MESSEM.MESSEM;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Shipping;

pageextension 50402 "WDC-TRS Purchase Order" extends "Purchase Order"
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
        addafter("Shipment Method Code")
        {
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
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
                Visible = rec."Transport Order" = false;
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
        lPurchaseLines: Record "Purchase Line";
        ltext001: TextConst ENU = 'Order created with success with the N° %1, you want to open it?',
                             FRA = 'Votre commande de transport est créée sous le N° %1\ voulez-vous l''ouvrir?';
        ltext002: TextConst ENU = 'Setting tarif is not found for the %1',
                             FRA = 'Tarif transport n''existe pas pour %1';
        lTransportOrderPage: Page "WDC-TRS Transport order";
        lTransportTarif: Record "WDC-TRS Transport Tarifs";

    begin
        Clear(NewTransportOrder);
        rec.TestField("Shipping Agent Code");
        Rec.TestField("Shipment Method Code");
        Rec.TestField("Ship-to Address");
        rec.TestField("Your Reference");
        //Rec.TestField(Status, rec.Status::Released);
        rec.TestField("Transport order created", false);
        if lShippingAgent.Get(Rec."Shipping Agent Code") Then begin
            lShippingAgent.TestField("Vendor No.");
        end;

        lTransportTarif.Reset();
        lTransportTarif.SetRange(Type, lTransportHeader."Transport Type"::Vendor);
        lTransportTarif.SetRange("No.", rec."Pay-to Vendor No.");
        lTransportTarif.SetRange("Transport vendor No.", lShippingAgent."Vendor No.");
        lTransportTarif.SetRange("Shipment Method code", rec."Shipment Method Code");
        if Not lTransportTarif.FindFirst() then
            error(lText002, rec."Pay-to Vendor No.");
        lTransportHeader.init;
        lTransportHeader."Transport Type" := lTransportHeader."Transport Type"::Vendor;
        lTransportHeader."Transport To" := rec."Buy-from Vendor No.";
        lTransportHeader."Transport to Name" := rec."Buy-from Vendor Name";
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
        lTransportHeader."External Doc No." := Rec."Your Reference";
        if lTransportHeader.insert(true) then begin
            NewTransportOrder := lTransportHeader."No.";
            lPurchaseLines.reset;
            lPurchaseLines.SetRange("Document Type", rec."Document Type");
            lPurchaseLines.SetRange("Document No.", Rec."No.");
            if lPurchaseLines.FindFirst() then
                repeat
                    IF lPurchaseLines."No." <> '' then begin
                        lTransportLine.Init();
                        lTransportLine."Document No." := lTransportHeader."No.";
                        lTransportLine."Line No." := lTransportLine.GetNextLineDocument(lTransportLine."Document No.");
                        lTransportLine.Validate("No.", lPurchaseLines."No.");
                        lTransportLine.Description := lPurchaseLines.Description;
                        lTransportLine.Quantity := lPurchaseLines.Quantity;
                        lTransportLine.Insert(True);
                    end;
                until lPurchaseLines.Next() = 0;
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