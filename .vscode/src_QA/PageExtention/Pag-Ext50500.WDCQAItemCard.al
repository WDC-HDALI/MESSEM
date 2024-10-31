pageextension 50500 "WDC-QA Item Card" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Specification Class"; Rec."Specification Class")
            {
                ApplicationArea = all;
            }
        }
        modify("Description 2")
        {
            Visible = true;
        }
        modify("Search Description")
        {
            Visible = true;
        }
    }
}
