report 50503 "WDC-QA LignesEnregistrementsCQ"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Formlulaire Spécification CQ', FRA = 'Formlulaire Spécification CQ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_QA/Report/RDLC/LignesenregistrementsCQ.rdlc';

    dataset
    {
        dataitem("Registration Line"; "WDC-QA Registration Line")
        {
            DataItemTableView = WHERE("Is Second Sampling" = CONST(false));
            column(PalletNo_RegistrationLine; "Registration Line"."Pallet No.")
            {
            }
            column(DocumentType_RegistrationLine; "Registration Line"."Document Type")
            {
            }
            column(DocumentNo_RegistrationLine; "Registration Line"."Document No.")
            {
            }
            column(LineNo_RegistrationLine; "Registration Line"."Line No.")
            {
            }
            column(ParameterCode_RegistrationLine; "Registration Line"."Parameter Code")
            {
            }
            column(ParameterDescription_RegistrationLine; "Registration Line"."Parameter Description")
            {
            }
            column(IsSecondSampling_RegistrationLine; "Registration Line"."Is Second Sampling")
            {
            }
            column(TypeofResult_RegistrationLine; "Registration Line"."Type of Result")
            {
            }
            column(MeasureNo_RegistrationLine; "Registration Line"."Measure No.")
            {
            }
            column(QCDate_RegistrationLine; "Registration Line"."QC Date")
            {
            }
            column(SampleUOM_RegistrationLine; "Registration Line"."Sample UOM")
            {
            }
            column(LowerLimit_RegistrationLine; "Registration Line"."Lower Limit")
            {
            }
            column(LowerWarningLimit_RegistrationLine; "Registration Line"."Lower Warning Limit")
            {
            }
            column(TargetResultvalue_RegistrationLine; "Registration Line"."Target Result value")
            {
            }
            column(UpperWarningLimit_RegistrationLine; "Registration Line"."Upper Warning Limit")
            {
            }
            column(UpperLimit_RegistrationLine; "Registration Line"."Upper Limit")
            {
            }
            column(ResultOption_RegistrationLine; "Registration Line"."Result Option")
            {
            }
            column(AverageResultOption_RegistrationLine; "Registration Line"."Average Result Option")
            {
            }
            column(ResultValue_RegistrationLine; "Registration Line"."Result Value")
            {
            }
            column(ResultValueUOM_RegistrationLine; "Registration Line"."Result Value UOM")
            {
            }
            column(Controller_RegistrationLine; "Registration Line".Controller)
            {
            }
            column(AverageResultValue_RegistrationLine; "Registration Line"."Average Result Value")
            {
            }
            column(NameControler; NomControlleur)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(QCTime_RegistrationLine; "Registration Line"."QC Time")
            {
            }
            column(LotNo; RegistrationHeader."Lot No.")
            {
            }
            column(Article; RegistrationHeader."Item No.")
            {
            }
            column(PtContrl; RegistrationHeader."Check Point Code")
            {
            }
            column(DateProduction; RegistrationHeader."Production Date")
            {
            }
            column(OptionChifApreVirgu; OptionChifApreVirgu)
            {
            }
            column(Codeutilisateur_RegistrationLine; "Registration Line"."User Code")
            {
            }
            column(ControlDate_RegistrationLine; "Registration Line"."Control Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF lParameter.GET("Registration Line".Type, "Registration Line"."Parameter Code") THEN;
                IF lParameter."Decimal Point" = lParameter."Decimal Point"::"0" THEN BEGIN
                    OptionChifApreVirgu := OptionChifApreVirgu::"0"
                END
                ELSE IF lParameter."Decimal Point" = lParameter."Decimal Point"::"1" THEN BEGIN
                    OptionChifApreVirgu := OptionChifApreVirgu::"1"
                END;
                // QCController.RESET;
                // IF QCController.GET("Registration Line".Controller) THEN
                //     NomControlleur := QCController.Name;

                RegistrationHeader.RESET;
                RegistrationHeader.GET("Registration Line"."Document Type", "Registration Line"."Document No.");


            end;
        }
    }


    trigger OnInitReport()
    begin
        IF CompanyInformation.GET THEN;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.CALCFIELDS(Picture);
    end;

    var
        //QCController: Record "11018316";
        CompanyInformation: Record "Company Information";
        RegistrationHeader: Record "WDC-QA Registration Header";
        NomControlleur: Code[50];
        lParameter: Record "WDC-QA Parameter";
        OptionChifApreVirgu: Option "0","1";
}

