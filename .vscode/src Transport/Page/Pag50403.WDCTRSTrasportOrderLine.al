namespace MESSEM.MESSEM;

page 50403 "WDC-TRS Trasport Order Line"
{
    CaptionML = ENU = 'Lines', FRA = 'Lignes';
    PageType = ListPart;
    SourceTable = "WDC-TRS Trasport Order Line";
    Editable = false;
    ApplicationArea = all;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
