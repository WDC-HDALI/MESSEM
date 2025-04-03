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
        modify("reason code")
        {
            Visible = TRUE;
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
            action("Print Mouvement MD/EMB")
            {
                CaptionML = ENU = 'Print Packaging Mouvement MD/EMB', FRA = 'Imprimer mouvement MD/EMB';
                Image = PrintCheck;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ItemJnlLine: Record "Item Journal Line";
                    lText001: Label 'Les catégories des articles doit être de type MD ou EMB';
                begin
                    //<<WDC02
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", rec."Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", rec."Journal Batch Name");
                    ItemJnlLine.SETFILTER("Item Category Code", 'MD|EMB');
                    IF ItemJnlLine.FINDSET THEN
                        REPORT.RUNMODAL(REPORT::"WDC Packaging Movement MD/EMB", TRUE, TRUE, ItemJnlLine)
                    ELSE
                        MESSAGE(lText001);
                    //>>WDC02
                end;
            }
        }
    }



    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     IF ItemJournalBatch.GET(Rec."Journal Template Name", rec."Journal Batch Name") THEN begin
    //         rec."Source Type" := ItemJournalBatch."Source Type by Default";
    //         rec."Entry Type" := ItemJournalBatch."Entry Type"; //WDC.HG
    //     end;


    // end;

    // var
    //     ItemJournalBatch: record "Item Journal Batch";


}
