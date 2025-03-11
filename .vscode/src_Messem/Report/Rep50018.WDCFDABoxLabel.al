report 50018 "WDC FDA Box Label"
{
    CaptionML = ENU = 'FDA Box Label', FRA = 'Étiquette FDA carton';
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/FDABoxLabel.rdlc';
    DefaultLayout = RDLC;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.")
                                ORDER(Ascending);
            dataitem(PageLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(CopyVal; Number)
                {
                }
                dataitem("Prod. Order Line"; "Prod. Order Line")
                {
                    DataItemLink = "Prod. Order No." = FIELD("No.");
                    DataItemLinkReference = "Production Order";
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.")
                                        ORDER(Ascending);
                    column(BoxNo; BoxNo)
                    {
                    }
                    column(LabelBoxNo; LabelBoxNo)
                    {
                    }
                    column(No_ProductionOrder; "Production Order"."No.")
                    {
                    }
                    column(Description_ProductionOrder; "Production Order".Description)
                    {
                    }
                    column(Description2_ProductionOrder; "Production Order"."Description 2")
                    {
                    }
                    column(SourceNo_ProductionOrder; "Production Order"."Source No.")
                    {
                    }
                    column(CompImage; CompanyInformation.Picture)
                    {
                    }
                    column(ProductionDate; ProductionDate)
                    {
                    }
                    column(BestBefore; BestBefore)
                    {
                    }
                    column(LotNo; LotNo)
                    {
                    }
                    column(NetWeight; NetWeight)
                    {
                    }
                    column(ItemDescription; ItemDescription)
                    {
                    }
                    column(ItemDescription2; ItemDescription2)
                    {
                    }
                    column(NetWeight_ProdOrderLine; "Prod. Order Line"."Net Weight")
                    {
                    }
                    column(ItemNo_ProdOrderLine; "Prod. Order Line"."Item No.")
                    {
                    }
                    column(CompanyInformation_Image; CompanyInformation.Picture)
                    {
                    }
                    column(TextProductionDate; TextProductionDate)
                    {
                    }
                    column(TextBestBefore; TextBestBefore)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(LabelBoxNo);
                    MfgSetup.GET();
                    MfgSetup.TESTFIELD("Box No.");
                    LabelBoxNo := NoSeriesMgt.GetNextNo(MfgSetup."Box No.", 0D, TRUE);
                    IF STRLEN(LabelBoxNo) < 4 THEN
                        CASE STRLEN(LabelBoxNo) OF
                            1:
                                LabelBoxNo := '000' + LabelBoxNo;
                            2:
                                LabelBoxNo := '00' + LabelBoxNo;
                            3:
                                LabelBoxNo := '0' + LabelBoxNo;
                        END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, BoxNo);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SETRANGE("Order No.", "Production Order"."No.");
                ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                IF ItemLedgerEntry.FINDSET THEN
                    LotNo := ItemLedgerEntry."Lot No.";
                Item.GET("Production Order"."Source No.");
                NetWeight := Item."Qty. per Shipment Unit";
                ItemDescription := Item.Description;
                ItemDescription2 := Item."Description 2";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("No. Print Box Label")
                {
                    CaptionML = ENU = 'No. Print Box Label', FRA = 'Nombre d''étiquette à imprimer';
                    field(BoxNo; BoxNo)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Number of labels to print', FRA = 'Nombre d''étiquette à imprimer';
                    }
                    field(PrintedLabelsNb; PrintedLabelsNb)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Number of labels printed', FRA = 'Nombre d''étiquette imprimée';
                        Editable = false;
                    }
                    field(ProductionDate; ProductionDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Production Date', FRA = 'Date de production';
                    }
                    field(BestBefore; BestBefore)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';

                        trigger OnValidate()
                        begin
                            IF BestBefore <= ProductionDate THEN
                                ERROR(Text001);
                        end;
                    }
                }
            }
        }
        trigger OnOpenPage()
        begin
            BoxNo := BoxNo1;
            ProductionDate := WORKDATE;
            BestBefore := CALCDATE('<+2Y-CM>', WORKDATE);
        end;
    }
    trigger OnPostReport()
    begin
        CalcPosPrintNo("Production Order");
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        CompanyInformation.CALCFIELDS(Picture);
        IF BestBefore <= ProductionDate THEN
            ERROR(Text001);
        TextProductionDate := DateFormat(ProductionDate);
        TextBestBefore := DateFormat(BestBefore);
    end;

    procedure CalcPrePrintNo(pProductionOrder: Record "Production Order")
    var
        lProductionOrder: Record "Production Order";
        lItemLedgerEntry: Record "Item Ledger Entry";
        lItem: Record Item;
        lProductionQty: Decimal;
        lNoToPrint: Integer;
    begin
        lProductionOrder.GET(pProductionOrder.Status, pProductionOrder."No.");
        lItem.GET(lProductionOrder."Source No.");
        lItemLedgerEntry.RESET;
        lItemLedgerEntry.SETRANGE("Entry Type", lItemLedgerEntry."Entry Type"::Output);
        lItemLedgerEntry.SETRANGE("Order No.", lProductionOrder."No.");
        lItemLedgerEntry.SETRANGE("Order Type", lItemLedgerEntry."Order Type"::Production);
        IF lItemLedgerEntry.FINDSET THEN
            REPEAT
                lProductionQty += lItemLedgerEntry.Quantity;
            UNTIL lItemLedgerEntry.NEXT = 0;
        IF lItem."Qty. per Shipment Unit" = 0 THEN
            EXIT;
        lNoToPrint := ROUND(lProductionQty / lItem."Qty. per Shipment Unit", 1);
        BoxNo1 := lNoToPrint - lProductionOrder."No. of  printed  labels";
        PrintedLabelsNb := lProductionOrder."No. of  printed  labels";
    end;

    procedure CalcPosPrintNo(pProductionOrder: Record "Production Order")
    var
        lProductionOrder: Record "Production Order";
        lItemLedgerEntry: Record "Item Ledger Entry";
        lItem: Record Item;
        lProductionQty: Decimal;
    begin
        lProductionOrder.GET(pProductionOrder.Status, pProductionOrder."No.");
        lProductionOrder."No. of  printed  labels" += BoxNo;
        lProductionOrder.MODIFY;
    end;

    local procedure DateFormat(pDate: Date) text: Text
    var
        d: Text;
        m: Text;
        y: Text;
        lDateText: Text;
    begin
        d := FORMAT(pDate, 2, '<Day,2>');
        y := FORMAT(pDate, 2, '<Year,2>');
        CASE DATE2DMY(pDate, 2) OF
            1:
                m := 'Jan';
            2:
                m := 'Feb';
            3:
                m := 'Mar';
            4:
                m := 'Apr';
            5:
                m := 'May';
            6:
                m := 'Jun';
            7:
                m := 'Jul';
            8:
                m := 'Aug';
            9:
                m := 'Sep';
            10:
                m := 'Oct';
            11:
                m := 'Nov';
            12:
                m := 'Dec';
        END;
        lDateText := FORMAT(d + ' ' + m + ' ' + y);
        EXIT(lDateText);
    end;

    var
        BoxNo: Integer;
        BoxNo1: Integer;
        CompanyInformation: Record "Company Information";
        BestBefore: Date;
        ProductionDate: Date;
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        MfgSetup: Record "Manufacturing Setup";
        LotNo: Code[20];
        NetWeight: Decimal;
        Expr1: Text;
        ItemDescription: Text;
        ItemDescription2: Text;
        NoSeriesMgt: Codeunit "No. Series";
        LabelBoxNo: Code[10];
        ProductionOrder2: Record "Production Order";
        PrintedLabelsNb: Integer;
        TextProductionDate: Text;
        TextBestBefore: Text;
        Text001: TextConst ENU = 'The expiry date must be after the production date',
                           FRA = 'La date d''expiration doit être supérieure à la date de production';
}

