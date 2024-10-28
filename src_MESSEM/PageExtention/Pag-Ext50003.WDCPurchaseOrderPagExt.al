pageextension 50003 "WDC Purchase Order PagExt" extends "Purchase Order"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("N° ferme"; Rec.Farm)
            {
                CaptionML = ENU = 'Farm No.', FRA = 'N° ferme';
            }
            field("N° parcel"; Rec."Parcel No.")
            {
                CaptionML = ENU = 'Parcel No.', FRA = 'N° parcelle';
            }
        }
    }


}
