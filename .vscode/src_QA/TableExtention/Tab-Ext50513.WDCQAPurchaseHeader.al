tableextension 50513 "WDC-QA Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50500; "Registration Header Type"; Enum "WDC-QA Document Type")
        {
            CaptionML = ENU = 'Registration Header Type', FRA = 'Type en-tête enregistrement';
            Editable = false;
        }
        field(50501; "Registration Header No."; Code[20])
        {
            CaptionML = ENU = 'Registration Header No.', FRA = 'N° En-tête enregistrement';
            Editable = false;
            TableRelation = "WDC-QA Registration Header"."No." WHERE("Document Type" = FIELD("Registration Header Type"));
        }
    }
}
