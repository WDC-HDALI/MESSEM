report 50028 "WDC Production Order Statistic"
{
    //*****************************Documentation********************************
    // WDC01  03.04.2025 WDC.HG  : Create Production Order Statistic
    //*****************************************************************************
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/ProductionOrderStatistic.rdlc';

    CaptionML = ENU = 'Production Order Statistic', FRA = 'Statistique par O.F ';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING("Due Date")
                                WHERE(Status = FILTER(Finished | Released),
                                      "Source Type" = FILTER(Item));
            RequestFilterFields = "No.", "Source No.", "Due Date";
            column(ProductionOrderNo; "Production Order"."No.")
            {
            }
            column(DueDate; "Production Order"."Due Date")
            {
            }
            column(ItemNo; "Production Order"."Source No.")
            {
            }
            column(Description; "Production Order".Description)
            {
            }
            column(NumeroOFLBL; NumeroOF)
            {
            }
            column(NumeroOrigineLBL; NumeroOrigine)
            {
            }
            column(DescriptionLBL; Description)
            {
            }
            column(NumeroLotLBL; NumeroLot)
            {
            }
            column(LotNo; LotNo)
            {
            }
            column(DateLBL; Date)
            {
            }
            column("QuantitéProduitePF"; QuantitéProduitePF)
            {
            }
            column("QuantitéConsoméMP"; QuantitéConsoméMP)
            {
            }
            column(consommation; consommation)
            {
            }
            column("QuantitéProduitePFLBL"; "QuantitéProduitePF-LBL")
            {
            }
            column("QuantitéConsoméMPLBL"; "QuantitéConsoméMP-LBL")
            {
            }
            column(consommationLBL; "consommation-LBL")
            {
            }
            column(rendement; rendement)
            {
            }
            column(rendementavecCr; rendementavecCr)
            {
            }
            column(rendementavecCrSO; rendementavecCrSO)
            {
            }
            column(rendementLBL; "rendementlbl")
            {
            }
            column(rendementavecCrLBL; "rendement avec Cr-lbl")
            {
            }
            column(rendementSortOutLBL; "rendement Sort Out-lbl")
            {
            }
            column(CoutCentreReceptionSTD; CoutCentreReceptionSTD)
            {
            }
            column("CoutCentreReceptionRéel"; "CoutCentreReceptionRéel")
            {
            }
            column(CoutCentreEqueutageSTD; CoutCentreEqueutageSTD)
            {

            }
            column("CoutCentreEqueutageRéel"; "CoutCentreEqueutageRéel")
            {

            }
            column(CoutCentreSurgelationSTD; CoutCentreSurgelationSTD)
            {

            }
            column("CoutCentreSurgelationRéel"; "CoutCentreSurgelationRéel")
            {

            }
            column("CoutCentreExpéditionSTD"; "CoutCentreExpéditionSTD")
            {

            }
            column("CoutCentreExpéditionRéel"; "CoutCentreExpéditionRéel")
            {

            }
            column(CoutCentreNettoyageSTD; CoutCentreNettoyageSTD)
            {

            }
            column("CoutCentreNettoyageRéel"; "CoutCentreNettoyageRéel")
            {

            }

            column(CoutCentreReceptionSTDLBL; "CoutCentreReceptionSTD-LBL")
            {
            }
            column(CoutCentreReceptionRéelLBL; "CoutCentreReceptionRéel-LBL")
            {
            }
            column(CoutCentreEqueutageSTDLBL; "CoutCentreEqueutageSTD-LBL")
            {
            }
            column(CoutCentreEqueutageRéelLBL; "CoutCentreEqueutageRéel-LBL")
            {
            }
            column(CoutCentreSurgelationSTDLBL; "CoutCentreSurgelationSTD-LBL")
            {
            }
            column(CoutCentreSurgelationRéelLBL; "CoutCentreSurgelationRéel-LBL")
            {
            }
            column(CoutCentreExpéditionSTDLBL; "CoutCentreExpéditionSTD-LBL")
            {
            }
            column(CoutCentreExpéditionRéelLBL; "CoutCentreExpéditionRéel-LBL")
            {
            }
            column(CoutCentreNettoyageSTDLBL; "CoutCentreNettoyageSTD-LBL")
            {
            }
            column(CoutCentreNettoyageRéelLBL; "CoutCentreNettoyageRéel-LBL")
            {
            }

            column(CoutSTD; CoutSTD)
            {
            }
            column(CoutSTDLBL; CoutSTDLBL)
            {
            }
            column(CoutReel; CoutReel)
            {
            }
            column(CoutReelLBL; CoutReelLBL)
            {
            }
            column(VariationR; VariationR)
            {
            }
            column(VariationRLBL; VariationRLBL)
            {
            }
            column(Variationpourcentage; Variationpourcentage)
            {
            }
            column(VariationpourcentageLBL; VariationpourcentageLBL)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(NoOfFilter; NoOfFilter)
            {
            }
            column(NArticleFilter; NArticleFilter)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(NOfFiliterLBL; NOfFiliterLBL)
            {
            }
            column(NArticleFilterLBL; NArticleFilterLBL)
            {
            }
            column(DateFilterLBL; DateFilterLBL)
            {
            }
            column(Status; "Production Order".Status)
            {
            }
            column(titre; titre)
            {
            }


            trigger OnAfterGetRecord()
            begin
                IF (DateFilter = '') THEN
                    ERROR(Text01);
                IF ("Production Order".Status <> "Production Order".Status::Finished) AND ("Production Order".Status <> "Production Order".Status::Released) THEN
                    CurrReport.SKIP();
                LotNo := '';
                QuantitéProduitePF := 0;
                QuantitéProduiteSF := 0;
                QuantitéConsoméMP := 0;
                consommation := 0;
                QuantitéCr := 0;
                QuantitéSO := 0;
                QuantitéProduiteSO := 0;
                QuantitéconsoméSO := 0;
                rendementSF := 0;
                rendement := 0;
                rendementavecCr := 0;
                rendementavecCrSO := 0;
                QuantitéPFc := 0;
                QuantitéSFc := 0;
                rendementSTD := 0;
                MOparKG := 0;
                QuantitéMainOeuvre := 0;
                CoutSTDOF := 0;
                CoutSTD := 0;
                SommeCoutReel := 0;
                CoutReel := 0;
                VariationR := 0;
                Variationpourcentage := 0;
                consommationSTD := 0;
                CoutCentreReceptionSTD := 0;
                CoutCentreEqueutageSTD := 0;
                CoutCentreSurgelationSTD := 0;
                CoutCentreExpéditionSTD := 0;
                CoutCentreNettoyageSTD := 0;
                CoutCentreEqueutageRéel := 0;
                CoutCentreSurgelationRéel := 0;
                CoutCentreExpéditionRéel := 0;
                CoutCentreNettoyageRéel := 0;
                SommeCoutMP := 0;
                SommeCoutPF := 0;
                ItemLedgerEntry.RESET();
                ItemLedgerEntry.SETCURRENTKEY("Item No.");
                ItemLedgerEntry.SETRANGE("Item No.", "Source No.");
                ItemLedgerEntry.SETRANGE("Document No.", "No.");
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Entry Type", ItemLedgerEntry."Entry Type"::Output);
                IF ItemLedgerEntry.FINDSET() THEN
                    LotNo := ItemLedgerEntry."Lot No.";
                ItemLedgerEntry.RESET();
                ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
                ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
                ItemLedgerEntry.SETRANGE("Order No.", "No.");
                IF ItemLedgerEntry.FINDSET() THEN BEGIN
                    REPEAT
                        ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                        IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Output) THEN BEGIN
                            IF (ItemLedgerEntry."Item No." <> '6104') AND (ItemLedgerEntry."Item No." <> '6166') THEN BEGIN
                                Item.GET(ItemLedgerEntry."Item No.");
                                IF (Item."Specification Class" = Item."Specification Class"::"End Product") THEN
                                    QuantitéProduitePF += ItemLedgerEntry.Quantity;
                                CoutSTDOF := Item."Standard Cost";
                            END;
                            IF (ItemLedgerEntry."Item No." = '6166') THEN
                                QuantitéProduiteSO += ItemLedgerEntry.Quantity;
                        END;
                        IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Consumption) THEN BEGIN
                            Item.GET(ItemLedgerEntry."Item No.");
                            IF (Item."Specification Class" = Item."Specification Class"::Raw) THEN begin
                                QuantitéConsoméMP += ItemLedgerEntry.Quantity;
                                SommeCoutMP += ItemLedgerEntry."Cost Amount (Actual)";
                            end;

                            IF (ItemLedgerEntry."Item No." = '6166') THEN
                                QuantitéconsoméSO += ItemLedgerEntry.Quantity;
                            IF (ItemLedgerEntry."Item No." = '6104') THEN
                                QuantitéCr += ItemLedgerEntry.Quantity;
                            IF (Item."Specification Class" = Item."Specification Class"::"End Product") AND (NOT (ItemLedgerEntry."Item No." IN ['6167', '6104', '6165', '6166'])) THEN begin
                                QuantitéPFc += ItemLedgerEntry.Quantity;
                                SommeCoutPF += ItemLedgerEntry."Cost Amount (Actual)";
                            end;
                        END;
                    UNTIL ItemLedgerEntry.NEXT = 0;
                    QuantitéPFc := QuantitéPFc;
                    QuantitéSO := QuantitéProduiteSO + QuantitéconsoméSO;
                    consommation := QuantitéConsoméMP + QuantitéPFc;
                    IF (consommation <> 0) THEN BEGIN
                        IF (consommation < 0) THEN
                            consommation := consommation * (-1);
                        IF (QuantitéCr < 0) THEN
                            QuantitéCr := QuantitéCr * (-1);
                        IF (QuantitéSO < 0) THEN
                            QuantitéSO := QuantitéSO * (-1);
                        if SommeCoutMP < 0 then
                            SommeCoutMP := SommeCoutMP * (-1);
                        if SommeCoutPF < 0 then
                            SommeCoutPF := SommeCoutPF * (-1);
                        rendement := QuantitéProduitePF / consommation;
                        rendementavecCr := (QuantitéProduitePF + QuantitéCr) / consommation;
                        rendementavecCrSO := (QuantitéProduitePF + QuantitéCr + QuantitéSO) / consommation;
                    END;
                END;
                ProdOrderLine.RESET();
                ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                IF ProdOrderLine.FINDSET() THEN begin
                    RoutingLine.reset();
                    RoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
                    RoutingLine.setrange(Status, ProdOrderLine.Status);
                    RoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                    if RoutingLine.FindSet() then
                        repeat
                            if (RoutingLine."Operation No." = '10') and (RoutingLine."Previous Operation No." = '') then begin
                                CoutCentreReceptionSTD := Round(((ProdOrderLine.Quantity * RoutingLine."Run Time") * RoutingLine."Unit Cost per"), 0.01, '<');
                                "CoutCentreReceptionRéel" := GetRealCostPerCentre(RoutingLine."Prod. Order No.", RoutingLine."Operation No.")
                            end
                            else if (RoutingLine."Operation No." = '20') then begin
                                CoutCentreEqueutageSTD := Round(((ProdOrderLine.Quantity * RoutingLine."Run Time") * RoutingLine."Unit Cost per"), 0.01, '<');
                                "CoutCentreEqueutageRéel" := GetRealCostPerCentre(RoutingLine."Prod. Order No.", RoutingLine."Operation No.");
                            end
                            else if (RoutingLine."Operation No." = '30') then begin
                                CoutCentreSurgelationSTD := Round(((ProdOrderLine.Quantity * RoutingLine."Run Time") * RoutingLine."Unit Cost per"), 0.01, '<');
                                "CoutCentreSurgelationRéel" := GetRealCostPerCentre(RoutingLine."Prod. Order No.", RoutingLine."Operation No.");
                            end
                            else if (RoutingLine."Operation No." = '40') then begin
                                "CoutCentreExpéditionSTD" := Round(((ProdOrderLine.Quantity * RoutingLine."Run Time") * RoutingLine."Unit Cost per"), 0.01, '<');
                                "CoutCentreExpéditionRéel" := GetRealCostPerCentre(RoutingLine."Prod. Order No.", RoutingLine."Operation No.");
                            end
                            else if (RoutingLine."Operation No." = '50') and (RoutingLine."Next Operation No." = '') then begin
                                CoutCentreNettoyageSTD := Round(((ProdOrderLine.Quantity * RoutingLine."Run Time") * RoutingLine."Unit Cost per"), 0.01, '<');
                                "CoutCentreNettoyageRéel" := GetRealCostPerCentre(RoutingLine."Prod. Order No.", RoutingLine."Operation No.");
                            end;
                        until RoutingLine.Next() = 0;


                    SommeCoutReel := SommeCoutMP + SommeCoutPF + CoutCentreReceptionRéel + CoutCentreEqueutageRéel + CoutCentreSurgelationRéel + CoutCentreExpéditionRéel + CoutCentreNettoyageRéel;
                    if QuantitéProduitePF <> 0 then begin
                        CoutSTD := CoutSTDOF;
                        CoutReel := SommeCoutReel / QuantitéProduitePF;
                    end;
                    VariationR := (CoutReel - CoutSTD) * QuantitéProduitePF;
                    IF CoutSTD = 0 THEN
                        Variationpourcentage := 0
                    ELSE
                        Variationpourcentage := ((CoutReel - CoutSTD) / CoutSTD);
                END;
                IF (consommation < 0) THEN
                    consommation := consommation * (-1);
                IF (QuantitéConsoméMP < 0) THEN
                    QuantitéConsoméMP := QuantitéConsoméMP * (-1);
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
        NoOfFilter := "Production Order".GETFILTER("Production Order"."No.");
        NArticleFilter := "Production Order".GETFILTER("Production Order"."Source No.");
        DateFilter := "Production Order".GETFILTER("Production Order"."Due Date");
    end;

    procedure GetRealCostPerCentre(pProdOrderNo: code[20]; pOpérationNo: code[10]) RealCost: Decimal
    var

    begin
        CapacityEntry.Reset();
        CapacityEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line");
        CapacityEntry.setrange("Order Type", CapacityEntry."Order Type"::Production);
        CapacityEntry.setrange("Order No.", pProdOrderNo);
        CapacityEntry.setrange("Operation No.", "pOpérationNo");
        if CapacityEntry.FindSet() then
            repeat
                RealCost += CapacityEntry.Quantity * RoutingLine."Unit Cost per";
                RealCost := Round(RealCost, 0.01, '<')
            until CapacityEntry.Next() = 0;
    end;

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNo: Code[10];
        Date: TextConst FRA = 'Date', ENU = 'Date';
        NumeroOF: TextConst ENU = 'Production Order  No.', FRA = 'N° OF';
        NumeroOrigine: TextConst ENU = 'Origin No.', FRA = 'N° Origine';
        Description: TextConst ENU = 'Description', FRA = 'Description';
        NumeroLot: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        Item: Record Item;
        "QuantitéProduitePF": Decimal;
        "QuantitéProduiteSF": Decimal;
        "QuantitéConsoméMP": Decimal;
        consommation: Decimal;
        "QuantitéProduitePF-LBL": TextConst ENU = 'Production', FRA = 'Production';
        "QuantitéProduiteSF-LBL": TextConst ENU = 'Production SF', FRA = 'Production SF';
        "QuantitéConsoméMP-LBL": TextConst ENU = 'Raw Material Consumption', FRA = 'Consommation MP';
        "consommation-LBL": TextConst ENU = 'Consumption', FRA = 'Consommation';
        rendementSF: Decimal;
        rendement: Decimal;
        rendementPFavecSF: Decimal;
        "QuantitéCr": Decimal;
        rendementavecCr: Decimal;
        "QuantitéProduiteSO": Decimal;
        rendementavecCrSO: Decimal;
        "rendementlbl": TextConst ENU = 'efficiency', FRA = 'Rendement';
        "rendement avec SF-lbl": TextConst ENU = 'efficiency with SF', FRA = 'Rendemnt avec SF';
        "rendement avec Cr-lbl": TextConst ENU = 'Efficiency With Cr', FRA = 'Rendement avec Cr';
        "rendement Sort Out-lbl": TextConst ENU = ' Efficiency with Sort Out', FRA = 'Rendement avec Sort Out';
        rendementSTD: Decimal;
        "QuantitéPFc": Decimal;
        "QuantitéSFc": Decimal;
        SommeCoutMP: decimal;
        SommeCoutPF: decimal;
        "QuantitéMainOeuvre": Decimal;
        MOparKG: Decimal;
        "rendementSTD-lbl": TextConst ENU = 'STD Efficiency', FRA = 'Rendement STD';
        "MOparKG-lbl": TextConst FRA = 'MO/KG', ENU = 'MO/KG';
        ProdOrderLine: Record "Prod. Order Line";
        CoutSTD: Decimal;
        CoutSTDOF: Decimal;
        CoutSTDLBL: TextConst ENU = 'STD Cost / KG', FRA = 'Coût STD / KG';
        SommeCoutReel: Decimal;
        CoutReel: Decimal;
        CoutReelLBL: TextConst ENU = 'Real Cost / KG', FRA = 'Coût Réel /  KG';
        VariationRLBL: TextConst FRA = 'Variation R', ENU = 'Variation R';
        VariationR: Decimal;
        Variationpourcentage: Decimal;
        VariationpourcentageLBL: TextConst FRA = 'VAR %', ENU = 'VAR %';
        CompanyInfo: Record "Company Information";
        NOfFiliterLBL: TextConst ENU = 'Production Order No. :', FRA = 'N° OF :';
        NArticleFilterLBL: TextConst ENU = 'Item No. :', FRA = 'N° article :';
        DateFilterLBL: TextConst FRA = 'Date :', ENU = 'Date :';
        "CoutCentreReceptionSTD-LBL": TextConst FRA = 'Centre Réception CoûtSTD ', ENU = 'Reception Center STDCost';
        "CoutCentreReceptionRéel-LBL": TextConst FRA = 'Centre Réception Coût Réel', ENU = 'Reception Center Actual Cost';
        "CoutCentreEqueutageSTD-LBL": TextConst FRA = 'Centre Equeutage CoûtSTD ', ENU = 'Tailing Center STDCost';
        "CoutCentreEqueutageRéel-LBL": TextConst FRA = 'Centre Equeutage Coût Réel', ENU = 'Tailing Center Actual Cost';
        "CoutCentreSurgelationSTD-LBL": TextConst FRA = 'Centre Surgelation CoûtSTD ', ENU = 'Freezing Center STDCost';
        "CoutCentreSurgelationRéel-LBL": TextConst FRA = 'Centre Surgelation Coût Réel', ENU = 'Freezing Center Actual Cost';
        "CoutCentreExpéditionSTD-LBL": TextConst FRA = 'Centre Expédition CoûtSTD', ENU = 'Shipping Center STDCost';
        "CoutCentreExpéditionRéel-LBL": TextConst FRA = 'Centre Expédition  Coût Réel', ENU = 'Shipping Center Actual Cost';
        "CoutCentreNettoyageSTD-LBL": TextConst FRA = 'Centre Nettoyage CoûtSTD', ENU = 'Cleaning Center STDCost';
        "CoutCentreNettoyageRéel-LBL": TextConst FRA = 'Centre Nettoyage Coût Réel', ENU = 'Cleaning Center Actual Cost';
        NoOfFilter: Text[50];
        NArticleFilter: Text[50];
        DateFilter: Text[50];
        consommationSTD: Decimal;
        Text01: TextConst ENU = 'Please specify a filter date .', FRA = 'Veuillez spécifier une date de filtrage .';
        titre: TextConst ENU = 'Production Order Statistic', FRA = 'Statistique par O.F ';
        "QuantitéconsoméSO": Decimal;
        "QuantitéSO": Decimal;
        CoutCentreReceptionSTD: Decimal;
        CoutCentreEqueutageSTD: Decimal;
        CoutCentreSurgelationSTD: Decimal;
        CoutCentreExpéditionSTD: Decimal;
        CoutCentreNettoyageSTD: Decimal;
        CoutCentreReceptionRéel: Decimal;
        CoutCentreEqueutageRéel: Decimal;
        CoutCentreSurgelationRéel: Decimal;
        CoutCentreExpéditionRéel: Decimal;
        CoutCentreNettoyageRéel: Decimal;
        RoutingLine: record "Prod. Order Routing Line";
        CapacityEntry: record "Capacity Ledger Entry";


}

