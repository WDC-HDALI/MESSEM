namespace MESSEM.MESSEM;

using Microsoft.Purchases.Setup;

tableextension 50027 "WDC Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Date Price-and Discount Def."; Enum "WDC Date Price-Discount Def")
        {
            CaptionML = ENU = 'Date Price-and Discount Definition', FRA = 'Date détermination prix et remises';
            DataClassification = ToBeClassified;
        }

    }
}
