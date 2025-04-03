pageextension 50046 "WDC Released ProductionOrder" extends "Released Production Order"
{
    layout
    {
        addafter("Source No.")
        {
            field("Routing No."; Rec."Routing No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Location Code")
        {
            Visible = true;
        }
        modify("Bin Code")
        {
            Visible = true;
        }
        moveafter(Quantity; "Location Code")
        moveafter("Location Code"; "Bin Code")
        addafter("Last Date Modified")
        {
            field("Sous traitance"; Rec."Sous traitance")
            {
                ApplicationArea = All;
            }
            field("No. of  printed  labels"; Rec."No. of  printed  labels")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action("Print Label")
            {
                CaptionML = ENU = 'Print Box Label', FRA = 'Imprimer étiquette carton';
                Image = PrintInstallment;
                ApplicationArea = all;
                trigger OnAction()
                var
                    lItem: Record Item;
                    lProductionOrder: Record "Production Order";
                    lStanderdBoxLabel: Report "WDC Standerd Box Label";
                    lFDABoxLabel: report "WDC FDA Box Label";
                    lEUBoxLabel: Report "WDC EU Box Label";
                begin
                    lProductionOrder.RESET;
                    lProductionOrder.SETRANGE(Status, Rec.Status);
                    lProductionOrder.SETRANGE("No.", Rec."No.");
                    IF lProductionOrder.FINDFIRST THEN;
                    IF lItem.GET(Rec."Source No.") THEN;
                    CASE lItem."Label Type" OF
                        lItem."Label Type"::Standard, lItem."Label Type"::"Standard + Special":
                            BEGIN
                                CLEAR(lStanderdBoxLabel);
                                lStanderdBoxLabel.SETTABLEVIEW(lProductionOrder);
                                lStanderdBoxLabel.CalcPrePrintNo(lProductionOrder);
                                lStanderdBoxLabel.RUNMODAL;
                            END;
                        lItem."Label Type"::FDA:
                            BEGIN
                                CLEAR(lFDABoxLabel);
                                lFDABoxLabel.SETTABLEVIEW(lProductionOrder);
                                lFDABoxLabel.CalcPrePrintNo(lProductionOrder);
                                lFDABoxLabel.RUNMODAL;
                            END;
                        lItem."Label Type"::EU:
                            BEGIN
                                CLEAR(lEUBoxLabel);
                                lEUBoxLabel.SETTABLEVIEW(lProductionOrder);
                                lEUBoxLabel.CalcPrePrintNo(lProductionOrder);
                                lEUBoxLabel.RUNMODAL;
                            END;
                    END;
                end;
            }

        }
        addafter("&Update Unit Cost")
        {
            action("Exporter à Colos")
            {
                CaptionML = ENU = 'Export Label', FRA = 'Exporter à Colos';
                Image = Export;
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                begin
                    Rec.exportColos(Rec);
                end;
            }
        }
    }
}
