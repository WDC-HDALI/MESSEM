namespace MESSEM.MESSEM;

using Microsoft.Sales.Customer;

tableextension 50020 "WDC Customer " extends Customer
{
    fields
    {
        field(50000; "Packaging Price"; Boolean)
        {
            CaptionML = ENU = 'Packaging Price', FRA = 'Facturer emballage';
            DataClassification = ToBeClassified;
        }
        field(50001; "Transport Tariff Code"; Boolean)
        {
            CaptionML = ENU = 'Transport Tariff Code', FRA = 'Code tarif transport';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Transport Tariff Code";
        }
    }
}
