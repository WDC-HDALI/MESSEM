page 50001 "WDC Packaging"
{
    CaptionML = ENU = 'Packaging', FRA = 'Emballage';
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "WDC Packaging";
    UsageCategory = lists;

    layout
    {
        area(content)
        {
            repeater(control1)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Description 2"; rec."Description 2")
                {
                    ApplicationArea = all;
                }
                field("Register Balance"; rec."Register Balance")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Surface (m2)"; rec."Surface (m2)")
                {
                    ApplicationArea = all;
                }
                field("Volume (m3)"; rec."Volume (m3)")
                {
                    ApplicationArea = all;
                }
                field(Weight; rec.Weight)
                {
                    ApplicationArea = all;
                }

            }
        }

    }

}

