table 50529 "WDC-QA Inspection Status"
{
    CaptionML = ENU = 'WDC-QA Inspection Status', FRA = 'statut d''inspection';
    DataClassification = ToBeClassified;
    //LookupPageId="WDC-QA Inspectation Statue";

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        field(2; Description; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Déscription';
        }
        field(3; QC; Boolean)
        {
            CaptionML = ENU = 'QC', FRA = 'CQ';
        }
        field(4; "Planning Inventory"; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Calculate Plan', FRA = 'Calculer planning';
            ValuesAllowed = 0, 1;
        }
        field(5; Consumption; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Consumption', FRA = 'CONSOMMATION';
        }
        field(6; Sales; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Sales', FRA = 'Vente';
        }
        field(7; Pick; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Pick', FRA = 'Prélèvement';
        }
        field(8; "Purchase Invoice"; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Purchase Invoice', FRA = 'Facture achat';
            ValuesAllowed = 0, 1;
        }
        field(9; "Transfer From"; Enum "WDC-QA Available")
        {
            CaptionML = ENU = 'Transfer From', FRA = 'Prov. transfert';
        }
        field(10; "Result Sample"; Enum "WDC-QA Result Sample")
        {
            CaptionML = ENU = 'Result Sample', FRA = 'Résultat échantillon';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    procedure CreateInspectionStatusFilter(AvailableFor: Option Sales,Transfer,Consumption) InspectionStatusFilter2: Code[240]
    var
        InspectionStatus: Record "WDC-QA Inspection Status";
    begin
        InspectionStatus.RESET;
        CASE AvailableFor OF
            AvailableFor::Sales:
                InspectionStatus.SETRANGE(Sales, InspectionStatus.Sales::" ");
            AvailableFor::Transfer:
                InspectionStatus.SETRANGE("Transfer From", InspectionStatus."Transfer From"::" ");
            AvailableFor::Consumption:
                InspectionStatus.SETRANGE(Consumption, InspectionStatus.Consumption::" ");
        END;
        InspectionStatusFilter2 := '''''';

        IF InspectionStatus.FINDSET THEN
            REPEAT
                IF InspectionStatusFilter2 <> '' THEN
                    InspectionStatusFilter2 := InspectionStatusFilter2 + '|';
                InspectionStatusFilter2 := InspectionStatusFilter2 + InspectionStatus.Code;
            UNTIL (InspectionStatus.NEXT = 0) OR (STRLEN(InspectionStatusFilter2) > 240);
    end;
}
