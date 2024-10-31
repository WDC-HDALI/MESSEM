codeunit 50002 "WDC Lot Attribute Mngmt"
{
    trigger OnRun()
    begin
    end;

    local procedure LotNoInformationExists(var LotNoInformation: Record 6505; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]): Boolean
    begin
        IF NOT LotNoInformation.GET(ItemNo, VariantCode, LotNo) THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;

    local procedure LotAttributeBufferExists(var LotAttributeBuffer: Record "WDC Lot Attribute Buffer"; SourceSpecification: Record 336 temporary): Boolean
    begin
        IF NOT LotAttributeBuffer.GET(SourceSpecification."Item No.", SourceSpecification."Variant Code", SourceSpecification."Lot No.", SourceSpecification."Source Type", SourceSpecification."Source Subtype", SourceSpecification."Source ID", SourceSpecification."Source Batch Name", SourceSpecification."Source Prod. Order Line", SourceSpecification."Source Ref. No.") THEN
            EXIT(FALSE);
        EXIT(TRUE);
    END;

    procedure GetLotAttributes(var LotAttributes: array[5] of code[20]; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: code[20]; SourceProdOrderLine: Integer)
    var
        LotNoInformation: Record 6505;
        LotAttributeBuffer: Record "WDC Lot Attribute Buffer";
        TempTrackingSpecification: Record 336 temporary;
    begin
        CreateTempTracking(TempTrackingSpecification, ItemNo, VariantCode, LotNo, SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);

        IF LotNoInformationExists(LotNoInformation, TempTrackingSpecification."Item No.", TempTrackingSpecification."Variant Code", TempTrackingSpecification."Lot No.") THEN BEGIN
            LotAttributes[1] := LotNoInformation."Lot Attribute 1";
            LotAttributes[2] := LotNoInformation."Lot Attribute 2";
            LotAttributes[3] := LotNoInformation."Lot Attribute 3";
            LotAttributes[4] := LotNoInformation."Lot Attribute 4";
            LotAttributes[5] := LotNoInformation."Lot Attribute 5";
        END ELSE BEGIN
            SetFilterLotAttributeBuffer(LotAttributeBuffer, TempTrackingSpecification."Item No.", TempTrackingSpecification."Variant Code", TempTrackingSpecification."Lot No.");
            IF LotAttributeBuffer.FINDFIRST THEN
                CopyLotAttributesFromLotAttributeBuffer(LotAttributeBuffer, LotAttributes)
            ELSE
                CLEAR(LotAttributes);
        END;
    END;


    local procedure ValidLotAttribute(AttributeNo: Integer; AttributeCode: Code[20])
    var
        LotAttributeValue: Record "WDC Lot Attribute Value";
    begin
        IF AttributeCode <> '' THEN
            LotAttributeValue.GET(AttributeNo, AttributeCode);
    end;

    local procedure SetFilterLotAttributeBuffer(var LotAttributeBuffer: Record "WDC Lot Attribute Buffer"; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20])
    begin
        LotAttributeBuffer.SETRANGE("Item No.", ItemNo);
        LotAttributeBuffer.SETRANGE("Variant Code", VariantCode);
        LotAttributeBuffer.SETRANGE("Lot No.", LotNo);
    end;

    local procedure SetSourceFilterLotAttributeBuffer(var LotAttributeBuffer: Record "WDC Lot Attribute Buffer"; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: code[20]; SourceProdOrderLine: Integer)
    begin
        LotAttributeBuffer.RESET;
        LotAttributeBuffer.SETRANGE("Source Type", SourceType);
        LotAttributeBuffer.SETRANGE("Source Subtype", SourceSubtype);
        LotAttributeBuffer.SETRANGE("Source ID", SourceID);
        LotAttributeBuffer.SETRANGE("Source Ref. No.", SourceRefNo);
        LotAttributeBuffer.SETRANGE("Source Batch Name", SourceBatchName);
        IF SourceProdOrderLine <> 0 THEN
            LotAttributeBuffer.SETRANGE("Source Prod. Order Line", SourceProdOrderLine);
    END;

    local procedure CreateLotAttributeBuffer(SourceSpecification: Record 336 temporary; var LotAttributeBuffer: Record "WDC Lot Attribute Buffer")
    begin

        LotAttributeBuffer.INIT;
        LotAttributeBuffer."Item No." := SourceSpecification."Item No.";
        LotAttributeBuffer."Variant Code" := SourceSpecification."Variant Code";
        LotAttributeBuffer."Lot No." := SourceSpecification."Lot No.";
        LotAttributeBuffer."Source Type" := SourceSpecification."Source Type";
        LotAttributeBuffer."Source Subtype" := SourceSpecification."Source Subtype";
        LotAttributeBuffer."Source ID" := SourceSpecification."Source ID";
        LotAttributeBuffer."Source Batch Name" := SourceSpecification."Source Batch Name";
        LotAttributeBuffer."Source Prod. Order Line" := SourceSpecification."Source Prod. Order Line";
        LotAttributeBuffer."Source Ref. No." := SourceSpecification."Source Ref. No.";
        LotAttributeBuffer.INSERT;

    end;

    local procedure CreateTempTracking(var TempTrackingSpecification: Record 336 temporary; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: code[20]; SourceProdOrderLine: Integer)
    begin
        TempTrackingSpecification.INIT;
        TempTrackingSpecification.SetSource(SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);
        TempTrackingSpecification."Item No." := ItemNo;
        TempTrackingSpecification."Variant Code" := VariantCode;
        TempTrackingSpecification."Lot No." := LotNo;
    end;

    procedure ModifyLotAttributes(LotAttributes: array[5] of code[20]; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: code[20]; SourceProdOrderLine: Integer)
    var
        LotAttributeValue: Record "WDC Lot Attribute Value";
        LotAttributeNo: Integer;
        LotNoInformation: Record 6505;
        LotAttributeBuffer: Record "WDC Lot Attribute Buffer";
        TempTrackingSpecification: Record 336 temporary;
    begin
        FOR LotAttributeNo := 1 TO 5 DO
            ValidLotAttribute(LotAttributeNo, LotAttributes[LotAttributeNo]);

        CreateTempTracking(TempTrackingSpecification, ItemNo, VariantCode, LotNo, SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);
        WITH TempTrackingSpecification DO BEGIN
            IF LotNoInformation.GET("Item No.", "Variant Code", "Lot No.") THEN BEGIN
                CopyLotAttributesToLotNoInformation(LotNoInformation, LotAttributes);
                LotNoInformation.MODIFY;
            END ELSE BEGIN
                IF NOT LotAttributeBufferExists(LotAttributeBuffer, TempTrackingSpecification) THEN
                    CreateLotAttributeBuffer(TempTrackingSpecification, LotAttributeBuffer);
                ModifyLotAttributeBuffer(LotAttributeBuffer, "Item No.", "Variant Code", "Lot No.", LotAttributes);
            END;
        END;
    end;

    local procedure ModifyLotAttributeBuffer(var LotAttributeBuffer: Record "WDC Lot Attribute Buffer"; ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]; LotAttributes: array[5] of code[20])
    begin
        SetFilterLotAttributeBuffer(LotAttributeBuffer, ItemNo, VariantCode, LotNo);
        IF LotAttributeBuffer.FINDSET THEN
            REPEAT
                LotAttributeBuffer."Lot Attribute 1" := LotAttributes[1];
                LotAttributeBuffer."Lot Attribute 2" := LotAttributes[2];
                LotAttributeBuffer."Lot Attribute 3" := LotAttributes[3];
                LotAttributeBuffer."Lot Attribute 4" := LotAttributes[4];
                LotAttributeBuffer."Lot Attribute 5" := LotAttributes[5];
                LotAttributeBuffer.MODIFY;
            UNTIL LotAttributeBuffer.NEXT = 0;
    end;

    local procedure DeleteLotAttributeBuffer(ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20])
    var
        LotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    begin
        SetFilterLotAttributeBuffer(LotAttributeBuffer, ItemNo, VariantCode, LotNo);
        IF NOT LotAttributeBuffer.ISEMPTY THEN
            LotAttributeBuffer.DELETEALL;
    end;

    local procedure DeleteDocumentAttributes(SourceType: Integer; SourceSubtype: Option; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: code[20]; SourceProdOrderLine: Integer)
    var
        LotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    begin
        SetSourceFilterLotAttributeBuffer(LotAttributeBuffer, SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);
        IF NOT LotAttributeBuffer.ISEMPTY THEN
            LotAttributeBuffer.DELETEALL;
    end;

    procedure DeleteDocumentAttributesForPurchaseLine(PurchaseLine: Record 39)
    begin
        DeleteDocumentAttributes(DATABASE::"Purchase Line", PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.", '', 0);
    end;

    procedure DeleteDocumentAttributesForItemJournalLine(ItemJournalLine: Record 83)
    begin
        DeleteDocumentAttributes(DATABASE::"Item Journal Line", ItemJournalLine."Entry Type", ItemJournalLine."Journal Template Name", ItemJournalLine."Line No.", ItemJournalLine."Journal Batch Name", 0);
    end;

    procedure DeleteDocumentAttributesForProductionOrder(ProductionOrder: Record 5405)
    begin
        DeleteDocumentAttributes(DATABASE::"Prod. Order Line", ProductionOrder.Status, ProductionOrder."No.", 0, '', 0);
    end;

    procedure DeleteDocumentAttributesForProdOrderLine(ProdOrderLine: Record 5406)
    begin

        DeleteDocumentAttributes(DATABASE::"Prod. Order Line", ProdOrderLine.Status, ProdOrderLine."Prod. Order No.", 0, '', ProdOrderLine."Line No.");
    end;

    procedure TransferLotAttributeBufferToLotNoInformation(ItemNo: Code[20]; VariantCode: code[20]; LotNo: Code[20]; var LotAttributes: array[5] of code[20])
    var
        LotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    begin
        SetFilterLotAttributeBuffer(LotAttributeBuffer, ItemNo, VariantCode, LotNo);
        IF NOT LotAttributeBuffer.FINDFIRST THEN
            EXIT;

        CopyLotAttributesFromLotAttributeBuffer(LotAttributeBuffer, LotAttributes);
        DeleteLotAttributeBuffer(ItemNo, VariantCode, LotNo);
    end;

    // procedure TransferProductionOrderToProductionOrder(FromProdudctionOrder: Record 5405; ToProductionOrder: Record 5405)
    // var
    //     ToLotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    //     FromtLotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    // begin
    //     SetSourceFilterLotAttributeBuffer(FromtLotAttributeBuffer, DATABASE::"Prod. Order Line", FromProdudctionOrder.Status, FromProdudctionOrder."No.", 0, '', 0);
    //     IF FromtLotAttributeBuffer.ISEMPTY THEN
    //         EXIT;

    //     IF FromtLotAttributeBuffer.FINDSET THEN
    //         REPEAT
    //             ToLotAttributeBuffer := FromtLotAttributeBuffer;
    //             ToLotAttributeBuffer."Source Subtype" := ToProductionOrder.Status;
    //             ToLotAttributeBuffer."Source ID" := ToProductionOrder."No.";
    //             ToLotAttributeBuffer.INSERT
    //         UNTIL FromtLotAttributeBuffer.NEXT = 0;
    // end;

    // procedure TransferPurchaseLineToPurchaseLine(FromPurchaseLine: Record 39; ToPurchaseLine: Record 39)
    // var
    //     ToLotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    //     FromtLotAttributeBuffer: Record "WDC Lot Attribute Buffer";
    // begin
    //     SetSourceFilterLotAttributeBuffer(FromtLotAttributeBuffer, DATABASE::"Purchase Line", FromPurchaseLine."Document Type", FromPurchaseLine."Document No.", FromPurchaseLine."Line No.", '', 0);
    //     IF FromtLotAttributeBuffer.ISEMPTY THEN
    //         EXIT;

    //     IF FromtLotAttributeBuffer.FINDSET THEN
    //         REPEAT
    //             ToLotAttributeBuffer := FromtLotAttributeBuffer;
    //             ToLotAttributeBuffer."Source Subtype" := ToPurchaseLine."Document Type";
    //             ToLotAttributeBuffer."Source ID" := ToPurchaseLine."Document No.";
    //             ToLotAttributeBuffer."Source Ref. No." := ToPurchaseLine."Line No.";
    //             ToLotAttributeBuffer.INSERT
    //         UNTIL FromtLotAttributeBuffer.NEXT = 0;
    // end;

    local procedure CopyLotAttributesToLotNoInformation(var LotNoInformation: Record 6505; LotAttributes: array[5] of code[20])
    begin
        LotNoInformation."Lot Attribute 1" := LotAttributes[1];
        LotNoInformation."Lot Attribute 2" := LotAttributes[2];
        LotNoInformation."Lot Attribute 3" := LotAttributes[3];
        LotNoInformation."Lot Attribute 4" := LotAttributes[4];
        LotNoInformation."Lot Attribute 5" := LotAttributes[5];
    end;

    local procedure CopyLotAttributesFromLotAttributeBuffer(LotAttributeBuffer: Record "WDC Lot Attribute Buffer"; var LotAttributes: array[5] of code[20])
    begin
        LotAttributes[1] := LotAttributeBuffer."Lot Attribute 1";
        LotAttributes[2] := LotAttributeBuffer."Lot Attribute 2";
        LotAttributes[3] := LotAttributeBuffer."Lot Attribute 3";
        LotAttributes[4] := LotAttributeBuffer."Lot Attribute 4";
        LotAttributes[5] := LotAttributeBuffer."Lot Attribute 5";
    end;
}

