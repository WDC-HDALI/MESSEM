page 50014 "WDC Prod. Order Follow Up"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Manufacturing Follow Up', FRA = 'Suivi des OF';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Prod. Order Line";
    SourceTableView = SORTING(Status, "Item No.", "Variant Code", "Location Code", "Due Date");
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';
                field(StatusFilter; StatusFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Status Filter', FRA = 'Filtre statut';
                    OptionCaptionML = ENU = 'Simulated,Planned,Firm Planned,Released,Finished,All',
                                      FRA = 'Simulé,Planifié,Planifié ferme,Lancé,Clôturé,Tous';

                    trigger OnValidate()
                    begin
                        StatusFilterOnAfterValidate;
                    end;
                }
                field(LocationFilter; LocationFilter)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
                    TableRelation = Location.Code;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        LocationFilterOnAfterValidate;
                    end;
                }
                field(DueDateFilter; DueDateFilter)
                {
                    CaptionML = ENU = 'Due Date Filter', FRA = 'Filtre date échéance';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        DueDateFilterOnAfterValidate;
                    end;
                }
            }
            repeater(Control)
            {
                Editable = false;
                field(Status; Rec.Status)
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Sous Traitance"; Rec."Sous Traitance")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Line No."; Rec."Line No.")
                {
                    StyleExpr = StyleTxt;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Item No."; Rec."Item No.")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field(TextLotNo; TextLotNo)
                {
                    CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field(GetFollowUp; GetFollowUp1)
                {
                    CaptionML = ENU = 'Follow Up', FRA = 'Avancement';
                    ExtendedDatatype = Ratio;
                    Style = Favorable;
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Due Date"; Rec."Due Date")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field(TxtExpCost; CalcExpectedCost)
                {
                    CaptionML = ENU = 'Expected Cost', FRA = 'Coût prévu';
                    StyleExpr = StyleTxt;
                    Visible = TxtExpCostVisible;
                    ApplicationArea = all;
                }
                field(TxtActCost; CalcActualCost)
                {
                    CaptionML = ENU = 'Actual Cost', FRA = 'Coût réel';
                    StyleExpr = StyleTxt;
                    Visible = TxtActCostVisible;
                    ApplicationArea = all;
                }
                field(TxtCostVariance; CalcVarianceCost)
                {
                    CaptionML = ENU = 'Cost Variance', FRA = 'Ecart de coût';
                    StyleExpr = StyleTxt;
                    Visible = TxtCostVarianceVisible;
                    ApplicationArea = all;
                }
                field(TxtCostVariancePct; CalcVariancePctCost)
                {
                    CaptionML = ENU = 'Cost Var. %', FRA = '% écart de coût';
                    StyleExpr = StyleTxt;
                    Visible = TxtCostVariancePctVisible;
                    ApplicationArea = all;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    StyleExpr = StyleTxt;
                    ApplicationArea = all;
                }
                field(TxtSourceCode; SourceCode)
                {
                    CaptionML = ENU = 'From ID', FRA = 'N° origine';
                    StyleExpr = StyleTxt;
                    Visible = TxtSourceCodeVisible;
                    ApplicationArea = all;
                }
                field(TxtSourceName; SourceName)
                {
                    CaptionML = ENU = 'From Name', FRA = 'Nom origine';
                    StyleExpr = StyleTxt;
                    Visible = TxtSourceNameVisible;
                    ApplicationArea = all;
                }
                field(TxtSourceDueDate; SourceDueDate)
                {
                    CaptionML = ENU = 'From Due Date', FRA = 'Date d''échéance origine';
                    StyleExpr = StyleTxt;
                    Visible = TxtSourceDueDateVisible;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line', FRA = '&Ligne';
                action("Prod. Order")
                {
                    CaptionML = ENU = 'Prod. Order', FRA = 'O.F.';
                    Image = Production;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        GetProdOrder;
                        CASE Rec.Status OF
                            Rec.Status::Simulated:
                                PAGE.RUNMODAL(PAGE::"Simulated Production Order", CurrProdOrder);
                            Rec.Status::Planned:
                                PAGE.RUNMODAL(PAGE::"Planned Production Order", CurrProdOrder);
                            Rec.Status::"Firm Planned":
                                PAGE.RUNMODAL(PAGE::"Firm Planned Prod. Order", CurrProdOrder);
                            Rec.Status::Released:
                                PAGE.RUNMODAL(PAGE::"Released Production Order", CurrProdOrder);
                            Rec.Status::Finished:
                                PAGE.RUNMODAL(PAGE::"Finished Production Order", CurrProdOrder);
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                group("E&ntries")
                {
                    CaptionML = ENU = 'E&ntries', FRA = '&Ecritures';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'E&critures article';
                        Image = ItemLedger;
                        ApplicationArea = ALl;
                        trigger OnAction()
                        var
                            ItemLedgEntry: Record "Item Ledger Entry";
                        begin
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Order Type", "Order No.");
                            ItemLedgEntry.SETRANGE("Order No.", Rec."Prod. Order No.");
                            PAGE.RUNMODAL(0, ItemLedgEntry);
                        end;
                    }
                    action("Capacity Ledger Entries")
                    {
                        CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Ecritures capacité';
                        Image = CapacityLedger;
                        ApplicationArea = all;
                        trigger OnAction()
                        var
                            CapLedgEntry: Record "Capacity Ledger Entry";
                        begin
                            CapLedgEntry.RESET;
                            CapLedgEntry.SETCURRENTKEY("Order Type", "Order No.");
                            CapLedgEntry.SETRANGE("Order No.", Rec."Prod. Order No.");
                            PAGE.RUNMODAL(0, CapLedgEntry);
                        end;
                    }
                    action("Value Entries")
                    {
                        CaptionML = ENU = 'Value Entries', FRA = 'Ecritures &valeur';
                        Image = ValueLedger;
                        ApplicationArea = all;
                        trigger OnAction()
                        var
                            ValueEntry: Record "Value Entry";
                        begin
                            ValueEntry.RESET;
                            ValueEntry.SETCURRENTKEY("Order Type", "Order No.");
                            ValueEntry.SETRANGE("Order No.", Rec."Prod. Order No.");
                            PAGE.RUNMODAL(0, ValueEntry);
                        end;
                    }
                    action("Warehouse Entries")
                    {
                        CaptionML = ENU = 'Warehouse Entries', FRA = 'Ecritures magasin';
                        RunObject = Page "Warehouse Entries";
                        Image = CheckLedger;
                        ApplicationArea = All;
                    }
                }
                action("Co&mment")
                {
                    CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                group("Item Availability by")
                {
                    CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        CaptionML = ENU = 'Event', FRA = 'Événement';
                        Image = "Event";
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            ItemAvailability(Enum::"Item Availability Type"::"Event".AsInteger());
                        end;
                    }
                    action(Period)
                    {
                        CaptionML = ENU = 'Period', FRA = 'Période';
                        Image = Period;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            ItemAvailability(Enum::"Item Availability Type"::Period.AsInteger());
                        end;
                    }
                    action(Variant)
                    {
                        CaptionML = ENU = 'Variant', FRA = 'Variante';
                        Image = ItemVariant;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            ItemAvailability(Enum::"Item Availability Type"::Variant.AsInteger());
                        end;
                    }
                    action(Location)
                    {
                        CaptionML = ENU = 'Location', FRA = 'Magasin';
                        Image = Warehouse;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            ItemAvailability(Enum::"Item Availability Type"::Location.AsInteger());
                        end;
                    }
                    action("BOM Level")
                    {
                        CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
                        Image = BOMLevel;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            ItemAvailability(Enum::"Item Availability Type"::BOM.AsInteger());
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
                    Image = ReservationLedger;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        Rec.ShowReservationEntries(TRUE);
                    end;
                }
                action("Ro&uting")
                {
                    CaptionML = ENU = 'Ro&uting', FRA = '&Gamme';
                    Image = RoutingVersions;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowRouting2;
                    end;
                }
                action(Components)
                {
                    CaptionML = ENU = 'Components', FRA = 'Composants';
                    Image = Components;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowComponents;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        OpenItemTrackingLines2;
                    end;
                }
                action("&Production Journal")
                {
                    CaptionML = ENU = '&Production Journal', FRA = '&Feuille production';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ShowProductionJournal;
                    end;
                }
                action(Consumption)
                {
                    CaptionML = ENU = 'Consumption', FRA = 'Feuille de consommation';
                    Image = Worksheet;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        lItemJournalLine: Record "Item Journal Line";
                        lConJournalPage: Page "Consumption Journal";
                    begin
                        CLEAR(lConJournalPage);
                        lConJournalPage.SetInformation(Rec."Prod. Order No.", Rec."Line No.");
                        lConJournalPage.RUNMODAL;
                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires', NLD = 'Op&merkingen';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("Prod. Order No.");
                }
            }
        }
        area(processing)
        {
            group("&Print")
            {
                CaptionML = ENU = '&Print', FRA = '&Imprimer';
                action("Job Card")
                {
                    CaptionML = ENU = 'Job Card', FRA = 'Fiche suiveuse';
                    Ellipsis = true;
                    Image = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        lProdOrder: Record "Production Order";
                    begin
                        ManuPrintReport.PrintProductionOrder(CurrProdOrder, 0);
                    end;
                }
                action("Mat. &Requisition")
                {
                    CaptionML = ENU = 'Mat. &Requisition', FRA = 'Besoin matière';
                    Ellipsis = true;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        lProdOrder: Record "Production Order";
                    begin
                        ManuPrintReport.PrintProductionOrder(CurrProdOrder, 1);
                    end;
                }
                action("Shortage List")
                {
                    CaptionML = ENU = 'Shortage List', FRA = 'Liste des ruptures';
                    Ellipsis = true;
                    Image = "Report";
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        lProdOrder: Record "Production Order";
                    begin
                        ManuPrintReport.PrintProductionOrder(CurrProdOrder, 2);
                    end;
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
                action("Re&fresh")
                {
                    CaptionML = ENU = 'Re&fresh', FRA = '&Actualiser';
                    Ellipsis = true;
                    Image = Refresh;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                        Location: Record Location;
                        RefreshProductionOrder: Report "Refresh Production Order";
                        Direction: Option Forward,Backward;
                    begin
                        SelectFilterProdOrder(ProdOrder);

                        IF Location.GET(Rec."Location Code") THEN begin
                            RefreshProductionOrder.InitializeRequest(Direction::Backward, TRUE, TRUE, TRUE, Location."Require Put-away");
                            RefreshProductionOrder.InitializeRequest1(True);
                        end;
                        RefreshProductionOrder.USEREQUESTPAGE(TRUE);
                        RefreshProductionOrder.SETTABLEVIEW(ProdOrder);
                        RefreshProductionOrder.RUNMODAL;
                    end;
                }
                action("Re&plan")
                {
                    CaptionML = ENU = 'Re&fresh', FRA = '&Actualiser';
                    Ellipsis = true;
                    Image = Replan;
                    Visible = false;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."Prod. Order No.");
                        REPORT.RUNMODAL(REPORT::"Replan Production Order", TRUE, TRUE, ProdOrder);
                    end;
                }
                action("Update Starting Date")
                {
                    CaptionML = ENU = 'Update Starting Date', FRA = 'Modifier date début';
                    Ellipsis = true;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ChangeDate;
                    end;
                }
                action("Change &Status")
                {
                    CaptionML = ENU = 'Change &Status', FRA = 'Changer &statut';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        ChangeStatus;
                    end;
                }
                action("&Update Unit Cost")
                {
                    CaptionML = ENU = '&Update Unit Cost', FRA = 'Mise à jour coût &unitaire';
                    Ellipsis = true;
                    Image = UpdateUnitCost;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SETRANGE(Status, Rec.Status);
                        ProdOrder.SETRANGE("No.", Rec."Prod. Order No.");

                        REPORT.RUNMODAL(REPORT::"Update Unit Cost", TRUE, TRUE, ProdOrder);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetItemInfo;
        GetProdOrder;
        GetOrderTracking;
        StyleTxt := GetColors;
        GetIsLate;
        GetLotNo;
    end;

    trigger OnInit()
    begin
        TxtCostVariancePctVisible := TRUE;
        TxtCostVarianceVisible := TRUE;
        TxtActCostVisible := TRUE;
        TxtExpCostVisible := TRUE;
        TxtSourceDueDateVisible := TRUE;
        TxtSourceNameVisible := TRUE;
        TxtSourceCodeVisible := TRUE;
    end;

    trigger OnOpenPage()
    begin
        GLSetup.GET;
        StatusFilter := StatusFilter::All;
        BomTypeFilter := BomTypeFilter::All;
        GetFormFilters;
        SetFormFilters;
        Setvisible;
    end;

    procedure GetFormFilters()
    begin
        IF rec.GETFILTER(Status) <> '' THEN BEGIN
            rec.SETRANGE(Status, rec.GETRANGEMIN(Status));
            StatusFilter := Rec.GETRANGEMIN(Status);
        END;

        IF rec.GETFILTER("Location Code") <> '' THEN BEGIN
            rec.SETRANGE("Location Code", rec.GETRANGEMIN("Location Code"));
            LocationFilter := rec.GETFILTER("Location Code");
        END;

        IF rec.GETFILTER("Due Date") <> '' THEN BEGIN
            rec.SETFILTER("Due Date", rec.GETFILTER("Due Date"));
            DueDateFilter := rec.GETFILTER("Due Date");
        END;

        IF rec.GETFILTER("Prod. Order No.") <> '' THEN BEGIN
            rec.SETFILTER("Prod. Order No.", ' ');
        END;
    end;

    procedure SetFormFilters()
    begin
        IF StatusFilter = StatusFilter::All THEN
            rec.SETRANGE(Status)
        ELSE
            rec.SETRANGE(Status, StatusFilter);

        IF LocationFilter <> '' THEN
            rec.SETFILTER("Location Code", LocationFilter)
        ELSE
            rec.SETRANGE("Location Code");

        IF DueDateFilter <> '' THEN
            rec.SETFILTER("Due Date", DueDateFilter)
        ELSE
            rec.SETRANGE("Due Date");

        DueDateFilter := rec.GETFILTER("Due Date");

        CurrPage.UPDATE(FALSE)
    end;

    procedure GetColors(): Text[30]
    begin
        CASE TRUE OF
            rec."Remaining Quantity" = rec.Quantity:
                EXIT('None');        //BLACK : pas commencé
            (rec."Finished Quantity" < rec.Quantity) AND
          (rec."Finished Quantity" > 0):
                EXIT('Favorable');  //en cours
            rec."Finished Quantity" = rec.Quantity:
                EXIT('Strong');    // fini
            (rec."Finished Quantity" > rec.Quantity):
                EXIT('unfavorable');      //dépassement de prod
        END
    end;

    procedure GetIsLate(): Boolean
    begin
        IsLate := rec."Due Date" < WORKDATE
    end;

    procedure GetFollowUp1(): Integer
    var
        lPourCent: Decimal;
    begin
        IF rec.Quantity = 0 THEN
            lPourCent := 1
        ELSE
            lPourCent := ROUND((rec."Finished Quantity" / rec.Quantity * 9999), 1);

        EXIT(lPourCent)
    end;

    procedure ShowComponents()
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SETRANGE(Status, rec.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", rec."Prod. Order No.");
        ProdOrderComp.SETRANGE("Prod. Order Line No.", rec."Line No.");

        PAGE.RUN(PAGE::"Prod. Order Components", ProdOrderComp);
    end;

    procedure ShowRouting2()
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRtngLine.SETRANGE(Status, rec.Status);
        ProdOrderRtngLine.SETRANGE("Prod. Order No.", rec."Prod. Order No.");
        ProdOrderRtngLine.SETRANGE("Routing Reference No.", rec."Routing Reference No.");
        ProdOrderRtngLine.SETRANGE("Routing No.", rec."Routing No.");

        PAGE.RUN(PAGE::"Prod. Order Routing", ProdOrderRtngLine);
    end;

    procedure ShowReservation2()
    begin
        CurrPage.SAVERECORD;
        ShowReservation2;
    end;

    procedure ItemAvailability(AvailabilityType: Option)
    var
        ProdOrderAvailabilityMgt: Codeunit Microsoft.Manufacturing.Document."Prod. Order Availability Mgt.";
    begin
        ProdOrderAvailabilityMgt.ShowItemAvailFromProdOrderLine(Rec, Enum::"Item Availability Type".FromInteger(AvailabilityType));
    end;

    procedure OpenItemTrackingLines2()
    begin
        Rec.OpenItemTrackingLines;
    end;

    procedure ShowProductionJournal()
    var
        ProductionJrnlMgt: Codeunit "Production Journal Mgt";
        ProdOrder: Record "Production Order";
    begin
        CurrPage.SAVERECORD;

        ProdOrder.GET(Rec.Status, Rec."Prod. Order No.");

        CLEAR(ProductionJrnlMgt);
        ProductionJrnlMgt.Handling(ProdOrder, Rec."Line No.");
    end;

    procedure ChangeDate()
    var
        lProdOrder: Record "Production Order";
        lProdOrderLine: Record "Prod. Order Line";
        lChangeStartDateForm: Page "WDC Change St.Date Prod OrdLin";
        lNewDate: Date;
        lOldDate: Date;
    begin
        CurrPage.SETSELECTIONFILTER(lProdOrderLine);

        IF lProdOrderLine.FINDFIRST THEN BEGIN
            REPEAT
                IF lProdOrder.GET(lProdOrderLine.Status, lProdOrderLine."Prod. Order No.") THEN
                    lProdOrder.MARK(TRUE);
            UNTIL lProdOrderLine.NEXT = 0;
        END;

        lProdOrder.MARKEDONLY(TRUE);

        IF lProdOrder.FINDFIRST THEN BEGIN
            lOldDate := lProdOrder."Starting Date";
            lChangeStartDateForm.Set(lProdOrderLine);
            IF lChangeStartDateForm.RUNMODAL() = ACTION::Yes THEN BEGIN
                lChangeStartDateForm.ReturnPostingInfo(lNewDate);
                REPEAT
                    lProdOrder.VALIDATE("Starting Date", lNewDate);
                    lProdOrder.MODIFY(TRUE);
                UNTIL lProdOrder.NEXT = 0;
            END;
        END;
        CurrPage.UPDATE(FALSE);
    end;

    procedure ChangeStatus()
    var
        lProdOrder: Record "Production Order";
        lProdOrderLine: Record "Prod. Order Line";
        ChangeStatusForm: Page "Change Status on Prod. Order";
        ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
        Window: Dialog;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released,Finished;
        NewPostingDate: Date;
        NewUpdateUnitCost: Boolean;
        lNoOfRecords: Integer;
        lPOCount: Integer;
        SuppressMessages: Boolean;
        SuppressChangeStatusMessage: Codeunit "WDC Suppress Change Status Msg";
        LocalText000: Label 'Simulated,Planned,Firm Planned,Released,Finished';
        NewHideDialog: Boolean;
    begin
        lPOCount := 0;
        CurrPage.SETSELECTIONFILTER(lProdOrderLine);

        IF lProdOrderLine.FINDFIRST THEN BEGIN
            REPEAT
                IF lProdOrderLine.Status.AsInteger() < 4 then //(lProdOrderLine.Status::Finished) THEN
                    IF lProdOrder.GET(lProdOrderLine.Status, lProdOrderLine."Prod. Order No.") THEN
                        lProdOrder.MARK(TRUE);
            UNTIL lProdOrderLine.NEXT = 0;
        END;

        lProdOrder.MARKEDONLY(TRUE);
        IF lProdOrder.FINDFIRST THEN BEGIN
            ChangeStatusForm.Set(lProdOrder);
            ChangeStatusForm.Set2(TRUE);
            IF ChangeStatusForm.RUNMODAL() <> ACTION::Yes THEN
                EXIT;
            ChangeStatusForm.ReturnPostingInfo(NewStatus, NewPostingDate, NewUpdateUnitCost);
            ChangeStatusForm.ReturnPostingInfo2(SuppressMessages);
            lNoOfRecords := lProdOrder.COUNT;
            Window.OPEN(
              STRSUBSTNO(TextGMS001, SELECTSTR(NewStatus + 1, LocalText000)) + TextGMS002);
            REPEAT
                lPOCount := lPOCount + 1;
                Window.UPDATE(1, lProdOrder."No.");
                Window.UPDATE(2, ROUND(lPOCount / lNoOfRecords * 10000, 1));
                IF SuppressMessages THEN BEGIN
                    SuppressChangeStatusMessage.Set(NewStatus, NewPostingDate, NewUpdateUnitCost, SuppressMessages);
                    //IF SuppressChangeStatusMessage.Run(lProdOrder) THEN;
                    SuppressChangeStatusMessage.OnRun2(lProdOrder);
                END ELSE BEGIN
                    ProdOrderStatusMgt.ChangeProdOrderStatus(lProdOrder, Enum::"Production Order Status".FromInteger(NewStatus), NewPostingDate, NewUpdateUnitCost);
                    COMMIT;
                END;
            UNTIL lProdOrder.NEXT = 0;
        END;
    end;

    procedure SelectFilterProdOrder(var pProdOrder: Record "Production Order")
    var
        lProdOrderLine: Record "Prod. Order Line";
    begin
        CurrPage.SETSELECTIONFILTER(lProdOrderLine);
        IF lProdOrderLine.FINDFIRST THEN BEGIN
            REPEAT
                IF pProdOrder.GET(lProdOrderLine.Status, lProdOrderLine."Prod. Order No.") THEN
                    pProdOrder.MARK(TRUE);
            UNTIL lProdOrderLine.NEXT = 0;
        END;

        pProdOrder.MARKEDONLY(TRUE);
    end;

    procedure GetItemInfo()
    var
        lItem: Record Item;
    begin
        LotSize := 0;
        SearchDescription := '';

        IF lItem.GET(Rec."Item No.") THEN BEGIN
            LotSize := lItem."Lot Size";
            SearchDescription := lItem."Search Description";
        END;
    end;

    procedure GetProdOrder()
    begin
        CurrProdOrder.GET(Rec.Status, Rec."Prod. Order No.");
        TotalNetWeight := CurrProdOrder."Total Net Weight";
    end;

    procedure GetOrderTracking()
    var
        lOrderTrackingMgt: Codeunit OrderTrackingManagement;
        lOrderTrackingEntry: Record "Order Tracking Entry";
        lSalesHeader: Record "Sales Header";
        lSalesLine: Record "Sales Line";
    begin
        SourceCode := '';
        SourceName := '';
        SourceDueDate := 0D;

        IF NOT OrderTracking THEN
            EXIT;

        lOrderTrackingMgt.SetProdOrderLine(Rec);
        IF NOT lOrderTrackingMgt.FindRecordsWithoutMessage THEN
            EXIT;

        lOrderTrackingMgt.FindRecord('-', lOrderTrackingEntry);
        CASE lOrderTrackingEntry."From Type" OF
            DATABASE::"Sales Line":
                IF lSalesLine.GET(lOrderTrackingEntry."From Subtype", lOrderTrackingEntry."From ID", lOrderTrackingEntry."From Ref. No.")
                THEN BEGIN
                    lSalesHeader.GET(lOrderTrackingEntry."From Subtype", lOrderTrackingEntry."From ID");
                    SourceCode := lSalesLine."Sell-to Customer No.";
                    SourceName := lSalesHeader."Sell-to Customer Name";
                    SourceDueDate := lSalesLine."Shipment Date";
                END;
        END;
    end;

    procedure Setvisible()
    var
        ShowItemAttribute: array[10] of Boolean;
    begin
        TxtSourceCodeVisible := OrderTracking;
        TxtSourceNameVisible := OrderTracking;
        TxtSourceDueDateVisible := OrderTracking;
        TxtExpCostVisible := CostDisplay;
        TxtActCostVisible := CostDisplay;
        TxtCostVarianceVisible := CostDisplay;
        TxtCostVariancePctVisible := CostDisplay;
    end;

    procedure CalcExpectedCost(): Decimal
    begin
        IF LastCalcPONo = Rec."Prod. Order No." THEN
            EXIT(ExpCost[8]);

        CalcCosts;
        EXIT(ExpCost[8]);
    end;

    procedure CalcActualCost(): Decimal
    begin
        IF LastCalcPONo = Rec."Prod. Order No." THEN
            EXIT(ActCost[8]);

        CalcCosts;
        EXIT(ActCost[8]);
    end;

    procedure CalcVarianceCost(): Decimal
    begin
        IF LastCalcPONo = Rec."Prod. Order No." THEN
            EXIT(ActCost[8] - ExpCost[8]);

        CalcCosts;
        EXIT(ActCost[8] - ExpCost[8]);
    end;

    procedure CalcVariancePctCost(): Decimal
    begin
        IF LastCalcPONo = Rec."Prod. Order No." THEN BEGIN
            IF ExpCost[8] = 0 THEN
                EXIT(0);
            EXIT(ROUND((ActCost[8] - ExpCost[8]) / ExpCost[8] * 100, 1));
        END;

        CalcCosts;
        IF ExpCost[8] = 0 THEN
            EXIT(0);
        EXIT(ROUND((ActCost[8] - ExpCost[8]) / ExpCost[8] * 100, 1));
    end;

    procedure CalcCosts()
    var
        POLine: Record "Prod. Order Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
    begin
        LastCalcPONo := Rec."Prod. Order No.";
        CLEAR(ExpCost);
        CLEAR(ActCost);

        POLine := Rec;

        // CostCalcMgt.CalcShareOfTotalCapCost(POLine, ShareOfTotalCapCost);

        // CostCalcMgt.CalcProdOrderLineExpCost(POLine, ShareOfTotalCapCost, ExpCost[1], ExpCost[2], ExpCost[3], ExpCost[4], ExpCost[5]);
        // CostCalcMgt.CalcProdOrderLineExpLabourCost(POLine, ShareOfTotalCapCost, ExpCost[6], ExpCost[7]);

        // CostCalcMgt.CalcProdOrderLineActCost(POLine, ActCost[1], ActCost[2], ActCost[3], ActCost[4], ActCost[5], DummyVar, DummyVar, DummyVar, DummyVar, DummyVar);
        // CostCalcMgt.CalcProdOrderLineActLabourCost(POLine, ShareOfTotalCapCost, GLSetup."Amount Rounding Precision", 1, ActCost[6], ActCost[7]);

        // ActCost[2] := ActCost[2] - ActCost[6];
        // ActCost[4] := ActCost[4] - ActCost[7];

        // ExpCost[8] := ExpCost[1] + ExpCost[2] + ExpCost[3] + ExpCost[4] + ExpCost[5] + ExpCost[6] + ExpCost[7];
        // ActCost[8] := ActCost[1] + ActCost[2] + ActCost[3] + ActCost[4] + ActCost[5] + ActCost[6] + ActCost[7];
    end;


    local procedure StatusFilterOnAfterValidate()
    begin
        SetFormFilters
    end;

    local procedure LocationFilterOnAfterValidate()
    begin
        SetFormFilters
    end;

    local procedure DueDateFilterOnAfterValidate()
    begin
        ApplicationManagement.MakeDateFilter(DueDateFilter);
        SetFormFilters
    end;

    procedure GetLotNo()
    var
        lReserveProdOrderLine: Codeunit "WDC Prod. Order Line-Reserve";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
    begin
        lReserveProdOrderLine.CallItemTracking2(Rec, TempTrackingSpecification);
        TextLotNo := '';
        IF TempTrackingSpecification.COUNT > 1 THEN
            TextLotNo := 'MULTI';
        IF TempTrackingSpecification.FINDFIRST THEN
            TextLotNo := TempTrackingSpecification."Lot No.";
    end;

    var
        //ApplicationManagement: Codeunit 1;
        ApplicationManagement: Codeunit "Filter Tokens";
        ManuPrintReport: Codeunit "Manu. Print Report";
        //ConsignmentManagement: Codeunit "Item Mgt. Template Management";
        GLSetup: Record "General Ledger Setup";
        CurrProdOrder: Record "Production Order";
        StatusFilter: Option Simulated,Planned,"Firm Planned",Released,Finished,All;
        BomTypeFilter: Option Standard,Fardelage,Mix,Stripping,Boxing,"Mix-Boxing",All;
        SourceCode: Code[20];
        LastCalcPONo: Code[20];
        LocationFilter: Code[10];
        StyleTxt: Text;
        TextLotNo: Text[30];
        SourceName: Text[50];
        DueDateFilter: Text[30];
        SearchDescription: Text[50];
        SourceDueDate: Date;
        LotSize: Decimal;
        TotalNetWeight: Decimal;
        ExpCost: array[8] of Decimal;
        ActCost: array[8] of Decimal;
        CapacityTimes: array[8] of Decimal;
        IsLate: Boolean;
        CostDisplay: Boolean;
        OrderTracking: Boolean;
        TxtExpCostVisible: Boolean;
        TxtActCostVisible: Boolean;
        TxtSourceCodeVisible: Boolean;
        TxtSourceNameVisible: Boolean;
        TxtCostVarianceVisible: Boolean;
        TxtSourceDueDateVisible: Boolean;
        TxtCostVariancePctVisible: Boolean;
        TextGMS001: TextConst ENU = 'Changing status to %1...\\',
                              FRA = 'Passage au statut %1 en cours...\\';
        TextGMS002: TextConst ENU = 'Prod. Order #1###### @2@@@@@@@@@@@@@',
                              FRA = 'O.F.  #1###### @2@@@@@@@@@@@@@';
}

