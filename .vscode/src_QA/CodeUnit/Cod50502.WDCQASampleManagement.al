codeunit 50502 "WDC-QA Sample Management"
{
    procedure ModifyNewVendorFlag(VAR LotNoInformation: Record "Lot No. Information"; InspectionStatusIn: Record "WDC-QA Inspection Status")
    var
        VendorRec: Record Vendor;
        InspectionStatus: Record "WDC-QA Inspection Status";
        LotNoInformation2: Record "Lot No. Information";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchRcptLine2: Record "Purch. Rcpt. Line";
        PurchReceiptNo: Code[20];
        OtherLotQC: Boolean;
        OtherLotTakeSample: Boolean;
        OtherLotRejected: Boolean;
        OtherLotSampleNewVendor: Boolean;
    begin
        // SampleApproved := FALSE;
        // IF VendorRec.GET(LotNoInformation."Buy-from Vendor No.") THEN
        //     IF VendorRec."Method Sample" = VendorRec."Method Sample"::" " THEN
        //         EXIT;

        // IF InspectionStatusIn."Result Sample" = InspectionStatusIn."Result Sample"::" " THEN
        //     EXIT;

        // IF InspectionStatusIn."Result Sample" = InspectionStatusIn."Result Sample"::"Take Sample" THEN BEGIN
        //     LotNoInformation."Take Sample At Random" := TRUE;
        //     EXIT;
        // END;

        // IF (InspectionStatusIn."Result Sample" = InspectionStatusIn."Result Sample"::Approved) THEN
        //     SampleApproved := TRUE;

        // IF (InspectionStatusIn."Result Sample" = InspectionStatusIn."Result Sample"::Rejected) THEN
        //     SampleApproved := FALSE;

        // IF LotNoInformation."Take Sample At Random" THEN
        //     LotNoInformation."Sample At Random Stat. Modif." := WORKDATE;

        // LotNoInformation."Sample At Random New Vendor" := FALSE;

        // //Find Receipt
        // PurchRcptLine.SETRANGE("No.", LotNoInformation."Item No.");
        // PurchRcptLine.SETRANGE("Variant Code", LotNoInformation."Variant Code");
        // PurchRcptLine.SETRANGE("Lot No.", LotNoInformation."Lot No.");
        // PurchRcptLine.SETRANGE("Buy-from Vendor No.", LotNoInformation."Buy-from Vendor No.");
        // IF PurchRcptLine.FINDSET THEN
        //     PurchReceiptNo := PurchRcptLine."Document No.";

        // LotNoInformation2.SETCURRENTKEY("Buy-from Vendor No.");
        // LotNoInformation2.SETRANGE("Buy-from Vendor No.", LotNoInformation."Buy-from Vendor No.");
        // IF LotNoInformation2.FINDSET THEN
        //     REPEAT
        //         //Check if lotnumber is for the same Purch Receipt.
        //         PurchRcptLine2.SETRANGE("No.", LotNoInformation2."Item No.");
        //         PurchRcptLine2.SETRANGE("Variant Code", LotNoInformation2."Variant Code");
        //         PurchRcptLine2.SETRANGE("Lot No.", LotNoInformation2."Lot No.");
        //         PurchRcptLine2.SETRANGE("Buy-from Vendor No.", LotNoInformation."Buy-from Vendor No.");
        //         IF PurchRcptLine2.FINDSET THEN
        //             REPEAT
        //                 IF (PurchReceiptNo = PurchRcptLine2."Document No.") AND
        //                    (LotNoInformation."Lot No." <> LotNoInformation2."Lot No.") THEN
        //                     IF InspectionStatus.GET(LotNoInformation2."Inspection Status") THEN BEGIN
        //                         IF LotNoInformation2.QC THEN BEGIN
        //                             OtherLotQC := TRUE;
        //                             PurchRcptLine2.NEXT := 0;
        //                         END;
        //                         IF LotNoInformation2."Take Sample At Random" THEN BEGIN
        //                             OtherLotTakeSample := TRUE;
        //                             PurchRcptLine2.NEXT := 0;
        //                         END;
        //                         IF InspectionStatus."Result Sample" = InspectionStatus."Result Sample"::Rejected THEN BEGIN
        //                             OtherLotRejected := TRUE;
        //                             PurchRcptLine2.NEXT := 0;
        //                         END;
        //                     END;
        //             UNTIL PurchRcptLine2.NEXT <= 0;
        //         IF (LotNoInformation2."Sample At Random New Vendor") AND
        //            (LotNoInformation."Lot No." <> LotNoInformation2."Lot No.") THEN
        //             OtherLotSampleNewVendor := TRUE;
        //     UNTIL LotNoInformation2.NEXT <= 0;
        // IF VendorRec.GET(LotNoInformation."Buy-from Vendor No.") THEN BEGIN
        //     IF SampleApproved THEN BEGIN
        //         LotNoInformation."Take Sample At Random" := FALSE;
        //         IF (NOT OtherLotQC) AND (NOT OtherLotTakeSample) AND (NOT OtherLotRejected) AND
        //            (NOT OtherLotSampleNewVendor) THEN BEGIN
        //             IF VendorRec."Method Sample" = VendorRec."Method Sample"::Sample THEN
        //                 IF VendorRec."Count Samples" < VendorRec."Treshhold Sample" THEN
        //                     VendorRec."New Vendor" := TRUE
        //                 ELSE
        //                     VendorRec."New Vendor" := FALSE
        //             ELSE
        //                 VendorRec."New Vendor" := FALSE;
        //         END;
        //     END ELSE BEGIN
        //         LotNoInformation."Take Sample At Random" := FALSE;
        //         IF NOT OtherLotQC THEN BEGIN
        //             VendorRec."New Vendor" := TRUE;
        //         END;
        //         IF VendorRec."Method Sample" = VendorRec."Method Sample"::Sample THEN BEGIN
        //             VendorRec."Count Received Lines" := 0;
        //             VendorRec."Count Samples" := 0;
        //         END;
        //     END;
        //     VendorRec.MODIFY
        // END;
    end;

    procedure UpdateOtherLotsWhenRejected(VendorNo: Code[20])
    var
        LotNoInformation: Record "Lot No. Information";
        LotNoInformation2: Record "Lot No. Information";
        InspectionStatus: Record "WDC-QA Inspection Status";
    begin
        IF NOT SampleApproved THEN BEGIN
            LotNoInformation.SETRANGE("Buy-from Vendor No.", VendorNo);
            //LotNoInformation.SETRANGE(LotNoInformation."Take Sample At Random");
            IF LotNoInformation.FINDSET THEN
                REPEAT
                    IF InspectionStatus.GET(LotNoInformation."Inspection Status") THEN
                        IF InspectionStatus."Result Sample" = InspectionStatus."Result Sample"::"Take Sample" THEN BEGIN
                            LotNoInformation2.COPY(LotNoInformation);
                            //LotNoInformation2."Take Sample At Random" := TRUE;
                            LotNoInformation2.QC := TRUE;
                            LotNoInformation2.MODIFY;
                        END;
                UNTIL LotNoInformation.NEXT <= 0;
        END;
    end;

    var
        SampleApproved: Boolean;
}
