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

        addlast(processing)
        {

            action("label")
            {
                CaptionML = ENU = 'Label', FRA = 'Étiquette';
                Ellipsis = true;
                Image = PrintDocument;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                begin

                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(50008, TRUE, FALSE, Rec);
                end;
            }

        }
        addlast(Category_Category10)
        {

            actionref("labelref"; "label")
            {

            }


        }
    }

}



