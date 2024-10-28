tableextension 50517 "WDC-QA Manufacturing Setup" extends "Manufacturing Setup"
{
    fields
    {
        field(50500; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(50501; "Production Date"; Date)
        {
            Caption = 'Production Date';
            DataClassification = ToBeClassified;
        }
    }
}
