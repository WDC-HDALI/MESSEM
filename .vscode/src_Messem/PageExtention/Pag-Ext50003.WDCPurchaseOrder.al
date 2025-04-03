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
        addlast("Shipping and Payment")
        {
            // field("No. of Shipment Containers"; Rec."No. of Shipment Containers")
            // {
            //     ApplicationArea = all;
            // }
            // field("No. of Shipment Units"; Rec."No. of Shipment Units")
            // {
            //     ApplicationArea = all;
            // }
            field("Pick up Post Code"; Rec."Pick up Post Code")
            {
                ApplicationArea = all;
            }
            field("Pick up City"; Rec."Pick up City")
            {
                ApplicationArea = all;
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
                    REPORT.RUNMODAL(50006, TRUE, FALSE, Rec);
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



