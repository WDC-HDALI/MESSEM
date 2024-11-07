namespace MessemMA.MessemMA;

using System.Globalization;

tableextension 50029 "WDC Language" extends Language
{
    procedure GetLanguageID(LanguageCode: Code[10]): Integer
    begin
        CLEAR(Rec);
        IF LanguageCode <> '' THEN
            IF GET(LanguageCode) THEN
                EXIT("Windows Language ID");
        "Windows Language ID" := GLOBALLANGUAGE;
        EXIT("Windows Language ID");
    end;

}
