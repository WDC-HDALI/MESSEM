namespace MESSEM.MESSEM;

using Microsoft.Inventory.Item.Catalog;

pageextension 50504 "WDC-QA Item Reference Entries" extends "Item Reference Entries"
{
    layout
    {
        addafter(Description)
        {
            field(Color; Rec.Color)
            {
                ApplicationArea = aLL;
            }
            field("Odor / Taste"; Rec."Odor / Taste")
            {
                ApplicationArea = aLL;
            }
            field(Consistency; Rec.Consistency)
            {
                ApplicationArea = aLL;
            }
            field(Brix; Rec.Brix)
            {
                ApplicationArea = aLL;
            }
            field(PH; Rec.PH)
            {
                ApplicationArea = aLL;
            }
            field(Caliber; Rec.Caliber)
            {
                ApplicationArea = aLL;
            }
            field("Blooms / Caps"; Rec."Blooms / Caps")
            {
                ApplicationArea = aLL;
            }
            field("Stems / Parts of stams"; Rec."Stems / Parts of stams")
            {
                ApplicationArea = aLL;
            }
            field(Leafmaterial; Rec.Leafmaterial)
            {
                ApplicationArea = aLL;
            }
            field("Rotten / Mouldy fruit"; Rec."Rotten / Mouldy fruit")
            {
                ApplicationArea = aLL;
            }
            field("Unripe Fruit"; Rec."Unripe Fruit")
            {
                ApplicationArea = aLL;
            }
            field("Overripe Fruit"; Rec."Overripe Fruit")
            {
                ApplicationArea = aLL;
            }
            field(Scap; Rec.Scap)
            {
                ApplicationArea = aLL;
            }
            field(Packing; Rec.Packing)
            {
                ApplicationArea = aLL;
            }
            field(Carton; Rec.Carton)
            {
                ApplicationArea = aLL;
            }
            field("Color Inliner"; Rec."Color Inliner")
            {
                ApplicationArea = aLL;
            }
            field("Tape Color"; Rec."Tape Color")
            {
                ApplicationArea = aLL;
            }
            field("Foreign Bodies free"; Rec."Foreign Bodies free")
            {
                ApplicationArea = aLL;
            }
            field("Min. 1% of weight"; Rec."Min. 1% of weight")
            {
                ApplicationArea = aLL;
            }
            field(Spec; Rec.Spec)
            {
                ApplicationArea = aLL;
            }
        }
    }
}
