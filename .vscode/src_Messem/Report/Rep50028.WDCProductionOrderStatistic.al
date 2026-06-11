report 50028 "WDC Production Order Statistic"
{
    //*****************************Documentation********************************
    // WDC01  03.04.2025 WDC.HG  : Create Production Order Statistic
    // WDC02  30.07.2025 WDC.HG  : Modify the standard cost column
    // WDC03  17/09/2025 WDC.HG  : Implement The Routing Version Process to Calculate Expected Cost 
    //WDC04   04/11/2025 WDC.HG  : Implement The Machine Cneter Cost
    //WDC05   11/11/2025 WDC.HG  : Implement Set the cost to cost per KG 
    //WDC06   19/11/2025 WDC.HG  : Add the material and opérational cost 
    //WDC07   21/04/2026 WDC.HG  : based the cost calculation on Finished quantity
    //WDC08   30/04/2026 WDC.HG  : Add routing name 
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
            DataItemTableView = SORTING("No.")
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
            //<<WDC08
            column(RoutingNo; "Production Order"."Routing No.")
            {

            }
            column(RoutingName; RoutingLbl)
            {

            }
            column(RoutingDescription; lRouting.Description)
            {

            }
            //>>WDC08
            column(NumeroOFLBL; NumeroOF)
            {
            }
            column(NumeroOrigineLBL; NumeroOrigine)
            {
            }
            column(DescriptionLBL; DescriptionLBL)
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
            column(CoutBomSTD; CoutBomSTD)
            {

            }
            column(CoutBomExpected; CoutBomExpected)
            {

            }
            column(CoutBomReel; CoutBomReel)
            {

            }
            column(OperationalSTDCost; OperationalSTDCost)
            {

            }
            column(OperationalExpectedCost; OperationalExpectedCost)
            {

            }
            column(OperationalRealCost; OperationalRealCost)
            {

            }
            column(CoutCentreReceptionSTD; CoutCentreReceptionSTD)
            {
            }
            column("CoutCentreReceptionPrévu"; "CoutCentreReceptionPrévu")
            {

            }
            column("CoutCentreReceptionRéel"; "CoutCentreReceptionRéel")
            {
            }

            column(CoutPostReceptionSTD; CoutPostReceptionSTD)
            {

            }
            column("CoutPostReceptionPrévu"; "CoutPostReceptionPrévu")
            {

            }
            column("CoutPostReceptionRéel"; "CoutPostReceptionRéel")
            { }

            column(CoutCentreEqueutageSTD; CoutCentreEqueutageSTD)
            {

            }
            column("CoutCentreEqueutagePrévu"; "CoutCentreEqueutagePrévu")
            {

            }
            column("CoutCentreEqueutageRéel"; "CoutCentreEqueutageRéel")
            {

            }
            column(CoutPostEqueutageSTD; CoutPostEqueutageSTD)
            {

            }
            column("CoutPostEqueutagePrévu"; "CoutPostEqueutagePrévu")
            {

            }
            column("CoutPostEqueutageRéel"; "CoutPostEqueutageRéel")
            {

            }
            column(CoutCentreSurgelationSTD; CoutCentreSurgelationSTD)
            {

            }
            column("CoutCentreSurgelationPrévu"; "CoutCentreSurgelationPrévu")
            {

            }
            column("CoutCentreSurgelationRéel"; "CoutCentreSurgelationRéel")
            {

            }
            column(CoutPostSurgelationSTD; CoutPostSurgelationSTD)
            {

            }
            column("CoutPostSurgelationPrévu"; "CoutPostSurgelationPrévu")
            {

            }
            column("CoutPostSurgelationRéel"; "CoutPostSurgelationRéel")
            {

            }
            column("CoutCentreExpéditionSTD"; "CoutCentreExpéditionSTD")
            {

            }
            column("CoutCentreExpéditionPrévu"; "CoutCentreExpéditionPrévu")
            {

            }
            column("CoutCentreExpéditionRéel"; "CoutCentreExpéditionRéel")
            {

            }
            column("CoutPostExpéditionSTD"; "CoutPostExpéditionSTD")
            {

            }
            column("CoutPostExpéditionPrévu"; "CoutPostExpéditionPrévu")
            {

            }
            column("CoutPostExpéditionRéel"; "CoutPostExpéditionRéel")
            {

            }
            column(CoutCentreNettoyageSTD; CoutCentreNettoyageSTD)
            {

            }
            column("CoutCentreNettoyagePrévu"; "CoutCentreNettoyagePrévu")
            {

            }
            column("CoutCentreNettoyageRéel"; "CoutCentreNettoyageRéel")
            {

            }
            column(CoutPostNettoyageSTD; CoutPostNettoyageSTD)
            {

            }
            column("CoutPostNettoyagePrévu"; "CoutPostNettoyagePrévu")
            {

            }
            column("CoutPostNettoyageRéel"; "CoutPostNettoyageRéel")
            {

            }

            column(CoutCentreReceptionSTDLBL; "CoutCentreReceptionSTD-LBL")
            {
            }
            column("CoutCentreReceptionPrévu_LBL"; "CoutCentreReceptionPrévu-LBL")
            {

            }
            column(CoutCentreReceptionRéelLBL; "CoutCentreReceptionRéel-LBL")
            {
            }
            column(CoutPostReceptionSTD_LBL; "CoutPostReceptionSTD-LBL")
            {

            }
            column("CoutPostReceptionPrévu_LBL"; "CoutPostReceptionPrévu-LBL")
            {

            }
            column("CoutPostReceptionRéel_LBL"; "CoutPostReceptionRéel-LBL")
            {

            }
            column(CoutCentreEqueutageSTDLBL; "CoutCentreEqueutageSTD-LBL")
            {
            }
            column("CoutCentreEqueutagePrévu_LBL"; "CoutCentreEqueutagePrévu-LBL")
            {

            }
            column(CoutCentreEqueutageRéelLBL; "CoutCentreEqueutageRéel-LBL")
            {
            }
            column(CoutPostEqueutageSTD_LBL; "CoutPostEqueutageSTD-LBL")
            {

            }
            column("CoutPostEqueutagePrévu_LBL"; "CoutPostEqueutagePrévu-LBL")
            {

            }
            column("CoutPostEqueutageRéel_LBL"; "CoutPostEqueutageRéel-LBL")
            {

            }
            column(CoutCentreSurgelationSTDLBL; "CoutCentreSurgelationSTD-LBL")
            {
            }
            column("CoutCentreSurgelationPrévu_LBL"; "CoutCentreSurgelationPrévu-LBL")
            {

            }
            column(CoutCentreSurgelationRéelLBL; "CoutCentreSurgelationRéel-LBL")
            {
            }
            column(CoutPostSurgelationSTD_LBL; "CoutPostSurgelationSTD-LBL")
            {

            }
            column("CoutPostSurgelationPrévu_LBL"; "CoutPostSurgelationPrévu-LBL")
            {

            }
            column("CoutPostSurgelationRéel_LBL"; "CoutPostSurgelationRéel-LBL")
            {

            }
            column(CoutCentreExpéditionSTDLBL; "CoutCentreExpéditionSTD-LBL")
            {
            }
            column("CoutCentreExpéditionPrévu_LBL"; "CoutCentreExpéditionPrévu-LBL")
            {

            }
            column(CoutCentreExpéditionRéelLBL; "CoutCentreExpéditionRéel-LBL")
            {
            }
            column("CoutPostExpéditionSTD_LBL"; "CoutPostExpéditionSTD-LBL")
            {

            }
            column("CoutPostExpéditionPrévu_LBL"; "CoutPostExpéditionPrévu-LBL")
            {

            }
            column("CoutPostExpéditionRéel_LBL"; "CoutPostExpéditionRéel-LBL")
            {

            }
            column(CoutCentreNettoyageSTDLBL; "CoutCentreNettoyageSTD-LBL")
            {
            }
            column("CoutCentreNettoyagePrévu_LBL"; "CoutCentreNettoyagePrévu-LBL")
            {

            }
            column(CoutCentreNettoyageRéelLBL; "CoutCentreNettoyageRéel-LBL")
            {
            }
            column(CoutPostNettoyageSTD_LBL; "CoutPostNettoyageSTD-LBL")
            {

            }
            column("CoutPostNettoyagePrévu_LBL"; "CoutPostNettoyagePrévu-LBL")
            {

            }
            column("CoutPostNettoyageRéel_LBL"; "CoutPostNettoyageRéel-LBL")
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
            column(CoutPrevu; CoutPrevu)
            {

            }
            column(CoutPrevuLBL; CoutPrevuLBL)
            {

            }
            column(VariationR; VariationR)
            {
            }
            column(VariationRLBL; VariationRLBL)
            {
            }
            //<<WDC05
            column(VariationRealstd; VariationRealstd)
            {

            }
            column(VariationRealstdLBL; VariationRealstdLBL)
            {

            }
            //>>WDC05
            column(Variationpourcentage; Variationpourcentage)
            {
            }
            column(VariationpourcentageLBL; VariationpourcentageLBL)
            {
            }
            //<<WDC05
            column(VariationpourcentageRealStd; VariationpourcentageRealStd)
            {

            }
            column(VariationpourcentageRealStdLBL; VariationpourcentageRealStdLBL)
            {

            }
            //>>WDC05
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
            column(CoutBomStdlbl; CoutBomStdlbl)
            {

            }
            column(CoutBomReellbl; CoutBomReellbl)
            {

            }
            column(CoutBomExpectedlbl; CoutBomExpectedlbl)
            {

            }
            column(OperationalStdCostlbl; OperationalStdCostlbl)
            {

            }
            column(OperationalRealCostllbl; OperationalRealCostllbl)
            {

            }
            column(OperationalExpectedCostlbl; OperationalExpectedCostlbl)
            {

            }

            trigger OnAfterGetRecord()
            var
                lProdOrderLine: record "Prod. Order Line";
            begin
                if lRouting.get("Production Order"."Routing No.") then; //WDC08
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
                SommeCoutPrevu := 0;
                CoutReel := 0;
                coutPrevu := 0;
                VariationR := 0;
                Variationpourcentage := 0;
                VariationRealstd := 0;
                VariationpourcentageRealStd := 0;
                consommationSTD := 0;
                CoutCentreReceptionSTD := 0;
                CoutCentreEqueutageSTD := 0;
                CoutCentreSurgelationSTD := 0;
                CoutCentreExpéditionSTD := 0;
                CoutCentreNettoyageSTD := 0;
                CoutPostReceptionSTD := 0;//WDC04
                CoutPostSurgelationSTD := 0;//WDC04
                CoutPostEqueutageSTD := 0;//WDC04
                "CoutPostExpéditionSTD" := 0;//WDC04
                CoutPostNettoyageSTD := 0;//WDC04
                "CoutCentreReceptionRéel" := 0;
                CoutCentreEqueutageRéel := 0;
                CoutCentreSurgelationRéel := 0;
                CoutCentreExpéditionRéel := 0;
                CoutCentreNettoyageRéel := 0;
                "CoutPostReceptionRéel" := 0;//WDC04
                "CoutPostEqueutageRéel" := 0;//WDC04
                "CoutPostSurgelationRéel" := 0;//WDC04
                "CoutPostExpéditionRéel" := 0;//WDC04
                "CoutPostNettoyageRéel" := 0;//WDC04
                SommeCoutMP := 0;
                SommeCoutPF := 0;
                SommeCoutpackaging := 0;
                SommeCoutSO := 0;
                SommeCoutCR := 0;
                CoutBomReel := 0;//WDC05
                CoutBomSTD := 0;//WDC05
                CoutBomExpected := 0;//WDC05
                "QuantitéConsoméPackaging" := 0;
                DefaultRoutingVersion := '';
                CoutCentreReceptionPrévu := 0;
                CoutCentreEqueutagePrévu := 0;
                CoutCentreSurgelationPrévu := 0;
                CoutCentreExpéditionPrévu := 0;
                CoutCentreNettoyagePrévu := 0;
                "CoutPostReceptionPrévu" := 0;//WDC04
                "CoutPostEqueutagePrévu" := 0;//WDC04
                "CoutPostSurgelationPrévu" := 0;//WDC04
                "CoutPostExpéditionPrévu" := 0;//WDC04
                "CoutPostNettoyagePrévu" := 0;//WDC04
                OperationalSTDCost := 0;//WDC05
                OperationalRealCost := 0;//WDC05
                operationalExpectedCost := 0;//WDC05



                //<<WDC02
                lProdOrderLine.RESET();
                lProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Item No.");
                lProdOrderLine.setrange(Status, "Production Order".Status);
                lProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                lProdOrderLine.SetRange("Item No.", "Source No.");
                IF lProdOrderLine.FINDSET() THEN;
                //<<WDC02
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
                                CoutSTDOF := lProdOrderLine."Unit Cost"; //WDC02
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
                            //>>Upadate100425
                            IF (Item."Specification Class" = Item."Specification Class"::Packaging) THEN begin
                                QuantitéConsoméPackaging += ItemLedgerEntry.Quantity;
                                SommeCoutpackaging += ItemLedgerEntry."Cost Amount (Actual)";
                            end;
                            //>>

                            IF (ItemLedgerEntry."Item No." = '6166') THEN begin
                                QuantitéconsoméSO += ItemLedgerEntry.Quantity;
                                SommeCoutSO += ItemLedgerEntry."Cost Amount (Actual)";
                            end;
                            IF (ItemLedgerEntry."Item No." = '6104') THEN begin
                                QuantitéCr += ItemLedgerEntry.Quantity;
                                SommeCoutCR += ItemLedgerEntry."Cost Amount (Actual)";
                            end;
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
                        // if SommeCoutMP < 0 then
                        //     SommeCoutMP := SommeCoutMP * (-1);
                        // if SommeCoutPF < 0 then
                        //     SommeCoutPF := SommeCoutPF * (-1);
                        // if SommeCoutpackaging < 0 then
                        //     SommeCoutpackaging := SommeCoutpackaging * (-1);
                        // if SommeCoutCR < 0 then
                        //     SommeCoutCR := SommeCoutCR * (-1);
                        // if SommeCoutSO < 0 then
                        //     SommeCoutSO := SommeCoutSO * (-1);
                        rendement := QuantitéProduitePF / consommation;
                        rendementavecCr := (QuantitéProduitePF + QuantitéCr) / consommation;
                        rendementavecCrSO := (QuantitéProduitePF + QuantitéCr + QuantitéSO) / consommation;
                    END;
                END;
                calculateSTDMaterialCost(lProdOrderLine);//WDC05
                CalculateSTDCostPerCentreAndPerPost("Production Order");//WDC04
                CalculateExpectedAndRealCostPerCentreAndPerPost("Production Order");//WDC04
                if "QuantitéProduitePF" <> 0 then
                    CoutBomReel := abs((SommeCoutMP + SommeCoutPF + SommeCoutpackaging + SommeCoutSO + SommeCoutCR)) / QuantitéProduitePF;
                OperationalSTDCost := CoutCentreReceptionSTD + CoutCentreEqueutageSTD + CoutCentreSurgelationSTD + "CoutCentreExpéditionSTD" + CoutCentreNettoyageSTD + CoutPostReceptionSTD + CoutPostEqueutageSTD + CoutPostSurgelationSTD + "CoutPostExpéditionSTD" + CoutPostNettoyageSTD;
                OperationalRealCost := CoutCentreReceptionRéel + CoutCentreEqueutageRéel + CoutCentreSurgelationRéel + CoutCentreExpéditionRéel + CoutCentreNettoyageRéel + "CoutPostReceptionRéel" + "CoutPostEqueutageRéel" + "CoutPostSurgelationRéel" + "CoutPostExpéditionRéel" + "CoutPostNettoyageRéel";
                SommeCoutReel := CoutBomReel + OperationalRealCost;//WDC04
                OperationalExpectedCost := "CoutCentreReceptionPrévu" + "CoutCentreEqueutagePrévu" + "CoutCentreSurgelationPrévu" + "CoutCentreExpéditionPrévu" + "CoutCentreNettoyagePrévu" + "CoutPostReceptionPrévu" + "CoutPostEqueutagePrévu" + "CoutPostSurgelationPrévu" + "CoutPostExpéditionPrévu" + "CoutPostNettoyagePrévu";
                SommeCoutPrevu := CoutBomExpected + OperationalExpectedCost;//WDC04
                if QuantitéProduitePF <> 0 then begin
                    CoutSTD := round(CoutSTDOF, 0.0001, '<');
                    //CoutReel := round((SommeCoutReel / QuantitéProduitePF), 0.01, '<');//CMT BY WDC05
                    //coutPrevu := round((SommeCoutPrevu / QuantitéProduitePF), 0.01, '<');//CMT BY WDC05
                    CoutReel := round(SommeCoutReel, 0.0001, '<');//WDC05
                    coutPrevu := round(SommeCoutPrevu, 0.0001, '<');//WDC05
                end;
                //VariationR := (CoutReel - CoutPrevu) * QuantitéProduitePF;//CMT BY WDC05
                VariationR := (CoutReel - CoutPrevu);//WDC05
                VariationRealstd := CoutReel - CoutSTD;
                IF CoutPrevu = 0 THEN
                    Variationpourcentage := 0
                ELSE
                    Variationpourcentage := ((CoutReel - CoutPrevu) / CoutPrevu);
                //<<WDC05
                IF CoutSTD = 0 THEN
                    VariationpourcentageRealStd := 0
                ELSE
                    VariationpourcentageRealStd := ((CoutReel - CoutSTD) / CoutSTD);
                //>>WDC05
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


    //<<WDC03
    procedure CalculateSTDCostPerCentreAndPerPost(pProductionOrder: record "Production Order")
    var
        lRoutingHeader: record "Routing Header";
        lVersionMgt: Codeunit VersionManagement;
        lRoutingVersionLine: record "Routing Line";
        lworkCenter: record "Work Center";
        lProdOrderLine: Record "Prod. Order Line";

    begin
        lProdOrderLine.RESET();
        lProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Line No.");
        lProdOrderLine.SETRANGE("Status", pProductionOrder.Status);
        lProdOrderLine.SETRANGE("Prod. Order No.", pProductionOrder."No.");
        IF lProdOrderLine.FINDSET() THEN begin
            if lRoutingHeader.Get(pProductionOrder."Routing No.") then begin
                DefaultRoutingVersion := lVersionMgt.GetRtngVersion(lRoutingHeader."No.", WorkDate(), true);
                lRoutingVersionLine.reset();
                lRoutingVersionLine.setrange("Routing No.", lRoutingHeader."No.");
                lRoutingVersionLine.setrange("Version Code", DefaultRoutingVersion);
                if lRoutingVersionLine.findset() then
                    repeat
                        lworkCenter.reset();
                        if lworkcenter.get(lRoutingVersionLine."No.") then;
                        if (lRoutingVersionLine."Operation No." = '10') and (lRoutingVersionLine."Previous Operation No." = '') then begin
                            //CoutCentreReceptionSTD := Round(((lProdOrderLine.Quantity * lRoutingVersionLine."Run Time") * lworkCenter."Unit Cost"), 0.01, '<');//CMT BY WDC05
                            CoutCentreReceptionSTD := Round((lRoutingVersionLine."Run Time" * lworkCenter."Unit Cost"), 0.0001, '<');//WDC05
                            //CoutPostReceptionSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine.Quantity);//CMT BY WDC07
                            CoutPostReceptionSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine."Finished Quantity")//WDC07
                        end
                        else if (lRoutingVersionLine."Operation No." = '20') then begin
                            //CoutCentreEqueutageSTD := Round(((lProdOrderLine.Quantity * lRoutingVersionLine."Run Time") * lworkCenter."Unit Cost"), 0.01, '<');//CMT BY WDC05
                            CoutCentreEqueutageSTD := Round((lRoutingVersionLine."Run Time" * lworkCenter."Unit Cost"), 0.0001, '<');//WDC05
                                                                                                                                     //coutPostEqueutageSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine.Quantity);//CMT By WDC07 
                            CoutPostEqueutageSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine."Finished Quantity"); //WDC07
                        end
                        else if (lRoutingVersionLine."Operation No." = '30') then begin
                            //CoutCentreSurgelationSTD := Round(((lProdOrderLine.Quantity * lRoutingVersionLine."Run Time") * lworkCenter."Unit Cost"), 0.01, '<');//CMT BY WDC05
                            CoutCentreSurgelationSTD := Round((lRoutingVersionLine."Run Time" * lworkCenter."Unit Cost"), 0.0001, '<');//WDC05
                            CoutPostSurgelationSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                        end
                        else if (lRoutingVersionLine."Operation No." = '40') then begin
                            //"CoutCentreExpéditionSTD" := Round(((lProdOrderLine.Quantity * lRoutingVersionLine."Run Time") * lworkCenter."Unit Cost"), 0.01, '<');//CMT BY WDC05
                            "CoutCentreExpéditionSTD" := Round((lRoutingVersionLine."Run Time" * lworkCenter."Unit Cost"), 0.0001, '<');//WDC05
                            "CoutPostExpéditionSTD" := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                        end
                        else if (lRoutingVersionLine."Operation No." = '50') then begin
                            //CoutCentreNettoyageSTD := Round(((lProdOrderLine.Quantity * lRoutingVersionLine."Run Time") * lworkCenter."Unit Cost"), 0.01, '<');//CMT BY WDC05
                            CoutCentreNettoyageSTD := Round((lRoutingVersionLine."Run Time" * lworkCenter."Unit Cost"), 0.0001, '<');
                            CoutPostNettoyageSTD := GetSTDCostPerPost(lRoutingVersionLine."Routing No.", lRoutingVersionLine."Version Code", lRoutingVersionLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                        end;
                    until lRoutingVersionLine.next() = 0;
            end;
        end;
    end;
    //>>WDC03
    procedure CalculateExpectedAndRealCostPerCentreAndPerPost(pProductionOrder: record "Production Order")
    var
        lProdOrderLine: Record "Prod. Order Line";
        lRoutingLine: record "Prod. Order Routing Line";

    begin
        lProdOrderLine.RESET();
        lProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Line No.");
        lProdOrderLine.SETRANGE("Status", pProductionOrder.Status);
        lProdOrderLine.SETRANGE("Prod. Order No.", pProductionOrder."No.");
        IF lProdOrderLine.FINDSET() THEN begin
            lRoutingLine.reset();
            lRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
            lRoutingLine.setrange(Status, lProdOrderLine.Status);
            lRoutingLine.SetRange("Prod. Order No.", lProdOrderLine."Prod. Order No.");
            if lRoutingLine.FindSet() then
                repeat
                    if (lRoutingLine."Operation No." = '10') and (lRoutingLine."Previous Operation No." = '') then begin
                        //CoutCentreReceptionPrévu := Round(((lProdOrderLine.Quantity * lRoutingLine."Run Time") * lRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                        CoutCentreReceptionPrévu := Round((lRoutingLine."Run Time" * lRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
                        CoutPostReceptionPrévu := GetExpectedCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Routing No.", lRoutingLine."Routing Reference No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutCentreReceptionRéel" := GetRealCostPerCentre(lRoutingLine."Prod. Order No.", lRoutingLine."Operation No.", lRoutingLine."Unit Cost per", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutPostReceptionRéel" := GetRealCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                    end
                    else if (lRoutingLine."Operation No." = '20') then begin
                        //CoutCentreEqueutagePrévu := Round(((lProdOrderLine.Quantity * lRoutingLine."Run Time") * lRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                        CoutCentreEqueutagePrévu := Round((lRoutingLine."Run Time" * lRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
                        CoutPostEqueutagePrévu := GetExpectedCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Routing No.", lRoutingLine."Routing Reference No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutCentreEqueutageRéel" := GetRealCostPerCentre(lRoutingLine."Prod. Order No.", lRoutingLine."Operation No.", lRoutingLine."Unit Cost per", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutPostEqueutageRéel" := GetRealCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                    end
                    else if (lRoutingLine."Operation No." = '30') then begin
                        //CoutCentreSurgelationPrévu := Round(((lProdOrderLine.Quantity * lRoutingLine."Run Time") * lRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                        CoutCentreSurgelationPrévu := Round((lRoutingLine."Run Time" * lRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
                        CoutPostSurgelationPrévu := GetExpectedCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Routing No.", lRoutingLine."Routing Reference No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC04 WDC07
                        "CoutCentreSurgelationRéel" := GetRealCostPerCentre(lRoutingLine."Prod. Order No.", lRoutingLine."Operation No.", lRoutingLine."Unit Cost per", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutPostSurgelationRéel" := GetRealCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                    end
                    else if (lRoutingLine."Operation No." = '40') then begin
                        //"CoutCentreExpéditionPrévu" := Round(((lProdOrderLine.Quantity * lRoutingLine."Run Time") * lRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                        "CoutCentreExpéditionPrévu" := Round((lRoutingLine."Run Time" * lRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
                        CoutPostExpéditionPrévu := GetExpectedCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Routing No.", lRoutingLine."Routing Reference No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC04 //WDC07
                        "CoutCentreExpéditionRéel" := GetRealCostPerCentre(lRoutingLine."Prod. Order No.", lRoutingLine."Operation No.", lRoutingLine."Unit Cost per", lProdOrderLine."Finished Quantity"); //WDC07
                        "CoutPostExpéditionRéel" := GetRealCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC07
                    end
                    else if (lRoutingLine."Operation No." = '50') then begin
                        //CoutCentreNettoyagePrévu := Round(((lProdOrderLine.Quantity * lRoutingLine."Run Time") * lRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                        CoutCentreNettoyagePrévu := Round((lRoutingLine."Run Time" * lRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
                        CoutPostNettoyagePrévu := GetExpectedCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Routing No.", lRoutingLine."Routing Reference No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity");//WDC04 //WDC07 
                        "CoutCentreNettoyageRéel" := GetRealCostPerCentre(lRoutingLine."Prod. Order No.", lRoutingLine."Operation No.", lRoutingLine."Unit Cost per", lProdOrderLine."Finished Quantity");//WDC07
                        "CoutPostNettoyageRéel" := GetRealCostPerPost(lRoutingLine."Prod. Order No.", lRoutingLine."Next Operation No.", lProdOrderLine."Finished Quantity"); //WDC07

                    end;
                until lRoutingLine.Next() = 0;
        end;
    end;

    procedure GetRealCostPerCentre(pProdOrderNo: code[20]; pOpérationNo: code[10]; pUnitCost: Decimal; pQuantity: Decimal) RealCost: Decimal
    var
        CapacityEntry: record "Capacity Ledger Entry";
        lMachineCenter: record "Machine Center";
    begin
        if pQuantity = 0 then
            exit(0);
        CapacityEntry.Reset();
        CapacityEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line");
        CapacityEntry.setrange("Order Type", CapacityEntry."Order Type"::Production);
        CapacityEntry.setrange("Order No.", pProdOrderNo);
        CapacityEntry.setrange("Operation No.", "pOpérationNo");
        if CapacityEntry.FindSet() then
            repeat
                RealCost += ((CapacityEntry.Quantity / pQuantity) * pUnitCost);
                RealCost := Round(RealCost, 0.0001, '<')
            until CapacityEntry.Next() = 0;
    end;
    //<<WDC04
    procedure GetSTDCostPerPost(pRountingNo: code[20]; pVersioncode: code[20]; pOpérationNo: code[10]; pQuantity: Decimal) STDCostPerPost: Decimal
    var
        lPostMoRoutingVersionLine: record "Routing Line";
        lMachineCenter: record "Machine Center";
    begin
        lPostMoRoutingVersionLine.reset();
        if lPostMoRoutingVersionLine.get(pRountingNo, pVersioncode, pOpérationNo) then
            if lPostMoRoutingVersionLine.type = lPostMoRoutingVersionLine.type::"Machine Center" then begin
                lMachineCenter.reset();
                if lMachineCenter.get(lPostMoRoutingVersionLine."No.") then
                    //STDCostPerPost := Round(((pQuantity * lPostMoRoutingVersionLine."Run Time") * lMachineCenter."Direct Unit Cost"), 0.01, '<');//CMT BY WDC05
                    STDCostPerPost := Round((lPostMoRoutingVersionLine."Run Time" * lMachineCenter."Direct Unit Cost"), 0.0001, '<');//WDC05
            end
    end;
    //>>WDC04
    //<<WDC04
    procedure GetExpectedCostPerPost(pProductionOrderNo: code[20]; pRountingNo: code[20]; pRoutingReferenceNo: Integer; pOpérationNo: code[10]; pQuantity: Decimal) ExpectedCostPerPost: Decimal
    var
        lPostMoRoutingLine: record "Prod. Order Routing Line";
    begin
        lPostMoRoutingLine.reset();
        lPostMoRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
        lPostMoRoutingLine.SetRange("Prod. Order No.", pProductionOrderNo);
        lPostMoRoutingLine.SetRange("Routing Reference No.", pRoutingReferenceNo);
        lPostMoRoutingLine.SetRange("Routing No.", pRountingNo);
        lPostMoRoutingLine.SetRange("Operation No.", pOpérationNo);
        if lPostMoRoutingLine.FindSet() then
            if lPostMoRoutingLine.type = lPostMoRoutingLine.type::"Machine Center" then
                //ExpectedCostPerPost := Round(((pQuantity * lPostMoRoutingLine."Run Time") * lPostMoRoutingLine."Unit Cost per"), 0.01, '<');//CMT BY WDC05
                ExpectedCostPerPost := Round((lPostMoRoutingLine."Run Time" * lPostMoRoutingLine."Unit Cost per"), 0.0001, '<');//WDC05
    end;
    //>>WDC04
    //<<WDC04
    procedure GetRealCostPerPost(pProdOrderNo: code[20]; pOpérationNo: code[10]; pQuantity: Decimal) RealCostPerPost: Decimal
    var
        lCapacityEntry: record "Capacity Ledger Entry";
        lMachineCenter: record "Machine Center";
    begin
        if pQuantity = 0 then
            exit(0);
        lCapacityEntry.Reset();
        lCapacityEntry.SetCurrentKey("Order Type", "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line");
        lCapacityEntry.setrange("Order Type", lCapacityEntry."Order Type"::Production);
        lCapacityEntry.setrange("Order No.", pProdOrderNo);
        lCapacityEntry.setrange("Operation No.", "pOpérationNo");
        lCapacityEntry.setrange(Type, lCapacityEntry.type::"Machine Center");
        if lCapacityEntry.FindSet() then
            repeat
                lMachineCenter.reset();
                if lMachineCenter.get(lCapacityEntry."No.") then begin
                    RealCostPerPost += (lCapacityEntry.Quantity / pQuantity) * lMachineCenter."Direct Unit Cost";
                    RealCostPerPost := Round(RealCostPerPost, 0.0001, '<')
                end
            until lcapacityEntry.Next() = 0;
    end;
    //>>WDC04
    //<<WDC05
    procedure calculateSTDMaterialCost(pProdOrderLine: Record "Prod. Order Line")
    lProdOrderComponent: record "Prod. Order Component";
    begin
        lProdOrderComponent.reset();
        lProdOrderComponent.setcurrentkey(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
        lProdOrderComponent.setrange(Status, pProdOrderLine.Status);
        lProdOrderComponent.setrange("Prod. Order No.", pProdOrderLine."Prod. Order No.");
        lProdOrderComponent.setrange("Prod. Order Line No.", pProdOrderLine."Line No.");
        if lProdOrderComponent.findset() then
            repeat
                CoutBomExpected += lProdOrderComponent."Quantity per" * lProdOrderComponent."Unit Cost";
            until lProdOrderComponent.next() = 0;
        CoutBomExpected := round(CoutBomExpected, 0.0001, '<');
        CoutBomSTD := CoutBomExpected;
    end;
    //>>WDC05

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        LotNo: Code[10];
        Date: TextConst FRA = 'Date', ENU = 'Date';
        NumeroOF: TextConst ENU = 'Production Order  No.', FRA = 'N° OF';
        NumeroOrigine: TextConst ENU = 'Origin No.', FRA = 'N° Origine';
        DescriptionLBL: TextConst ENU = 'Description', FRA = 'Description';
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
        "CoutBomStdlbl": TextConst ENU = 'Material STD Cost', FRA = 'Coût Matière STD';//WDC05
        "CoutBomExpectedlbl": TextConst ENU = 'Material Expected Cost', FRA = 'Coût matière prévu';//WDC05
        "CoutBomReellbl": TextConst ENU = 'Material Real Cost', FRA = 'Coût matière Réel';//WDC05

        "OperationalStdCostlbl": TextConst ENU = 'Operational STD Cost', FRA = 'Coût opérationnel STD';//WDC05
        "OperationalExpectedCostlbl": TextConst ENU = 'Operational Expected Cost', FRA = 'Coût opérationnel prévu';//WDC05
        "OperationalRealCostllbl": TextConst ENU = 'Operational Real Cost', FRA = 'Coût opérationnel Réel';//WDC05
        rendementSTD: Decimal;
        "QuantitéPFc": Decimal;
        "QuantitéSFc": Decimal;
        SommeCoutMP: decimal;
        SommeCoutPF: decimal;
        "QuantitéMainOeuvre": Decimal;
        MOparKG: Decimal;
        "rendementSTD-lbl": TextConst ENU = 'STD Efficiency', FRA = 'Rendement STD';
        "MOparKG-lbl": TextConst FRA = 'MO/KG', ENU = 'MO/KG';
        CoutSTD: Decimal;
        CoutSTDOF: Decimal;
        CoutSTDLBL: TextConst ENU = 'STD Cost / KG', FRA = 'Coût STD / KG';
        SommeCoutReel: Decimal;
        SommeCoutPrevu: decimal;
        CoutReel: Decimal;
        CoutPrevu: decimal;
        CoutReelLBL: TextConst ENU = 'Real Cost / KG', FRA = 'Coût Réel /  KG';
        CoutPrevuLBL: TextConst ENU = 'Expected Cost / KG', FRA = 'Coût prévu /  KG';
        VariationRLBL: TextConst FRA = 'Variation Réel/Prévu', ENU = 'Variation Real/Expected';
        VariationR: Decimal;
        Variationpourcentage: Decimal;
        VariationpourcentageLBL: TextConst FRA = 'VAR R/P %', ENU = 'VAR R/P %';
        VariationRealstdLBL: TextConst FRA = 'Variation Réel/STD', ENU = 'Variation Real/STD';
        VariationRealstd: Decimal;
        VariationpourcentageRealStd: Decimal;
        VariationpourcentageRealStdLBL: TextConst FRA = 'VAR R/S %', ENU = 'VAR R/S %';
        CompanyInfo: Record "Company Information";
        NOfFiliterLBL: TextConst ENU = 'Production Order No. :', FRA = 'N° OF :';
        NArticleFilterLBL: TextConst ENU = 'Item No. :', FRA = 'N° article :';
        DateFilterLBL: TextConst FRA = 'Date :', ENU = 'Date :';
        "CoutCentreReceptionSTD-LBL": TextConst FRA = 'Centre Réception Coût STD / KG', ENU = 'Reception Center STD Cost / KG';
        "CoutCentreReceptionPrévu-LBL": TextConst FRA = 'Centre Réception Coût Prévu / KG ', ENU = 'Reception Center Expected Cost / KG';
        "CoutCentreReceptionRéel-LBL": TextConst FRA = 'Centre Réception Coût Réel / KG', ENU = 'Reception Center Actual Cost / KG';
        "CoutPostReceptionSTD-LBL": TextConst FRA = 'Post MO Réception CoûtSTD / KG', ENU = 'Reception Post STDCost / KG';
        "CoutPostReceptionPrévu-LBL": TextConst FRA = 'Post MO Réception Coût Prévu / KG', ENU = 'Reception Post Expected Cost / KG';
        "CoutPostReceptionRéel-LBL": TextConst FRA = 'Post MO Réception Coût Réel / KG', ENU = 'Reception Post Actual Cost / KG';
        "CoutCentreEqueutageSTD-LBL": TextConst FRA = 'Centre Equeutage Coût STD / KG', ENU = 'Tailing Center STD Cost / KG';
        "CoutCentreEqueutagePrévu-LBL": TextConst FRA = 'Centre Equeutage Coût Prévu / KG', ENU = 'Tailing Center Expected Cost / KG';
        "CoutCentreEqueutageRéel-LBL": TextConst FRA = 'Centre Equeutage Coût Réel / KG', ENU = 'Tailing Center Actual Cost / KG';
        "CoutPostEqueutageSTD-LBL": TextConst FRA = 'Post MO Equeutage CoûtSTD / KG', ENU = 'Tailing Post STDCost / KG';
        "CoutPostEqueutagePrévu-LBL": TextConst FRA = 'Post MO Equeutage Coût Prévu / KG', ENU = 'Tailing Post Expected Cost / KG';
        "CoutPostEqueutageRéel-LBL": TextConst FRA = 'Post MO Equeutage Coût Réel / KG', ENU = 'Tailing Post Actual Cost / KG';
        "CoutCentreSurgelationSTD-LBL": TextConst FRA = 'Centre Surgelation Coût STD / KG', ENU = 'Freezing Center STD Cost / KG';
        "CoutCentreSurgelationPrévu-LBL": TextConst FRA = 'Centre Surgelation Coût Prévu / KG', ENU = 'Freezing Center Expected Cost / KG';
        "CoutCentreSurgelationRéel-LBL": TextConst FRA = 'Centre Surgelation Coût Réel / KG', ENU = 'Freezing Center Actual Cost / KG';
        "CoutPostSurgelationSTD-LBL": TextConst FRA = 'Post MO Surgelation Coût STD / KG ', ENU = 'Freezing Post STD Cost / KG';
        "CoutPostSurgelationPrévu-LBL": TextConst FRA = 'Post MO Surgelation Coût Prévu / KG', ENU = 'Freezing Post Expected Cost / KG';
        "CoutPostSurgelationRéel-LBL": TextConst FRA = 'Post MO Surgelation Coût Réel / KG', ENU = 'Freezing Post Actual Cost / KG';
        "CoutCentreExpéditionSTD-LBL": TextConst FRA = 'Centre Expédition Coût STD / KG', ENU = 'Shipping Center STD Cost / KG';
        "CoutCentreExpéditionPrévu-LBL": TextConst FRA = 'Centre Expédition Coût Prévu / KG', ENU = 'Shipping Center Expected Cost / KG';
        "CoutCentreExpéditionRéel-LBL": TextConst FRA = 'Centre Expédition  Coût Réel / KG', ENU = 'Shipping Center Actual Cost / KG';
        "CoutPostExpéditionSTD-LBL": TextConst FRA = 'Post MO Expédition Coût STD / KG', ENU = 'Shipping Post STD Cost / KG';
        "CoutPostExpéditionPrévu-LBL": TextConst FRA = 'Post MO Expédition Coût Prévu / KG', ENU = 'Shipping Post Expected Cost / KG';
        "CoutPostExpéditionRéel-LBL": TextConst FRA = 'Post MO Expédition  Coût Réel / KG', ENU = 'Shipping Post Actual Cost / KG';
        "CoutCentreNettoyageSTD-LBL": TextConst FRA = 'Centre Nettoyage Coût STD', ENU = 'Cleaning Center STDC ost';
        "CoutCentreNettoyagePrévu-LBL": TextConst FRA = 'Centre Nettoyage Coût Prévu / KG', ENU = 'Cleaning Center Expected Cost / KG';
        "CoutCentreNettoyageRéel-LBL": TextConst FRA = 'Centre Nettoyage Coût Réel / KG', ENU = 'Cleaning Center Actual Cost / KG';
        "CoutPostNettoyageSTD-LBL": TextConst FRA = 'Post MO Nettoyage CoûtSTD / KG', ENU = 'Cleaning Post STDCost / KG';
        "CoutPostNettoyagePrévu-LBL": TextConst FRA = 'Post MO Nettoyage Coût Prévu / KG', ENU = 'Cleaning Post Expected Cost / KG';
        "CoutPostNettoyageRéel-LBL": TextConst FRA = 'Post MO Nettoyage Coût Réel / KG', ENU = 'Cleaning Post Actual Cost / KG';
        NoOfFilter: Text[50];
        NArticleFilter: Text[50];
        DateFilter: Text[50];
        consommationSTD: Decimal;
        Text01: TextConst ENU = 'Please specify a filter date .', FRA = 'Veuillez spécifier une date de filtrage .';
        titre: TextConst ENU = 'Production Order Statistic', FRA = 'Statistique par O.F ';
        RoutingLbl: TextConst ENU = 'Routing', FRA = 'Gamme';

        "QuantitéconsoméSO": Decimal;
        "QuantitéSO": Decimal;
        CoutCentreReceptionSTD: Decimal;
        CoutCentreEqueutageSTD: Decimal;
        CoutCentreSurgelationSTD: Decimal;
        CoutCentreExpéditionSTD: Decimal;
        CoutCentreNettoyageSTD: Decimal;
        CoutPostReceptionSTD: Decimal;//WDC04
        CoutPostEqueutageSTD: Decimal;//WDC04
        CoutPostSurgelationSTD: Decimal;//WDC04
        CoutPostExpéditionSTD: Decimal;//WDC04
        CoutPostNettoyageSTD: Decimal;//WDC04
        CoutCentreReceptionPrévu: Decimal;
        CoutCentreEqueutagePrévu: Decimal;
        CoutCentreSurgelationPrévu: Decimal;
        CoutCentreExpéditionPrévu: Decimal;
        CoutCentreNettoyagePrévu: Decimal;
        CoutCentreReceptionRéel: Decimal;
        CoutCentreEqueutageRéel: Decimal;
        CoutCentreSurgelationRéel: Decimal;
        CoutCentreExpéditionRéel: Decimal;
        CoutCentreNettoyageRéel: Decimal;
        QuantitéConsoméPackaging: decimal;
        CoutPostReceptionRéel: Decimal;//WDC04
        CoutPostEqueutageRéel: Decimal;//WDC04
        CoutPostSurgelationRéel: Decimal;//WDC04
        CoutPostExpéditionRéel: Decimal;//WDC04
        CoutPostNettoyageRéel: Decimal;//WDC04
        CoutPostReceptionPrévu: Decimal;//WDC04
        CoutPostEqueutagePrévu: Decimal;//WDC04
        CoutPostSurgelationPrévu: Decimal;//WDC04
        CoutPostExpéditionPrévu: Decimal;//WDC04
        CoutPostNettoyagePrévu: Decimal;//WDC04

        SommeCoutpackaging: decimal;
        SommeCoutSO: Decimal;
        SommeCoutCR: Decimal;
        CoutBomReel: decimal;
        DefaultRoutingVersion: code[20];
        CoutBomSTD: decimal;//WDC05
        CoutBomExpected: decimal;//WDC05
        OperationalSTDCost: Decimal;//WDC05
        OperationalRealCost: Decimal;//WDC05
        OperationalExpectedCost: decimal; //wdc05
        lRouting: record "Routing Header"; //WDC08





}

