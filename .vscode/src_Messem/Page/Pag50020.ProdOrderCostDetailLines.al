namespace MESSEM.MESSEM;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.MachineCenter;
using Microsoft.Inventory.Ledger;
//********************Documentation****************************
//WDC01  WDC.HG 13/11/2025  
page 50020 "Prod. Order Cost Detail Lines"
{
    ApplicationArea = All;
    Captionml = ENU = 'Prod. Order Cost Detail Lines', FRA = ' Lignes détail coûts par O.F';
    PageType = List;
    Editable = false;
    SourceTable = "Prod. Order Cost Detail Line";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Prod Order No."; Rec."Prod Order No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;

                }

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("Description "; Rec."Description ")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("Unit of Measure Code "; Rec."Unit of Measure Code ")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                //<<WDC01
                field("Standard Quantity"; Rec."Standard Quantity")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                //<<WDC01
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("Actual Quantity"; Rec."Actual Quantity")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                //<<WDC01
                field("Standard Cost"; Rec."Standard Cost")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                //>>WDC01
                field("Expected Cost"; Rec."Expected Cost")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }
                field("Actual Cost "; Rec."Actual Cost ")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                }

                field("Variance Expected Cost "; Rec."Variance Expected Cost ")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTextExpectedCostVar;
                }
                field("Variance Standard Cost"; Rec."Variance Standard Cost")
                {
                    ApplicationArea = all;
                    StyleExpr = StyleTextStandardCostVar;
                }
            }
        }
    }
    trigger OnOpenPage()

    begin
        SetProdOrderCalculation(ProdOrderLine, Rec);
        CurrPage.UPDATE(FALSE);
    end;

    trigger OnAfterGetRecord()
    begin
        StyleText := SetStyleText();
        StyleTextExpectedCostVar := SetStyleTextExpectedCostVariation();
        StyleTextStandardCostVar := SetStyleTextStandardCostVariation();
    end;

    procedure SetProdOrderLine(pProdOrderLine: Record "Prod. Order Line")
    begin
        ProdOrderLine := pProdOrderLine;
    end;

    procedure SetProdOrderCalculation(pProdOrderLine: Record "Prod. Order Line"; Var ProdOrderCostDetailLine: record "Prod. Order Cost Detail Line")

    begin
        EntryNo := 1;
        //fromBom
        ProdOrderComponent.reset();
        ProdOrderComponent.setcurrentkey(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
        ProdOrderComponent.setrange(Status, pProdOrderLine.Status);
        ProdOrderComponent.setrange("Prod. Order No.", pProdOrderLine."Prod. Order No.");
        ProdOrderComponent.setrange("Prod. Order Line No.", pProdOrderLine."Line No.");
        if ProdOrderComponent.findset() then
            repeat
                ProdOrderCostDetailLine.Init();
                ProdOrderCostDetailLine."Entry No." := EntryNo;
                ProdOrderCostDetailLine.Source := ProdOrderCostDetailLine.Source::"Production BOM";
                ProdOrderCostDetailLine."No." := ProdOrderComponent."Item No.";
                ProdOrderCostDetailLine."Description " := ProdOrderComponent.Description;
                ProdOrderCostDetailLine."Unit of Measure Code " := ProdOrderComponent."Unit of Measure Code";
                //ProdOrderCostDetailLine.Deviation := TRUE;
                ProdOrderCostDetailLine.Status := pProdOrderLine.Status;
                ProdOrderCostDetailLine."Prod Order No." := pProdOrderLine."Prod. Order No.";
                ProdOrderCostDetailLine."Line No." := pProdOrderLine."Line No.";
                ProdOrderCostDetailLine."Item No." := pProdOrderLine."Item No.";
                ProdOrderCostDetailLine."Expected Quantity" := ProdOrderComponent."Quantity per" * pProdOrderLine."Finished Qty. (Base)";
                ProdOrderCostDetailLine."Standard Quantity" := ProdOrderCostDetailLine."Expected Quantity";
                ProdOrderCostDetailLine."Expected Cost" := (ProdOrderComponent."Quantity per" * pProdOrderLine."Finished Qty. (Base)") * ProdOrderComponent."Unit Cost";
                ProdOrderCostDetailLine."Standard Cost" := ProdOrderCostDetailLine."Expected Cost";//WDC01
                //calcule actual cost 
                CalculateActualQuantityAndCost(pProdOrderLine, ProdOrderCostDetailLine);
                ProdOrderCostDetailLine."Variance Expected Cost " := ProdOrderCostDetailLine."Actual Cost " - ProdOrderCostDetailLine."Expected Cost";
                ProdOrderCostDetailLine."Variance Standard Cost" := ProdOrderCostDetailLine."Actual Cost " - ProdOrderCostDetailLine."Standard Cost";//WDC01
                TempProdordercostdetailsLine.init();
                TempProdordercostdetailsLine.TransferFields(ProdOrderCostDetailLine);
                TempProdordercostdetailsLine.insert();
                ProdOrderCostDetailLine.Insert();
                EntryNo += 1;
            until ProdOrderComponent.next() = 0;
        //from Routing
        RoutingLine.reset();
        RoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
        RoutingLine.setrange(Status, pProdOrderLine.Status);
        RoutingLine.SetRange("Prod. Order No.", pProdOrderLine."Prod. Order No.");
        RoutingLine.SetRange("Routing Reference No.", pProdOrderLine."Line No.");
        if RoutingLine.FindSet() then
            repeat
                ProdOrderCostDetailLine.Init();
                ProdOrderCostDetailLine."Entry No." := EntryNo;
                ProdOrderCostDetailLine.Source := ProdOrderCostDetailLine.Source::Routing;
                ProdOrderCostDetailLine."No." := RoutingLine."Operation No.";
                ProdOrderCostDetailLine."Description " := RoutingLine.Description;
                ProdOrderCostDetailLine."Unit of Measure Code " := RoutingLine."Run Time Unit of Meas. Code";
                //ProdOrderCostDetailLine.Deviation := TRUE;
                ProdOrderCostDetailLine.Status := pProdOrderLine.Status;
                ProdOrderCostDetailLine."Prod Order No." := pProdOrderLine."Prod. Order No.";
                ProdOrderCostDetailLine."Line No." := pProdOrderLine."Line No.";
                ProdOrderCostDetailLine."Item No." := pProdOrderLine."Item No.";
                ProdOrderCostDetailLine."Expected Quantity" := RoutingLine."Run Time" * pProdOrderLine."Finished Qty. (Base)";
                //ProdOrderCostDetailLine."Standard Quantity" := ProdOrderCostDetailLine."Expected Quantity";//CMTBYWDC01
                ProdOrderCostDetailLine."Expected Cost" := (RoutingLine."Run Time" * pProdOrderLine."Finished Qty. (Base)") * RoutingLine."Unit Cost per";
                //CalculStandardCost
                CalculateSTDQuantityAndCostForRouting(pProdOrderLine, ProdOrderCostDetailLine, RoutingLine."Operation No.");//WDC01
                //calcul actual cost
                CalculateActualQuantityAndCost(pProdOrderLine, ProdOrderCostDetailLine);
                ProdOrderCostDetailLine."Variance Expected Cost " := ProdOrderCostDetailLine."Actual Cost " - ProdOrderCostDetailLine."Expected Cost";
                ProdOrderCostDetailLine."Variance Standard Cost" := ProdOrderCostDetailLine."Actual Cost " - ProdOrderCostDetailLine."Standard Cost";//WDC01

                TempProdordercostdetailsLine.init();
                TempProdordercostdetailsLine.TransferFields(ProdOrderCostDetailLine);
                TempProdordercostdetailsLine.insert();
                ProdOrderCostDetailLine.Insert();
                EntryNo += 1;
            until RoutingLine.next() = 0;
        //consommationdifference
        AddProdOrderLineConsumptionDeviation(pProdOrderLine, ProdOrderCostDetailLine);
        //capacitydifference
        //AddProdOrderLineCapacityDeviation(pProdOrderLine, ProdOrderCostDetailLine)
    end;

    local procedure SetStyleText(): text[50]

    begin
        IF rec.Deviation THEN
            EXIT('UnFavorable')
        ELSE
            EXIT('Standard');
    end;

    local procedure SetStyleTextExpectedCostVariation(): text[50]

    begin
        IF rec."Variance Expected Cost " > 0 THEN
            EXIT('UnFavorable')
        ELSE
            EXIT('favorable');
    end;

    local procedure SetStyleTextStandardCostVariation(): text[50]

    begin
        IF rec."Variance Standard Cost" > 0 THEN
            EXIT('UnFavorable')
        ELSE
            EXIT('favorable');
    end;

    local procedure CalculateActualQuantityAndCost(pProdOrderLine: Record "Prod. Order Line"; VAR pProdOrderCostDetailLine: Record "Prod. Order Cost Detail Line")
    var
        TotalQtyBase: Decimal;
        TotalCost: Decimal;
        ItemLedgerEntry: record "Item Ledger Entry";
        CapacityEntry: record "Capacity Ledger Entry";

    begin
        TotalQtyBase := 0;
        TotalCost := 0;
        case pProdOrderCostDetailLine.Source of
            pProdOrderCostDetailLine.Source::"Production Bom":
                begin
                    ItemLedgerEntry.reset();
                    ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type");
                    ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                    ItemLedgerEntry.SETRANGE("Order No.", pProdOrderLine."Prod. Order No.");
                    ItemLedgerEntry.SETRANGE("Order Line No.", pProdOrderLine."Line No.");
                    ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    ItemLedgerEntry.SETRANGE("Item No.", pProdOrderCostDetailLine."No.");
                    IF ItemLedgerEntry.FINDSET THEN
                        REPEAT
                            TotalQtyBase += ItemLedgerEntry.Quantity;
                            ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)", "Cost Amount (Expected)");
                            TotalCost += ItemLedgerEntry."Cost Amount (Actual)" + ItemLedgerEntry."Cost Amount (Expected)";
                        UNTIL ItemLedgerEntry.NEXT <= 0;
                    pProdOrderCostDetailLine."Actual Quantity" := ABS(TotalQtyBase);
                    pProdOrderCostDetailLine."Actual Cost " := ABS(TotalCost);
                end;
            pProdOrderCostDetailLine.Source::Routing:
                begin
                    CapacityEntry.Reset();
                    CapacityEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line");
                    CapacityEntry.setrange("Order Type", CapacityEntry."Order Type"::Production);
                    CapacityEntry.setrange("Order No.", pProdOrderLine."Prod. Order No.");
                    CapacityEntry.setrange("Operation No.", pProdOrderCostDetailLine."No.");
                    CapacityEntry.setrange("Order Line No.", pProdOrderLine."Line No.");
                    if CapacityEntry.FindSet() then
                        repeat
                            TotalQtyBase += CapacityEntry.Quantity;
                            CapacityEntry.CALCFIELDS("Direct Cost", "Overhead Cost");
                            TotalCost += CapacityEntry."Direct Cost" + CapacityEntry."Overhead Cost";
                        until CapacityEntry.next() = 0;
                    pProdOrderCostDetailLine."Actual Quantity" := ABS(TotalQtyBase);
                    pProdOrderCostDetailLine."Actual Cost " := ABS(TotalCost);
                end;
        end;
    end;

    local procedure AddProdOrderLineConsumptionDeviation(pProdOrderLine: Record "Prod. Order Line"; VAR pProdOrderCostDetailLine: Record "Prod. Order Cost Detail Line")
    var
        ItemLedgerEntry: record "Item Ledger Entry";
        lprodorderlinecostdetails: record "Prod. Order Cost Detail Line";
    begin

        ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type");
        ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
        ItemLedgerEntry.SETRANGE("Order Line No.", ProdOrderLine."Line No.");
        ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
        IF ItemLedgerEntry.ISEMPTY THEN
            EXIT;
        pProdOrderCostDetailLine.RESET;
        if ItemLedgerEntry.FINDSET then
            REPEAT
                TempProdordercostdetailsLine.reset();
                TempProdordercostdetailsLine.SETRANGE(Source, pProdOrderCostDetailLine.Source::"Production BOM");
                TempProdordercostdetailsLine.SETRANGE("No.", ItemLedgerEntry."Item No.");
                IF TempProdordercostdetailsLine.ISEMPTY THEN BEGIN
                    pProdOrderCostDetailLine.INIT;
                    pProdOrderCostDetailLine."Entry No." := EntryNo;
                    pProdOrderCostDetailLine.Source := pProdOrderCostDetailLine.Source::"Production BOM";
                    pProdOrderCostDetailLine."No." := ItemLedgerEntry."Item No.";
                    pProdOrderCostDetailLine."Description " := ItemLedgerEntry.Description;
                    pProdOrderCostDetailLine."Unit of Measure Code " := ItemLedgerEntry."Unit of Measure Code";
                    pProdOrderCostDetailLine."Prod Order No." := ItemLedgerEntry."Order No.";
                    pProdOrderCostDetailLine."Line No." := ItemLedgerEntry."Order Line No.";
                    pProdOrderCostDetailLine."Item No." := pProdOrderLine."Item No.";
                    pProdOrderCostDetailLine.Deviation := TRUE;
                    pProdOrderCostDetailLine.Status := pProdOrderLine.Status;
                    CalculateActualQuantityAndCost(pProdOrderLine, pProdOrderCostDetailLine);
                    pProdOrderCostDetailLine.INSERT;
                    EntryNo += 1;
                END;
            UNTIL ItemLedgerEntry.NEXT = 0;
    END;

    local procedure AddProdOrderLineCapacityDeviation(pProdOrderLine: Record "Prod. Order Line"; VAR pProdOrderCostDetailLine: Record "Prod. Order Cost Detail Line")
    var
        CapacityEntry: record "Capacity Ledger Entry";
    begin
        CapacityEntry.Reset();
        CapacityEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line");
        CapacityEntry.setrange("Order Type", CapacityEntry."Order Type"::Production);
        CapacityEntry.setrange("Order No.", pProdOrderLine."Prod. Order No.");
        CapacityEntry.setrange("Operation No.", pProdOrderCostDetailLine."No.");
        CapacityEntry.setrange("Order Line No.", pProdOrderLine."Line No.");
        if CapacityEntry.IsEmpty then
            exit;
        pProdOrderCostDetailLine.reset();
        if CapacityEntry.FindSet() then
            repeat
                TempProdordercostdetailsLine.reset();
                TempProdordercostdetailsLine.SETRANGE(Source, pProdOrderCostDetailLine.Source::"Routing");
                TempProdordercostdetailsLine.SETRANGE("No.", CapacityEntry."Operation No.");
                IF pProdOrderCostDetailLine.ISEMPTY THEN BEGIN
                    pProdOrderCostDetailLine.init();
                    pProdOrderCostDetailLine."Entry No." := EntryNo;
                    pProdOrderCostDetailLine.Source := pProdOrderCostDetailLine.Source::Routing;
                    pProdOrderCostDetailLine."No." := RoutingLine."Operation No.";
                    pProdOrderCostDetailLine."Description " := RoutingLine.Description;
                    pProdOrderCostDetailLine."Unit of Measure Code " := RoutingLine."Run Time Unit of Meas. Code";
                    pProdOrderCostDetailLine.Deviation := TRUE;
                    pProdOrderCostDetailLine.Status := pProdOrderLine.Status;
                    pProdOrderCostDetailLine."Prod Order No." := ProdOrderLine."Prod. Order No.";
                    pProdOrderCostDetailLine."Line No." := pProdOrderLine."Line No.";
                    pProdOrderCostDetailLine."Item No." := pProdOrderLine."Item No.";
                    CalculateActualQuantityAndCost(pProdOrderLine, pProdOrderCostDetailLine);
                    pProdOrderCostDetailLine.INSERT;
                    EntryNo += 1;
                end;
            until CapacityEntry.Next() = 0;

    end;
    //<<WDC01
    local procedure CalculateSTDQuantityAndCostForRouting(pProdOrderLine: Record "Prod. Order Line"; VAR pProdOrderCostDetailLine: Record "Prod. Order Cost Detail Line"; pOpérationNo: code[10])
    var
        lProdOrderHeader: record "Production Order";
        lRoutingVersionLine: record "Routing Line";
        lMachineCenter: record "Machine Center";
        lWorkCenter: record "Work Center";
        lDefaultRoutingVersion: code[20];
        lVersionMgt: Codeunit VersionManagement;
        lUnitCost: decimal;
    begin
        lUnitCost := 0;
        lProdOrderHeader.reset();
        if lProdOrderHeader.get(pProdOrderLine.Status, pProdOrderLine."Prod. Order No.") then begin
            lDefaultRoutingVersion := lVersionMgt.GetRtngVersion(lProdOrderHeader."Routing No.", WorkDate(), true);
            lRoutingVersionLine.reset();
            if lRoutingVersionLine.get(lProdOrderHeader."Routing No.", lDefaultRoutingVersion, pOpérationNo) then begin
                if lRoutingVersionLine.type = lRoutingVersionLine.type::"Work Center" then begin
                    lWorkCenter.reset();
                    if lWorkCenter.get(lRoutingVersionLine."No.") then
                        lUnitCost := lWorkCenter."Direct Unit Cost";
                end;
                if lRoutingVersionLine.type = lRoutingVersionLine.type::"Machine Center" then begin
                    lMachineCenter.reset();
                    if lMachineCenter.get(lRoutingVersionLine."No.") then
                        lUnitCost := lMachineCenter."Direct Unit Cost";
                end;
                pProdOrderCostDetailLine."Standard Quantity" := lRoutingVersionLine."Run Time" * pProdOrderLine."Finished Qty. (Base)";
                pProdOrderCostDetailLine."Standard Cost" := (lRoutingVersionLine."Run Time" * pProdOrderLine."Finished Qty. (Base)") * lUnitCost;
            end
        end
    end;
    //>>WDC01
    var
        ProdOrderLine: record "Prod. Order Line";
        EntryNo: Integer;
        ProdOrderComponent: record "Prod. Order Component";
        ItemLedgerEntry: record "Item Ledger Entry";
        RoutingLine: record "Prod. Order Routing Line";
        CapacityEntry: record "Capacity Ledger Entry";
        StyleText: text[50];
        StyleTextExpectedCostVar: text[50];
        StyleTextStandardCostVar: text[50];
        TempProdordercostdetailsLine: record "Prod. Order Cost Detail Line" temporary;


}
