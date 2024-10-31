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


}
