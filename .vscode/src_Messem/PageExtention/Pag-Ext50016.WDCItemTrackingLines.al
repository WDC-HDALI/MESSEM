namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Journal;

pageextension 50016 "WDC Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {

        addafter("Quantity (Base)")
        {

            field(PFD; Rec.PFD)
            {
                ApplicationArea = all;

            }
            field(Variety; Rec.Variety)
            {
                ApplicationArea = all;
            }
            field(Brix; Rec.Brix)
            {
                ApplicationArea = all;
            }
            field("Package Number"; Rec."Package Number")
            {
                ApplicationArea = all;
            }
            field(Place; Rec.Place)
            {
                ApplicationArea = all;
            }
        }
        modify("Serial No.")
        {
            Visible = false;
        }
        modify(AvailabilitySerialNo)
        {
            Visible = false;
        }
        modify("TrackingAvailable(Rec,2)")
        {
            Visible = false;
        }
        modify("Package No.")
        {
            Visible = false;
        }
    }
    actions
    {

        addlast(Creation)
        {
            action("KeepLotNo.")
            {
                CaptionML = ENU = 'Keep Lot No.', FRA = 'Poursuivre n° lot';
                Visible = FunctionsSupplyVisible;
                ApplicationArea = ItemTracking;
                Image = Lot;
                trigger OnAction()
                var
                    PurchaseLine2: Record 39;
                    TextSI003: TextConst ENU = 'Consignment Management in use',
                                         FRA = 'Gestion des expéditions en cours d''utilisation';
                begin

                    IF InsertIsBlocked THEN
                        exit;
                    KeepLotNo;

                end;

            }
        }
    }



    procedure SetProdTrackingSource("Source Type": Integer; "Source Subtype": Option "0","1","2","3","4","5","6","7","8","9","10"; "Source ID": Code[20]; "Source Ref. No.": Integer; "Prod. Order Comp. Line No.": Integer)

    begin
        SetSourceType := "Source Type";
        SetSourceSubtype := "Source Subtype";
        SetSourceID := "Source ID";
        SetSourceRefNo := "Source Ref. No.";
        SetProdOrderCompLineNo := "Prod. Order Comp. Line No.";
    end;

    procedure GetSource(VAR pTrackingSpecification: Record "Tracking Specification" temporary)
    begin
        IF Rec.FINDSET THEN
            REPEAT
                pTrackingSpecification.TRANSFERFIELDS(Rec);
                pTrackingSpecification.INSERT;
            UNTIL Rec.NEXT = 0;
    end;


    local procedure KeepLotNo()
    var
        ResEntry: Record 337;
        ResEntry2: Record 337;
        QtyToCreate: Decimal;
        QtyToCreate2: Decimal;
    begin
        ResEntry.RESET;
        ResEntry.SETRANGE("Item No.", Rec."Item No.");
        ResEntry.SETRANGE("Source ID", Rec."Source ID");
        ResEntry.SETRANGE("Source Type", Rec."Source Type");
        ResEntry.SETRANGE("Source Subtype", ResEntry."Source Subtype"::"1");
        ResEntry.SETRANGE("Source Ref. No.", Rec."Source Ref. No." - 10000);
        IF NOT ResEntry.FINDSET THEN BEGIN
            ResEntry.RESET;
            ResEntry.SETRANGE("Item No.", Rec."Item No.");
            ResEntry.SETRANGE("Source ID", Rec."Source ID");
            ResEntry.SETRANGE("Source Type", Rec."Source Type");
            ResEntry.SETRANGE("Source Subtype", ResEntry."Source Subtype"::"1");
            ResEntry.SETRANGE("Source Ref. No.", Rec."Source Ref. No." - 5000);
            IF NOT ResEntry.FINDSET THEN
                EXIT;
        END;

        IF ZeroLineExists THEN
            Rec.DELETE;

        IF (SourceQuantityArray[1] * UndefinedQtyArray[1] <= 0) OR
           (ABS(SourceQuantityArray[1]) < ABS(UndefinedQtyArray[1]))
        THEN
            QtyToCreate := 0
        ELSE
            QtyToCreate := UndefinedQtyArray[1];

        GetItem(Rec."Item No.");

        Item.TESTFIELD("Lot Nos.");
        Rec.InitExpirationDate();
        Rec.VALIDATE("Quantity Handled (Base)", 0);
        Rec.VALIDATE("Quantity Invoiced (Base)", 0);
        Rec.VALIDATE("Lot No.", ResEntry."Lot No.");
        Rec."Qty. per Unit of Measure" := QtyPerUOM;
        IF NOT ItemTrackingCode."Man. Warranty Date Entry Reqd." AND (FORMAT(ItemTrackingCode."Warranty Date Formula") <> '') THEN
            Rec."Warranty Date" := CALCDATE(ItemTrackingCode."Warranty Date Formula", WORKDATE());
        Rec.VALIDATE("Quantity (Base)", QtyToCreate);
        Rec."Entry No." := NextEntryNo;
        Rec.VALIDATE("Lot No.", ResEntry."Lot No.");
        Rec.PFD := ResEntry.PFD;
        Rec.Variety := ResEntry.Variety;
        Rec.Brix := ResEntry.Brix;
        Rec."Package Number" := ResEntry."Package Number";
        Rec.Place := ResEntry.Place;
        Rec.INSERT;
        TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        TempItemTrackLineInsert.INSERT;
    end;

    //*****Production
    var
        SetSourceType: Integer;
        SetSourceSubtype: Option "0","1","2","3","4","5","6","7","8","9","10";
        SetSourceID: Code[20];
        SetSourceRefNo: Integer;
        SetProdOrderCompLineNo: Integer;
}
