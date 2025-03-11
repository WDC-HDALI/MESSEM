namespace MESSEM.MESSEM;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Setup;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.NoSeries;

page 50402 "WDC-TRS Transport order"
{
    CaptionML = ENU = 'Transport order', FRA = 'Ordre transport';
    PageType = Document;
    SourceTable = "WDC-TRS Trasport Order Header";
    InsertAllowed = false;
    SourceTableView = where(Status = filter(<> Posted));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Transport Type"; Rec."Transport Type")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Transport To"; Rec."Transport To")
                {
                    ApplicationArea = all;
                }
                field("Transport to Name"; Rec."Transport to Name")
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Desitnation)
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Shipment Method code"; Rec."Shipment Method code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Origin Order No."; Rec."Origin Order No.")
                {
                    ApplicationArea = all;
                }
                field("External Doc No."; Rec."External Doc No.")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
            }

            part(TrasportOrderLines; "WDC-TRS Trasport Order Line")
            {

                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(Post)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Post', FRA = 'Valider';
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ltext001: TextConst ENU = 'Would you like to create a purchase transport order?',
                                        FRA = 'Voulez-vous créer un commande d''achat transport?';
                begin
                    If Confirm(ltext001) then
                        CreateTransportPurchaseOrder(rec."Vendor No.", rec."Transport Type");
                end;
            }
        }
    }
    procedure CreateTransportPurchaseOrder(pVendorNo: code[20]; pPostingType: Enum "wdc-trs transport type")
    var
        lPurchHdr: Record "Purchase Header";
        lPurchLine: record "Purchase Line";
        NoSeriesMgt: Codeunit "No. Series";
        lPurchSetup: Record "Purchases & Payables Setup";
        lSalesSetup: record "Sales & Receivables Setup";
        lPurchaseOrderPage: page "Purchase Order";
        lItemNo: Code[20];
        ltext001: TextConst ENU = 'Order %1 created with succes, would you like to open it?',
                            FRA = 'Commande %1 a été créée, voulez-vous l''ouvrir?';
        ltext002: TextConst ENU = 'Purchase order is already created %1?',
                            FRA = 'Commande achat déjà créée %1?';
    begin

        if Rec."Purchase Order No." <> '' then
            Error(ltext002, rec."Purchase Order No.");

        Clear(NewPurchOrder);
        if pPostingType = pPostingType::Vendor then begin
            lPurchSetup.Get();
            lPurchSetup.TestField("Trans. Purch. Charge");
        end else begin
            lSalesSetup.Get();
            lSalesSetup.TestField("Transport Sales Item No.");
        end;

        rec.TestField("Transport To");
        rec.TestField(Desitnation);
        rec.TestField(City);
        rec.TestField("Country Code");
        rec.TestField(Amount);
        rec.TestField("Location Code");

        lPurchHdr.INIT;
        lPurchHdr."Document Type" := lPurchHdr."Document Type"::Order;
        lPurchHdr.INSERT(TRUE);
        lPurchHdr.VALIDATE("Buy-from Vendor No.", pVendorNo);
        lPurchHdr.VALIDATE("Document Date", WORKDATE);
        lPurchHdr.VALIDATE("Posting Date", WORKDATE);
        lPurchHdr."Transport Order" := true;
        lPurchHdr."Location Code" := Rec."Location Code";
        lPurchHdr."Your Reference" := Rec."External Doc No.";
        NewPurchOrder := lPurchHdr."No.";
        if lPurchHdr.MODIFY then begin
            lPurchLine.INIT;
            lPurchLine."Document Type" := lPurchLine."Document Type"::Order;
            lPurchLine."Document No." := lPurchHdr."No.";
            lPurchLine."Line No." := 10000;
            lPurchLine.INSERT(TRUE);

            if pPostingType = pPostingType::Vendor then begin
                lPurchLine.VALIDATE(Type, lPurchLine.Type::"Charge (Item)");
                lPurchLine.VALIDATE("No.", lPurchSetup."Trans. Purch. Charge");
            end else begin
                lPurchLine.VALIDATE(Type, lPurchLine.Type::Item);
                lPurchLine.VALIDATE("No.", lSalesSetup."Transport Sales Item No.");
            end;

            lPurchLine.VALIDATE(Quantity, 1);
            lPurchLine.Validate("Direct Unit Cost", rec.Amount);
            lPurchLine.MODIFY;
            rec.Status := rec.Status::Released;
            Rec."Purchase Order No." := NewPurchOrder;
        end;
        lPurchHdr.Reset;
        lPurchHdr.SetRange("Document Type", lPurchHdr."Document Type"::Order);
        lPurchHdr.SetRange("No.", NewPurchOrder);
        if lPurchHdr.FindFirst() then begin
            If Confirm(StrSubstNo(lText001, lPurchHdr."No.")) then begin
                lPurchaseOrderPage.SetTableView(lPurchHdr);
                lPurchaseOrderPage.Run();
            end;
        end;
    end;

    var
        NewPurchOrder: Code[20];
}
