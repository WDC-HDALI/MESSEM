namespace Messem.Messem;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Tracking;

reportextension 50001 "WDC Prod. Order - Mat. Requisi" extends "Prod. Order - Mat. Requisition"
{
    RDLCLayout = './.vscode/src_Messem/ReportExtention/RDLC/ProdOrderMatRequisition.rdlc';
    dataset
    {
        addbefore("Prod. Order Component")
        {
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.");
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                column(LotText1; LotText[1])
                { }
                column(LotText2; LotText[2])
                { }
                column(LotText3; LotText[3])
                { }
                column(LotText4; LotText[4])
                { }
                column(LotText5; LotText[5])
                { }
                column(CommentText1; CommentText[1])
                { }
                column(CommentText2; CommentText[2])
                { }
                column(CommentText3; CommentText[3])
                { }
                column(CommentText4; CommentText[4])
                { }
                column(CommentText5; CommentText[5])
                { }
                column(CommentText; CommentText2)
                { }
                column(CommentLBL; CommentLBL)
                { }
                trigger OnAfterGetRecord()
                var
                    lReserveProdOrderLine: Codeunit "Wdc Prod. Order Line-Reserve";
                    i: Integer;
                    ProdOrderComment: Record "Prod. Order Comment Line";
                begin
                    lReserveProdOrderLine.CallItemTracking2("Prod. Order Line", TempTrackingSpecification);

                    CLEAR(LotText);
                    i := 0;
                    IF TempTrackingSpecification.FINDSET THEN
                        REPEAT
                            i += 1;
                            IF i <= 5 THEN LotText[i] := TempTrackingSpecification."Lot No.";
                        UNTIL TempTrackingSpecification.NEXT = 0;

                    CLEAR(ProdOrderComment);

                    CRLF[1] := 13;
                    CRLF[2] := 10;
                    CommentText2 := '';
                    ProdOrderComment.RESET;
                    ProdOrderComment.SETRANGE(Status, "Prod. Order Line".Status);
                    ProdOrderComment.SETRANGE("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
                    IF ProdOrderComment.FINDSET THEN
                        REPEAT
                            CommentText2 += ProdOrderComment.Comment + CRLF
                        UNTIL ProdOrderComment.NEXT = 0;

                end;
            }
        }
    }
    var
        CRLF: text[2];
        CommentText2: Text[250];
        CommentText: array[5] of Text[100];
        LotText: array[5] of Text[30];
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        CommentLBL: TextConst ENU = 'comment', FRA = 'Commentaire';
}
