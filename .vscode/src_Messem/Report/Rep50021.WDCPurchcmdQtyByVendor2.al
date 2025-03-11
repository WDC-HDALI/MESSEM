report 50021 "WDC Purch. cmd Qty By Vendor 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PurchcmdQtyByVendor2.rdlc';
    CaptionML = ENU = 'Merchandise receipt by vendor', FRA = 'Réception marchandise par fournisseur';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Entry Type" = CONST(Purchase),
                                      "Item Category Code" = FILTER('<>EMB'));
            RequestFilterFields = "Source No.", "Posting Date";
            column(PurchaseLine_Document_No; "Purchase Line"."Document No.")
            {
            }
            column(PurchaseLine_Buy_from_Vendor; "Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(Purchase_Line_Type; "Purchase Line".Type)
            {
            }
            column(Purchase_Line_No; "Purchase Line"."No.")
            {
            }
            column(Purchase_Line_Unit_of_Measure; "Purchase Line"."Unit of Measure")
            {
            }
            column(Purchase_Line_Quantity; "Item Ledger Entry".Quantity)
            {
            }
            column(Purchase_Line_Line_Discount; "Purchase Line"."Line Discount %")
            {
            }
            column(Purchase_Line_Unit_Price_per_Price_UOM; "Purchase Line"."Direct Unit Cost")
            {
            }
            column(Purchase_Line_LocationCode; "Purchase Line"."Location Code")
            {
            }
            column(Purchase_Line_Description; "Purchase Line".Description)
            {
            }
            column(PurchaseLine_Amount_Including_VAT; "Purchase Line"."Amount Including VAT" * Sign)
            {
                IncludeCaption = false;
            }
            column(getfilters; GETFILTERS)
            {
            }
            column(Companyname; CompanyInfo.Name)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(Title; Title)
            {
            }
            column(PurchRcptLineDocumentNo; "Item Ledger Entry"."Document No.")
            {
            }
            column(PurchRcptLinePostingDate; "Item Ledger Entry"."Posting Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CASE "Document Type" OF
                    "Document Type"::"Purchase Receipt":
                        BEGIN
                            IF PurchRcptLine.GET("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Document Line No.") THEN BEGIN
                                IF "Purchase Line".GET("Purchase Line"."Document Type"::Order, PurchRcptLine."Order No.",
                                    PurchRcptLine."Order Line No.") THEN;
                            END;
                            Sign := 1;
                        END;
                    "Document Type"::"Purchase Return Shipment":
                        BEGIN
                            IF ReturnShipmentLine.GET("Item Ledger Entry"."Document No.", "Item Ledger Entry"."Document Line No.") THEN BEGIN
                                IF "Purchase Line".GET("Purchase Line"."Document Type"::"Return Order", ReturnShipmentLine."Return Order No.",
                                    ReturnShipmentLine."Return Order Line No.") THEN;
                            END;
                            Sign := -1;
                        END;
                    "Document Type"::"Purchase Credit Memo":
                        begin
                            Sign := -1;
                        end;
                END;

                IF Vendor.GET("Purchase Line"."Buy-from Vendor No.") THEN;
            end;
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Title: TextConst ENU = 'Merchandise receipt by vendor', FRA = 'Réception marchandise par fournissuer';
        Vendor: Record 23;
        "Purchase Line": Record 39;
        ReturnShipmentLine: Record 6651;
        PurchRcptLine: Record 121;
        Sign: Decimal;
        CompanyInfo: record 79;
}

