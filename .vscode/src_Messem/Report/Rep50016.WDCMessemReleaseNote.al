report 50016 "WDC Messem-Release Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/MessemReleaseNote.rdlc';

    CaptionML = ENU = 'Release Note', FRA = 'Note de version';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
            column(NomShipMethCode; NomShipMethCode)
            {
            }
            column(NomShippngAgentCode; NomShippngAgentCode)
            {
            }
            column(NomMagasin; NomMagasin)
            {
            }
            column(CompanyIBAN; CompanyInformation.IBAN)
            {
            }
            column(CompanyEmail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyBankAccountNo; CompanyInformation."Bank Account No.")
            {
            }
            column(CompanyBankBranchNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBankName; CompanyInformation."Bank Name")
            {
            }
            column(CompanyGiroNo; CompanyInformation."Giro No.")
            {
            }
            column(CompanyPhone; CompanyInformation."Phone No.")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(No_SalesHeader; "No.")
            {
                IncludeCaption = true;
            }
            column(CustomerNo_SalesHeader; "Sell-to Customer No.")
            {
                IncludeCaption = true;
            }
            column(CustomerName_SalesHeader; "Sell-to Customer Name")
            {
                IncludeCaption = true;
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
            }
            column(ShipmentMethodCode_SalesHeader; "Sales Header"."Shipment Method Code")
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(LocationCode_SalesHeader; "Sales Header"."Location Code")
            {
            }
            column(ShippingAgentCode_SalesHeader; "Sales Header"."Shipping Agent Code")
            {
            }
            column(ShiptoName_SalesHeader; "Sales Header"."Ship-to Name")
            {
            }
            column(ShiptoAddress_SalesHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(ShiptoCity_SalesHeader; "Sales Header"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesHeader; "Sales Header"."Ship-to Contact")
            {
            }
            column(ShiptoPostCode_SalesHeader; "Sales Header"."Ship-to Post Code")
            {
            }
            column(SelltoAddress_SalesHeader; "Sales Header"."Sell-to Address")
            {
            }
            column(SelltoCity_SalesHeader; "Sales Header"."Sell-to City")
            {
            }
            column(SelltoContact_SalesHeader; "Sales Header"."Sell-to Contact")
            {
            }
            column(SelltoPostCode_SalesHeader; "Sales Header"."Sell-to Post Code")
            {
            }
            column(SelltoCounty_SalesHeader; "Sales Header"."Sell-to County")
            {
            }
            column(SelltoCountryRegionCode_SalesHeader; "Sales Header"."Sell-to Country/Region Code")
            {
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Type = CONST(Item));
                column(LineNo_SalesLine; "Line No.")
                {
                }
                column(ItemNo_SalesLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(Description_SalesLine; Description)
                {
                    IncludeCaption = true;
                }
                column(VariantCode_SalesLine; "Variant Code")
                {
                    IncludeCaption = true;
                }
                column(LocationCode_SalesLine; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(BinCode_SalesLine; "Bin Code")
                {
                    IncludeCaption = true;
                }
                column(ShipmentDate_SalesLine; FORMAT("Shipment Date"))
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitOfMeasure_SalesLine; "Unit of Measure")
                {
                    IncludeCaption = true;
                }
                column(QuantityToShip_SalesLine; "Qty. to Ship")
                {
                    IncludeCaption = true;
                }
                column(QuantityShipped_SalesLine; "Quantity Shipped")
                {
                    IncludeCaption = true;
                }
                column(LotNo; LotNo)
                {
                }
                column(QuantityShipmentUnits_SalesLine; "Sales Line"."Quantity Shipment Units")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ReserEntry.RESET;
                    ReserEntry.SETRANGE("Source ID", "Sales Line"."Document No.");
                    ReserEntry.SETRANGE("Source Type", 37);
                    ReserEntry.SETRANGE("Source Subtype", ReserEntry."Source Subtype"::"1");
                    ReserEntry.SETRANGE("Item No.", "Sales Line"."No.");
                    ReserEntry.SETRANGE("Source Ref. No.", "Sales Line"."Line No.");
                    ReserEntry.SETRANGE("Item Tracking", ReserEntry."Item Tracking"::"Lot No.");
                    IF NOT ReserEntry.FINDSET THEN
                        LotNo := ''
                    ELSE
                        LotNo := ReserEntry."Lot No.";

                    IF LotNo = '' THEN GetLotInformation;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ShipmentMethod.RESET;
                IF ShipmentMethod.GET("Sales Header"."Shipment Method Code") THEN;
                NomShipMethCode := ShipmentMethod.Description;
                Location.RESET;
                IF Location.GET("Sales Header"."Location Code") THEN;
                NomMagasin := Location.Name;
                ShippingAgent.RESET;
                IF ShippingAgent.GET("Sales Header"."Shipping Agent Code") THEN;
                NomShippngAgentCode := ShippingAgent.Name;
            end;
        }
    }

    trigger OnInitReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        LotNo: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReserEntry: Record "Reservation Entry";
        Location: Record Location;
        NomMagasin: Text;
        ShippingAgent: Record "Shipping Agent";
        NomShippngAgentCode: Text;
        ShipmentMethod: Record "Shipment Method";
        NomShipMethCode: Text[50];

    procedure GetLotInformation()
    var
        lSalesShipmentLine: Record "Sales Shipment Line";
        lItemLedgerEntry: Record "Item Ledger Entry";
    begin
        lSalesShipmentLine.RESET;
        lSalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        lSalesShipmentLine.SETRANGE("Order No.", "Sales Line"."Document No.");
        lSalesShipmentLine.SETRANGE("Order Line No.", "Sales Line"."Line No.");
        IF lSalesShipmentLine.FINDSET THEN BEGIN
            lItemLedgerEntry.SETRANGE("Document No.", lSalesShipmentLine."Document No.");
            lItemLedgerEntry.SETRANGE("Document Line No.", lSalesShipmentLine."Line No.");
            IF lItemLedgerEntry.FINDFIRST THEN
                LotNo := lItemLedgerEntry."Lot No.";
        END;
    end;
}

