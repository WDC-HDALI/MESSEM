namespace MESSEM.MESSEM;

using Microsoft.Foundation.Address;

tableextension 50038 "WDC Post Code" extends "Post Code"
{
    fields
    {

    }
    procedure LookUpPostCode(var City: Text[30]; var PostCode: Code[20]; var County: Text[30]; var CountryCode: Code[10]; ReturnValues: Boolean)
    var
        PostCodeRec: Record "Post Code";
    begin
        IF NOT GUIALLOWED THEN
            EXIT;

        PostCodeRec.SETCURRENTKEY(Code, City);
        PostCodeRec.Code := PostCode;
        PostCodeRec.City := City;
        IF (PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) = ACTION::LookupOK) AND ReturnValues THEN BEGIN
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
            CountryCode := PostCodeRec."Country/Region Code";
            County := PostCodeRec.County;
        END;
    end;

}
