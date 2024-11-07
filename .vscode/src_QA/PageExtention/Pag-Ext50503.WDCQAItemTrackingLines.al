namespace MessemMA.MessemMA;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Sales.Document;

pageextension 50503 "WDC-QA Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {
        modify("Lot No.")
        {
            trigger OnAssistEdit()
            var
                myInt: Integer;
            begin
                IF FormRunMode = FormRunMode::Reclass THEN
                    Rec.VALIDATE("New Lot No.", Rec."Lot No.");
            end;
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        IF UpdateUndefinedQty OR SaveAnyway THEN
            WriteToDatabase;
        IF FormRunMode = FormRunMode::"Drop Shipment" THEN
            CASE CurrentSourceType OF
                DATABASE::"Sales Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015, Text016));
                DATABASE::"Purchase Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015, Text017));
            END;
        IF FormRunMode = FormRunMode::Transfer THEN
            SynchronizeLinkedSources('');
        SynchronizeWarehouseItemTracking;
    end;

    procedure SetFormRunMode(Mode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment")
    begin
        FormRunMode := Mode;
    end;

    procedure TempItemTrackingDefFW(NewTrackingSpecification: Record "Tracking Specification")
    begin
        TempItemTrackingDef(NewTrackingSpecification);
    end;

    LOCAL procedure TempItemTrackingDef(NewTrackingSpecification: Record "Tracking Specification")
    begin
        IF OnTransfer THEN
            InsertIsBlocked := FALSE;
        //
        Rec := NewTrackingSpecification;
        Rec."Entry No." := NextEntryNo;
        IF (NOT InsertIsBlocked) AND (NOT ZeroLineExists) THEN
            IF NOT TestTempSpecificationExists THEN
                Rec.INSERT
            ELSE
                ModifyTrackingSpecification(NewTrackingSpecification);

        WriteToDatabase;
    end;

    LOCAL procedure ModifyTrackingSpecification(NewTrackingSpecification: Record "Tracking Specification")
    var
        CrntTempTrackingSpec: Record "Tracking Specification";
    begin
        CrntTempTrackingSpec.COPY(Rec);
        Rec.SETCURRENTKEY("Lot No.", "Serial No.");
        Rec.SETRANGE("Lot No.", NewTrackingSpecification."Lot No.");
        Rec.SETRANGE("Serial No.", NewTrackingSpecification."Serial No.");
        //Rec.SETRANGE("Container No.", NewTrackingSpecification."Container No.");
        Rec.SETFILTER("Entry No.", '<>%1', Rec."Entry No.");
        Rec.SETRANGE("Buffer Status", 0);
        IF Rec.FIND('-') THEN BEGIN
            Rec.VALIDATE("Quantity (Base)", Rec."Quantity (Base)" + NewTrackingSpecification."Quantity (Base)");
            Rec.MODIFY;
        END;
        Rec.COPY(CrntTempTrackingSpec);
    end;

    var
        SaveAnyway: Boolean;
        OnTransfer: Boolean;
        FormRunMode: Option " ",Reclass,"Combined Ship/Rcpt","Drop Shipment",Transfer;
        Text015: TextConst ENU = 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?', FRA = 'Souhaitez-vous synchroniser la traçabilité de la ligne avec la traçabilité de la livraison directe %1 associée ?';
        Text016: TextConst ENU = 'purchase order line', FRA = 'ligne commande achat';
        Text017: TextConst ENU = 'sales order line', FRA = 'ligne commande vente';
}
