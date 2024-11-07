page 50005 "WDC Lot Attribute Values"
{
    CaptionML = ENU = 'Lot Attribute Value', FRA = 'Valeur Lot Attribue';
    PageType = List;
    SourceTable = "WDC Lot Attribute Value";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lot Attribute No."; Rec."Lot Attribute No.")
                {
                    ApplicationArea = all;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

