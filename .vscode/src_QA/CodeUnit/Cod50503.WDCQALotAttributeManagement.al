codeunit 50503 "WDC-QALot Attribute Management"
{
    procedure GetLotAttributes(VAR LotAttributes: ARRAY[5] OF Code[10]; ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: Code[10]; SourceProdOrderLine: Integer)
    var
        LotNoInformation: Record "Lot No. Information";
        //LotAttributeBuffer: Record "Lot Attribute Buffer";
        TempTrackingSpecification: Record "Tracking Specification";
    begin
        CreateTempTracking(TempTrackingSpecification, ItemNo, VariantCode, LotNo, SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);
        // IF LotNoInformationExists(LotNoInformation, TempTrackingSpecification."Item No.", TempTrackingSpecification."Variant Code", TempTrackingSpecification."Lot No.") THEN BEGIN
        //     // LotAttributes[1] := LotNoInformation."Lot Attribute 1";
        //     // LotAttributes[2] := LotNoInformation."Lot Attribute 2";
        //     // LotAttributes[3] := LotNoInformation."Lot Attribute 3";
        //     // LotAttributes[4] := LotNoInformation."Lot Attribute 4";
        //     // LotAttributes[5] := LotNoInformation."Lot Attribute 5";
        // END ELSE BEGIN
        //     SetFilterLotAttributeBuffer(LotAttributeBuffer, TempTrackingSpecification."Item No.", TempTrackingSpecification."Variant Code", TempTrackingSpecification."Lot No.");
        //     IF LotAttributeBuffer.FINDFIRST THEN
        //         CopyLotAttributesFromLotAttributeBuffer(LotAttributeBuffer, LotAttributes)
        //     ELSE
        //         CLEAR(LotAttributes);
        // END;
    END;

    LOCAL procedure CreateTempTracking(VAR TempTrackingSpecification: Record "Tracking Specification" temporary; ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer; SourceBatchName: Code[10]; SourceProdOrderLine: Integer)
    begin
        TempTrackingSpecification.INIT;
        TempTrackingSpecification.SetSource(SourceType, SourceSubtype, SourceID, SourceRefNo, SourceBatchName, SourceProdOrderLine);
        TempTrackingSpecification."Item No." := ItemNo;
        TempTrackingSpecification."Variant Code" := VariantCode;
        TempTrackingSpecification."Lot No." := LotNo;
    end;
}
