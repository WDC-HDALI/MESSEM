namespace MESSEM.MESSEM;

using Microsoft.Inventory.Journal;

pageextension 50037 "WDC Item Journal" extends "Item Journal"
{
    layout
    {

        addafter(Description)
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = all;
                editable = true;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = all;
                Editable = true;
            }

        }
        moveafter("Source No."; "reason code")

    }
    actions
    {
        addafter("&Print")
        {
            action("&Print Packaging Mouvement")
            {
                Captionml = ENU = '&Print Packaging Mouvement', FRA = '&Imprimer mouvement caisse', NLD = '&Afdrukken';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;


                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"WDC Packaging Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF ItemJournalBatch.GET(Rec."Journal Template Name", rec."Journal Batch Name") THEN
            rec."Source Type" := ItemJournalBatch."Source Type by Default";

    end;

    var
        ItemJournalBatch: record "Item Journal Batch";


}
