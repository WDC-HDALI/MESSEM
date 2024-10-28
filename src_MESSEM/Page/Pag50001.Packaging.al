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
                }
                field(Type; rec.Type)
                {
                }
                field(Description; rec.Description)
                {
                }
                field("Description 2"; rec."Description 2")
                {
                }
                field("Register Balance"; rec."Register Balance")
                {
                    Editable = true;
                }
                field("Item No."; rec."Item No.")
                {
                }
                field("Surface (m2)"; rec."Surface (m2)")
                {
                }
                field("Volume (m3)"; rec."Volume (m3)")
                {
                }
                field(Weight; rec.Weight)
                {
                }

            }
        }

    }

}

