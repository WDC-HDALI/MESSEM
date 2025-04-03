report 50006 "WDC Receipt Label"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/ReceiptLabel.rdlc';
    CaptionML = ENU = 'Receipt Label', FRA = 'Étiquette réception';
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; 38)
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order));
            dataitem("Purchase Line"; 39)
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = CONST(Item));

                trigger OnAfterGetRecord()
                begin
                    PalletTotal += "Purchase Line"."Quantity Shipment Containers";
                    LotNo := '';
                    ReservEntry.RESET;
                    ReservEntry.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.", "Reservation Status", "Expected Receipt Date");
                    ReservEntry.SETRANGE("Source Type", 39);
                    ReservEntry.SETRANGE("Source Subtype", ReservEntry."Source Subtype"::"1");
                    ReservEntry.SETRANGE("Source ID", "Purchase Header"."No.");
                    ReservEntry.SETRANGE("Item No.", "Purchase Line"."No.");
                    IF ReservEntry.FINDSET THEN
                        LotNo := ReservEntry."Lot No."
                    ELSE BEGIN
                        TrackingSpecif.RESET;
                        TrackingSpecif.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
                        TrackingSpecif.SETRANGE("Source Type", 39);
                        TrackingSpecif.SETRANGE("Source Subtype", TrackingSpecif."Source Subtype"::"1");
                        TrackingSpecif.SETRANGE("Source ID", "Purchase Header"."No.");
                        TrackingSpecif.SETRANGE("Source Ref. No.", "Purchase Line"."Line No.");
                        TrackingSpecif.SETRANGE("Item No.", "Purchase Line"."No.");
                        IF TrackingSpecif.FINDSET THEN
                            LotNo := TrackingSpecif."Lot No.";
                    END;

                    IF LotNo = '' THEN
                        CurrReport.SKIP;

                    QuantityShipmentUnits += "Purchase Line"."Quantity Shipment Units";
                    ScaleWeight += "Purchase Line"."Scale Weight";
                end;
            }
            dataitem(DataItem1100281011; integer)
            {
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(PalletNo; PalletNo)
                {
                }
                column(PalletTotal; PalletTotal)
                {
                }
                column(QuantityShipmentUnits_PurchaseLine; QuantityShipmentUnits)
                {
                }
                column(LotNo; LotNo)
                {
                }
                column(ScaleWeight_PurchaseLine; ScaleWeight)
                {
                }
                column(ItemNo_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                {
                }
                column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
                {
                }
                column(No_PurchaseHeader; "Purchase Header"."No.")
                {
                }
                column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PalletNo >= PalletTotal THEN
                        CurrReport.BREAK;
                    PalletNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    PalletNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TrackingSpecif.RESET;
                TrackingSpecif.SETRANGE("Source Type", 39);
                TrackingSpecif.SETRANGE("Source Subtype", TrackingSpecif."Source Subtype"::"1");
                TrackingSpecif.SETRANGE("Source ID", "Purchase Header"."No.");
                IF NOT TrackingSpecif.FINDSET THEN
                    EXIT;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

                PalletNo := 0;
                PalletTotal := 0;
                QuantityShipmentUnits := 0;
                ScaleWeight := 0;
            end;
        }
    }
    var
        CompanyInfo: Record 79;
        TrackingSpecif: Record 336;
        ReservEntry: Record 337;
        LotNo: Code[20];
        PalletNo: Integer;
        PalletTotal: Integer;
        PictureSend: Boolean;
        QuantityShipmentUnits: Decimal;
        ScaleWeight: Decimal;
}

