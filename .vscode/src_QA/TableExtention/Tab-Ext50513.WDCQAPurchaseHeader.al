tableextension 50513 "WDC-QA Purchase Header" extends "Purchase Header"
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
