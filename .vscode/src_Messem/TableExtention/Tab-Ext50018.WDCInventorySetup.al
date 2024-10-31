tableextension 50018 "WDC Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(50500; "Packaging Rounding Precision"; Decimal)
        {
            CaptionML = ENU = 'Packaging Rounding Precision', FRA = 'Précision arrondi emballage';
            DataClassification = ToBeClassified;
            InitValue = 0.00001;
        }
    }
}
