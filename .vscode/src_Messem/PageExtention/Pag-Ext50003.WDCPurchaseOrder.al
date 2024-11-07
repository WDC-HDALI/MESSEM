pageextension 50003 "WDC Purchase Order " extends "Purchase Order"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("N° ferme"; Rec.Farm)
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Farm No.', FRA = 'N° ferme';
            }
            field("N° parcel"; Rec."Parcel No.")
            {
                ApplicationArea = all;
                CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';
            }
        }

    }
    actions
    {
        addlast(Reporting)
        {
            action("&Print Label")
            {
                Caption = '&Print Label';
                Ellipsis = true;
                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50004, TRUE, FALSE, Rec);
                end;
            }

        }

    }


}
