namespace Messem.Messem;

page 50019 "WDC Colos"
{
    ApplicationArea = All;
    CaptionML = ENU = 'WDC Colos', FRA = 'WDC Colos';
    PageType = List;
    SourceTable = "WDC Colos";
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Num_OF; Rec.Num_OF)
                {
                    ApplicationArea = all;
                }
                field(Nom_Article_Anglais; Rec.Nom_Article_Anglais)
                {
                    ApplicationArea = all;
                }
                field("Nom_Article_Français"; Rec."Nom_Article_Français")
                {
                    ApplicationArea = all;
                }
                field(Num_Article; Rec.Num_Article)
                {
                    ApplicationArea = all;
                }
                field(Num_Lot; Rec.Num_Lot)
                {
                    ApplicationArea = all;
                }
                field(Poids_Net; Rec.Poids_Net)
                {
                    ApplicationArea = all;
                }
                field(Type_Etiq; Rec.Type_Etiq)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
