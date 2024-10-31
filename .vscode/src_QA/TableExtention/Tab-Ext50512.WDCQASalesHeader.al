tableextension 50512 "WDC-QA Sales Header" extends "Sales Header"
{
    fields
    {
        field(50500; "Registration Header Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Registration Header Type', FRA = 'Type en-tête enregistrement';
            Editable = false;
        }

    }
}
