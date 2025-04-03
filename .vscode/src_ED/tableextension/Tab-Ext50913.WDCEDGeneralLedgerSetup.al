tableextension 50913 "WDC-ED General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(50800; "Posting Allowed From"; Date)
        {
            CalcFormula = Min("Accounting Period"."Starting Date" WHERE("Fiscally Closed" = FILTER(false)));
            CaptionML = ENU = 'Posting Allowed From', FRA = 'Début validation autorisée';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50801; "Posting Allowed To"; Date)
        {
            CalcFormula = Max("Accounting Period"."Starting Date" WHERE("New Fiscal Year" = FILTER(true),
                                                                         "Fiscally Closed" = FILTER(false)));
            CaptionML = ENU = 'Posting Allowed To', FRA = 'Fin validation autorisée';
            Editable = false;
            FieldClass = FlowField;
        }
        // field(50805; "Local Currency"; Enum "WDC-ED Local Currency")
        // {
        //     CaptionML = ENU = 'Local Currency', FRA = 'Devise société';

        //     trigger OnValidate()
        //     begin
        //         if "Local Currency" = "Local Currency"::Euro then
        //             "Currency Euro" := '';
        //     end;
        // }
        // field(50806; "Currency Euro"; Code[10])
        // {
        //     CaptionML = ENU = 'Currency Euro', FRA = 'Devise Euro';
        //     TableRelation = Currency;

        //     trigger OnValidate()
        //     begin
        //         if ("Local Currency" = "Local Currency"::Euro) and ("Currency Euro" <> '') then
        //             Error(
        //               Text001,
        //               FieldCaption("Currency Euro"),
        //               FieldCaption("Local Currency"),
        //               "Local Currency");
        //     end;
        // }
    }
    var
        Text001: TextConst ENU = 'It is not allowed to specify %1 when %2 is %3.',
                           FRA = 'Il n''est pas autorisé de spécifier %1 si %2 est %3.';
}