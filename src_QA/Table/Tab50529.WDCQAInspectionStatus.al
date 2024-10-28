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
        field(4; "Planning Inventory"; Option)
        {
            CaptionML = ENU = 'Calculate Plan', FRA = 'Calculer planning';
            OptionMembers = " ","Not Available";
            OptionCaptionML = ENU = ' ,Not Available', FRA = ' ,Indisponible';
        }
        field(5; Consumption; Option)
        {
            CaptionML = ENU = 'Consumption', FRA = 'CONSOMMATION';
            OptionMembers = " ","Not Available","Manually Available";
            OptionCaptionML = ENU = ' ,Not Available,Manually Available', FRA = ' ,Indisponible,Dispo. manuel';
        }
        field(6; Sales; Option)
        {
            CaptionML = ENU = 'Sales', FRA = 'Vente';
            OptionMembers = " ","Not Available","Manually Available";
            ;
            OptionCaptionML = ENU = ' ,Not Available,Manually Available', FRA = ' ,Indisponible,Dispo. manuel';
        }
        field(7; Pick; Option)
        {
            CaptionML = ENU = 'Pick', FRA = 'Prélèvement';
            OptionMembers = " ","Not Available","Manually Available";
            OptionCaptionML = ENU = ' ,Not Available,Manually Available', FRA = ' ,Indisponible,Dispo. manuel';
        }
        field(8; "Purchase Invoice"; Option)
        {
            CaptionML = ENU = 'Purchase Invoice', FRA = 'Facture achat';
            OptionMembers = " ","Not Available";
            OptionCaptionML = ENU = ' ,Not Available', FRA = ' ,Indisponible';
        }
        field(9; "Transfer From"; Option)
        {
            CaptionML = ENU = 'Transfer From', FRA = 'Prov. transfert';
            OptionMembers = " ","Not Available","Manually Available";
            OptionCaptionML = ENU = ' ,Not Available,Manually Available', FRA = ' ,Indisponible,Dispo. manuel';
        }
        field(10; "Result Sample"; Option)
        {
            CaptionML = ENU = 'Result Sample', FRA = 'Résultat échantillon';
            OptionMembers = " ","Take Sample",Approved,Rejected;
            OptionCaptionML = ENU = ' ,Take Sample,Approved,Rejected', FRA = ' ,Echantillonnage,Approuvé,Rejeté';
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
