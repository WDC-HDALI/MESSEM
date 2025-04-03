report 50508 "WDC-QA CoA Registration"
{
    CaptionML = ENU = 'CoA Registration', FRA = 'Cerificat d''analyse', NLD = 'CoA registratie';
    RDLCLayout = './.vscode/src_QA/Report/RDLC/CoARegistration.rdlc';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem("Registration Header"; "WDC-QA Registration Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(CoA));
            RequestFilterFields = "No.", "Customer No. Filter", "Lot No. Filter";
            column(AfficherMicrobio; AfficherMicrobio)
            {
            }
            column(ExpirationDate; ExpirDate)
            {
            }
            column(ProductionDate; ProdDateDebut)
            {
            }
            column(OptionParamValue; OptionParamValue)
            {
            }
            column(Text003_FORMATTODAY_FORMATTIME_Text004; Text003 + ' ' + (FORMAT(TODAY)) + ', ' + (FORMAT(TIME)) + ', ' + Text004 + ' ' + USERID)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(BackgoundImage; CompanyInfo.Background)
            {
            }
            //column(BasdePageCOA; CompanyInfo."Bas de page COA")
            //{
            //}
            column(Cust_Name; Cust.Name)
            {
            }
            column(Cust_No; Cust."No.")
            {
            }
            column(Contact_Name; Contact.Name)
            {
            }
            column(Contact_FaxNo; Contact."Fax No.")
            {
            }
            column(RegistrationHeader_LotNo; "Lot No.")
            {
            }
            column(RegistrationHeader_ItemNo; "Item No.")
            {
            }
            column(RegistrationHeader_ItemDescription; "Item Description")
            {
            }
            column(FooterText; FooterText)
            {
            }
            column(RegistrationHeader_QCDate; "QC Date")
            {
            }
            column(CertificateofAnalysisCaption; Certificate_of_AnalysisCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Customer_ContactCaption; Customer_ContactCaptionLbl)
            {
            }
            column(FaxNo_CustomerCaption; Fax_No__CustomerCaptionLbl)
            {
            }
            column(RegistrationHeader_LotNoCaption; LotNoCaption)
            {
            }
            column(RegistrationHeader_ItemNoCaption; ItemNoCaption)
            {
            }
            column(RegistrationHeader_ItemDescriptionCaption; ItemDescCaption)
            {
            }
            column(RegistrationHeader_QCDateCaption; QCDateCaption)
            {
            }
            column(RegistrationHeader_DocumentType; "Document Type")
            {
            }
            column(RegistrationHeader_No; "No.")
            {
            }
            column(AfficheComment; AfficheComment)
            {
            }
            //column("Variété"; Variety)
            //{
            //}
            column(ProdDateMicro; ProdDateMicro)
            {
            }
            column(DateExpireMicro; DateExpireMicro)
            {
            }
            dataitem("Registration Line"; "WDC-QA Registration Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    WHERE(Imprimable = filter(Oui),
                                          "Is Second Sampling" = CONST(false));
                column(UnitofMesureDesc; UnitofMeasure.Description)
                {
                }
                column(OptionChifApreVirgu; OptionChifApreVirgu)
                {
                }
                column(CGP; "Parameter Group Code")
                {
                }
                column(ParamGroupOrder; ParamGroupOrder)
                {
                }
                column(DescriptionGroupe; DescriptionGroupe)
                {
                }
                column(RegistrationLine_TextDescription; "Text Description")
                {
                }
                column(RegistrationLine_TextDescription_2; "Text Description")
                {
                }
                column(StarText; StarText)
                {
                }
                column(LineResult; LineResult)
                {
                }
                column(RegistrationLine_ResultValueUOM; "Result Value UOM")
                {
                }
                column(RegistrationLine_TextDescription_3; "Text Description")
                {
                }
                column(StarText_2; StarText)
                {
                }
                column(RegistrationLine_ResultOption; ResultOption)
                {
                    //OptionCaption = ' ,Bon,Positif,Négatif';
                }
                column(UnitMesureOptionPallet; Uniteoption)
                {
                }
                column(Parameter_DescriptionCaption; Parameter_DescriptionCaptionLbl)
                {
                }
                column(ResultCaption; ResultCaptionLbl)
                {
                }
                column(RegistrationLine_ResultValueUOMCaption; ResultValueUOMCaption)
                {
                }
                column(RegistrationLine_DocumentType; "Document Type")
                {
                }
                column(RegistrationLine_DocumentNo; "Document No.")
                {
                }
                column(RegistrationLine_LineNo; "Line No.")
                {
                }
                column(RegistrationLine_TypeOfResult; FORMAT("Type of Result", 0, 2))
                {
                }
                column(RegistrationLine_Type; FORMAT(Type, 0, 2))
                {
                }
                column(ProductionDate1; ProdDate1)
                {
                }
                column(ProductionDate2; ProdDate2)
                {
                }
                column(ProductionDate3; ProdDate3)
                {
                }
                column(ProductionDate4; ProdDate4)
                {
                }
                column(ProductionDate5; ProdDate5)
                {
                }
                column(ProductionDate6; ProdDate6)
                {
                }
                column(ProductionDate7; ProdDate7)
                {
                }
                column(ProductionDate8; ProdDate8)
                {
                }
                column(ProductionDate9; ProdDate9)
                {
                }
                column(ProductionDate10; ProdDate10)
                {
                }
                column(ProdDate; DateProdDebut)
                {
                }
                column(DateProdFin; DateProdFin)
                {
                }
                column(ExpirDate; DateExpire)
                {
                }
                column(ProductionDateCaption; ProductionDateCaption)
                {
                }
                column(ExpirationDateCaption; ExpirationDateCaption)
                {
                }
                column(AfficheTexte; Affichetexte)
                {
                }
                column(QtyPerShipmentUnit; QtyPerShipmentUnit)
                {
                }
                column(ShipmUnitsPerShipContainer; ShipmUnitsPerShipContainer)
                {
                }
                column(ShipContainer; ShipContainer)
                {
                }
                column(LineResult3; LineResult)
                {
                }
                column(Microbio; Microbio)
                { }
                column(Parameter_Code; "Parameter Code")
                {
                }
                dataitem("Parameters per Customer/Item"; "WDC-QA ParametersCustomer/Item")
                {
                    DataItemTableView = SORTING("Customer No.", "Item No.", "Parameter Code");
                    column(ParametersperCustomerItem_Description; Description)
                    {
                    }
                    column(StarText_3; StarText)
                    {
                    }
                    column(StarText_4; StarText)
                    {
                    }
                    column(LineResult_2; LineResult)
                    {
                    }
                    column(RegistrationLine_ResultValueUOM_2; "Registration Line"."Result Value UOM")
                    {
                    }
                    column(ParametersperCustomerItem_Description_2; Description)
                    {
                    }
                    column(RegistrationLine_ResultOption_2; "Registration Line"."Result Option")
                    {
                    }
                    column(ParametersperCustomerItem_CustomerNo; "Customer No.")
                    {
                    }
                    column(ParametersperCustomerItem_ItemNo_; "Item No.")
                    {
                    }
                    column(ParametersperCustomerItem_ParameterCode; "Parameter Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Print := '';
                        IF CustItemParametersFound THEN
                            Print := 'NextSection';
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF (("Registration Header"."Item No." = '') OR
                          (Cust."No." = '') OR
                          ("Registration Line".Type <> "Registration Line".Type::Parameter) OR
                          ("Registration Line"."Parameter Code" = '')) THEN
                            CurrReport.BREAK;

                        IF (Cust."No." = '') THEN
                            CurrReport.BREAK;

                        SETRANGE("Customer No.", Cust."No.");
                        SETRANGE("Item No.", "Registration Header"."Item No.");
                        SETRANGE("Parameter Code", "Registration Line"."Parameter Code");
                        CustItemParametersFound := FINDFIRST;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    lParameter: Record "WDC-QA Parameter";
                    int: Text;
                begin
                    IF UnitofMeasure.GET("Registration Line"."Result Value UOM") THEN;
                    IF lParameter.GET("Registration Line".Type, "Registration Line"."Parameter Code") THEN;
                    IF lParameter."Decimal Point" = lParameter."Decimal Point"::"0" THEN BEGIN
                        OptionChifApreVirgu := OptionChifApreVirgu::"0"
                    END
                    ELSE IF lParameter."Decimal Point" = lParameter."Decimal Point"::"1" THEN BEGIN
                        OptionChifApreVirgu := OptionChifApreVirgu::"1"
                    END;
                    IF AfficherMicrobio THEN BEGIN
                        IF "Parameter Group Code" <> 'MICRO' THEN
                            CurrReport.SKIP
                    END
                    ELSE BEGIN
                        "Registration Line".MicroBio := '';

                        IF "Parameter Group Code" = 'MICRO' THEN
                            CurrReport.SKIP;
                    END;
                    IF Parameter.GET("Parameter Group Code") THEN BEGIN
                        DescriptionGroupe := Parameter.Description;
                        ParamGroupOrder := Parameter.Order;
                    END
                    ELSE
                        DescriptionGroupe := '';
                    ParamGroupOrder := 0;

                    IF "CoA Type Value" = "CoA Type Value"::Average THEN BEGIN
                        TempRegistrationLine.SETRANGE("Specification No.", "Specification No.");
                        TempRegistrationLine.SETRANGE("Specification Line No.", "Specification Line No.");
                        TempRegistrationLine.SETRANGE("Specification Version No.", "Specification Version No.");
                        TempRegistrationLine.SETRANGE("Parameter Code", "Parameter Code");

                        IF NOT TempRegistrationLine.ISEMPTY THEN
                            CurrReport.SKIP;
                        TempRegistrationLine.INIT;
                        TempRegistrationLine.TRANSFERFIELDS("Registration Line");
                        TempRegistrationLine.INSERT;


                        LineResult := Round("Registration Line"."Average Result Value", 0.1, '<')
                    END ELSE
                        LineResult := Round("Registration Line"."Result Value", 0.1, '<');
                    StarText := '';
                    FooterText := '';
                    IF (Type = Type::Parameter) AND
                      ("Result Value" = 0) AND
                      (("Result Option" <> "Result Option"::Good) AND
                       ("Result Option" <> "Result Option"::Positive) AND
                       ("Result Option" <> "Result Option"::Negative)) THEN BEGIN
                        StarText := '*';
                        FooterText := Text001;
                    END;
                    if ProdDateDebut <> 0D then
                        DateProdDebut := FormatDate(ProdDateDebut);

                    IF ProductionDate1 <> 0D THEN
                        ProdDate1 := FormatDate(ProductionDate1);
                    IF ProductionDate2 <> 0D THEN
                        ProdDate2 := FormatDate(ProductionDate2);
                    IF ProductionDate3 <> 0D THEN
                        ProdDate3 := FormatDate(ProductionDate3);
                    IF ProductionDate4 <> 0D THEN
                        ProdDate4 := FormatDate(ProductionDate4);
                    IF ProductionDate5 <> 0D THEN
                        ProdDate5 := FormatDate(ProductionDate5);
                    IF ProductionDate6 <> 0D THEN
                        ProdDate6 := FormatDate(ProductionDate6);
                    IF ProductionDate7 <> 0D THEN
                        ProdDate7 := FormatDate(ProductionDate7);
                    IF ProductionDate8 <> 0D THEN
                        ProdDate8 := FormatDate(ProductionDate8);
                    IF ProductionDate9 <> 0D THEN
                        ProdDate9 := FormatDate(ProductionDate9);
                    IF ProductionDate10 <> 0D THEN
                        ProdDate10 := FormatDate(ProductionDate10);
                    if ExpirDate <> 0D then
                        DateExpire := FormatDate(ExpirDate);
                    Uniteoption := '';
                    IF "Type of Result" = Enum::"WDC-QA Type Of Result".FromInteger(1) THEN BEGIN
                        ResultOption := GetResultOpt("Document Type".AsInteger(), "Document No.", "Line No.");
                    END;
                    IF "Registration Line"."Parameter Code" = 'PALLET' THEN BEGIN
                        IF "Result Option" = "Result Option"::Good THEN
                            Uniteoption := '[Bloc(100x120cm)]'
                        ELSE
                            Uniteoption := '[Euro(80x120cm)]';
                    END;
                    CustItemParametersFound := FALSE;

                    int := FORMAT("Type of Result", 0, 2);

                end;
            }
            dataitem("Registration Comment Line"; "WDC-QA RegistrationCommentLine")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Display = FILTER(true));
                column(Commentaire; "Registration Comment Line".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                RecLRegisStep1.RESET;
                RecLRegisStep1.SETRANGE("Document Type", "Registration Header"."Document Type");
                RecLRegisStep1.SETRANGE("Document No.", "Registration Header"."No.");
                RecLRegisStep1.SETRANGE("Type of Measure", RecLRegisStep1."Type of Measure"::Option);
                RecLRegisStep1.SETFILTER("Option Measured", '%1', RecLRegisStep1."Option Measured"::Negative);
                IF RecLRegisStep1.FINDFIRST THEN BEGIN
                    OptionParamValue := TRUE
                END;
                IF NOT Cust.GET(GETFILTER("Customer No. Filter")) THEN
                    Cust.INIT
                ELSE
                    IF NOT CurrReport.PREVIEW THEN
                        IF LogInteraction THEN
                            SegManagement.LogDocument(27, "No.", 0, 0, DATABASE::Customer, Cust."No.", '', '',
                                                      COPYSTR(STRSUBSTNO('%1 %2', Text002, "No."), 1, 50), '');

                Certificate.SETRANGE("Customer No.", Cust."No.");
                Certificate.SETFILTER("Report ID", '<>0');
                IF NOT Certificate.FINDFIRST THEN
                    Certificate.INIT;

                IF NOT Contact.GET(Certificate."Contact No.") THEN
                    Contact.INIT;

                TempRegistrationLine.RESET;
                IF NOT TempRegistrationLine.ISEMPTY THEN
                    TempRegistrationLine.DELETEALL;

                Item.RESET;
                Item.SETCURRENTKEY("No.");
                IF Item.GET("Item No.") THEN;

                Packaging.RESET;
                Packaging.SETRANGE(Code, Item."Shipment Unit");
                IF Packaging.FINDFIRST THEN BEGIN
                    IF Palletisation = 0 THEN // Paramètres palletisation ( Request Page) si <> 0 , on récupére la valeur de la palletisation de la fiche article
                        ShipmUnitsPerShipContainer := STRSUBSTNO(Text006, Item."Shipm.Units per Shipm.Containr", Packaging."Description 2")
                    ELSE
                        ShipmUnitsPerShipContainer := STRSUBSTNO(Text006, Palletisation, Packaging."Description 2");

                    QtyPerShipmentUnit := STRSUBSTNO(Text005, Item."Qty. per Shipment Unit", PackagingText);
                END;

                Packaging.RESET;
                Packaging.SETRANGE(Code, Item."Shipment Container");
                IF Packaging.FINDFIRST THEN
                    ShipContainer := Packaging."Description 2";

                IF AfficherMicrobio THEN BEGIN
                    ProdDateMicro := FormatDate(ProductionDate1);
                    DateExpireMicro := FormatDate(ExpirDate);
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF LotNoInformation.GET("Registration Header"."Lot No.") THEN;
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                CompanyInfo.CALCFIELDS(Background);
                //CompanyInfo.CALCFIELDS(CompanyInfo."Bas de page COA");
                "Registration Header".COPYFILTER("Lot No. Filter", "Lot No.");

                ShipmUnitsPerShipContainer := '';
                QtyPerShipmentUnit := '';
                ShipContainer := '';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', FRA = 'Options';
                    field("Afficher Microbio"; AfficherMicrobio)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = '', FRA = 'Afficher Microbio';
                    }
                    field(ProdDateDebut; ProdDateDebut)
                    {
                        CaptionML = ENU = 'No. of Copies', FRA = 'Production date', NLD = 'Aantal exemplaren';
                        Visible = false;
                        ApplicationArea = all;
                    }
                    field(ProductionDate1; ProductionDate1)
                    {
                        CaptionML = ENU = 'Production date 1', FRA = 'Date 1 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate2; ProductionDate2)
                    {
                        CaptionML = ENU = 'Production date 2', FRA = 'Date 2 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate3; ProductionDate3)
                    {
                        CaptionML = ENU = 'Production date 3', FRA = 'Date 3 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate4; ProductionDate4)
                    {
                        CaptionML = ENU = 'Production date 4', FRA = 'Date 4 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate5; ProductionDate5)
                    {
                        CaptionML = ENU = 'Production date 5', FRA = 'Date 5 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate6; ProductionDate6)
                    {
                        CaptionML = ENU = 'Production date 6', FRA = 'Date 6 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate7; ProductionDate7)
                    {
                        CaptionML = ENU = 'Production date 7', FRA = 'Date 7 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate8; ProductionDate8)
                    {
                        CaptionML = ENU = 'Production date 8', FRA = 'Date 8 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate9; ProductionDate9)
                    {
                        CaptionML = ENU = 'Production date 9', FRA = 'Date 9 production ';
                        ApplicationArea = all;
                    }
                    field(ProductionDate10; ProductionDate10)
                    {
                        CaptionML = ENU = 'Production date 10', FRA = 'Date 10 production ';
                        ApplicationArea = all;
                    }
                    field(ExpirDate; ExpirDate)
                    {
                        CaptionML = ENU = 'Show Internal Information', FRA = 'Expiration date', NLD = 'Interne informatie weergeven';
                        ApplicationArea = all;
                    }
                    field("Afficher Commentaire"; AfficheComment)
                    {
                        CaptionML = ENU = 'Show Comment', FRA = 'Afficher Commentaire';
                        ApplicationArea = all;
                    }
                    field(Palletisation; Palletisation)
                    {
                        CaptionML = FRA = 'Palletisation';
                        ApplicationArea = all;
                    }
                    field(PackagingText; PackagingText)
                    {
                        CaptionML = ENU = 'Packaging', FRA = 'Emballage';
                        Style = Strong;
                        StyleExpr = TRUE;
                        ApplicationArea = all;
                    }
                }
            }
        }
        trigger OnInit()
        begin
            Palletisation := 0;
            PackagingText := Text007;
            ManufacturingSetup.GET;
            ExpirDate := ManufacturingSetup."Expiration Date";
            ProdDateDebut := ManufacturingSetup."Production Date";
        end;

        trigger OnOpenPage()
        begin
            ManufacturingSetup.GET;
            ExpirDate := ManufacturingSetup."Expiration Date";
            ProdDateDebut := ManufacturingSetup."Production Date";
        end;
    }

    trigger OnInitReport()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(27) <> '';
        LogInteraction := FindInteractTmplCode(27) <> '';
    end;

    procedure FindInteractTmplCode(DocumentType: Integer) InteractTmplCode: Code[10]
    var

    begin
        IF InteractionTmplSetup.GET THEN
            CASE DocumentType OF
                1:
                    InteractTmplCode := InteractionTmplSetup."Sales Quotes";
                2:
                    InteractTmplCode := InteractionTmplSetup."Sales Blnkt. Ord";
                3:
                    InteractTmplCode := InteractionTmplSetup."Sales Ord. Cnfrmn.";
                4:
                    InteractTmplCode := InteractionTmplSetup."Sales Invoices";
                5:
                    InteractTmplCode := InteractionTmplSetup."Sales Shpt. Note";
                6:
                    InteractTmplCode := InteractionTmplSetup."Sales Cr. Memo";
                7:
                    InteractTmplCode := InteractionTmplSetup."Sales Statement";
                8:
                    InteractTmplCode := InteractionTmplSetup."Sales Rmdr.";
                9:
                    InteractTmplCode := InteractionTmplSetup."Serv Ord Create";
                10:
                    InteractTmplCode := InteractionTmplSetup."Serv Ord Post";
                11:
                    InteractTmplCode := InteractionTmplSetup."Purch. Quotes";
                12:
                    InteractTmplCode := InteractionTmplSetup."Purch Blnkt Ord";
                13:
                    InteractTmplCode := InteractionTmplSetup."Purch. Orders";
                14:
                    InteractTmplCode := InteractionTmplSetup."Purch Invoices";
                15:
                    InteractTmplCode := InteractionTmplSetup."Purch. Rcpt.";
                16:
                    InteractTmplCode := InteractionTmplSetup."Purch Cr Memos";
                17:
                    InteractTmplCode := InteractionTmplSetup."Cover Sheets";
                18:
                    InteractTmplCode := InteractionTmplSetup."Sales Return Order";
                19:
                    InteractTmplCode := InteractionTmplSetup."Sales Finance Charge Memo";
                20:
                    InteractTmplCode := InteractionTmplSetup."Sales Return Receipt";
                21:
                    InteractTmplCode := InteractionTmplSetup."Purch. Return Shipment";
                22:
                    InteractTmplCode := InteractionTmplSetup."Purch. Return Ord. Cnfrmn.";
                23:
                    InteractTmplCode := InteractionTmplSetup."Service Contract";
                24:
                    InteractTmplCode := InteractionTmplSetup."Service Contract Quote";
                25:
                    InteractTmplCode := InteractionTmplSetup."Service Quote";
                26:
                    InteractTmplCode := InteractionTmplSetup."Non Conformances";
                27:
                    InteractTmplCode := InteractionTmplSetup.CoA;
                28:
                    InteractTmplCode := InteractionTmplSetup."Product Specifications";
            END;
        EXIT(InteractTmplCode);
    end;

    procedure FormatDate(MaDate: Date): Text[20]
    var
        Mois: Text[5];
        TexteDate: Text[20];
        Jour: Text[2];
    begin
        TexteDate := '';
        CASE DATE2DMY(MaDate, 2) OF
            1:
                Mois := 'Jan';
            2:
                Mois := 'Feb';
            3:
                Mois := 'Mar';
            4:
                Mois := 'Apr';
            5:
                Mois := 'May';
            6:
                Mois := 'Jun';
            7:
                Mois := 'Jul';
            8:
                Mois := 'Aug';
            9:
                Mois := 'Sep';
            10:
                Mois := 'Oct';
            11:
                Mois := 'Nov';
            12:
                Mois := 'Dec';
        END;
        IF STRLEN(FORMAT(DATE2DMY(MaDate, 1))) = 1 THEN
            Jour := '0' + FORMAT(DATE2DMY(MaDate, 1))
        ELSE
            Jour := FORMAT(DATE2DMY(MaDate, 1));

        TexteDate := Jour + ' ' + Mois + ' ' + FORMAT(DATE2DMY(MaDate, 3));
        EXIT(TexteDate);
    end;

    procedure GetResultOpt(DocType: Option; DocNo: Code[20]; LineNo: Integer) Return: Code[10]
    var
        RecLRegisStep: Record "WDC-QA Registration Step";
    begin
        RecLRegisStep.RESET;
        RecLRegisStep.SETRANGE("Document Type", DocType);
        RecLRegisStep.SETRANGE("Document No.", DocNo);
        RecLRegisStep.SETRANGE("Line No.", LineNo);
        IF RecLRegisStep.FINDSET THEN BEGIN
            CASE RecLRegisStep."Option Measured".AsInteger() OF
                0:
                    Return := '';
                1, 2:
                    Return := 'OK';
                3:
                    Return := 'NOT OK';
            END;
        END;
    end;

    procedure GetDateInfo(var ExpiratDate: Date; var ProdDate: Date)
    begin
        ProdDateDebut := ProdDate;
        ExpiratDate := ExpiratDate;
    end;

    var
        Item: Record Item;
        Cust: Record Customer;
        Contact: Record Contact;
        Packaging: Record "WDC Packaging";
        Parameter: Record "WDC-QA Parameter Group";
        Certificate: Record "WDC-QA Certificate of Analysis";
        CompanyInfo: Record "Company Information";
        UnitofMeasure: Record "Unit of Measure";
        LRegistComment: Record "WDC-QA RegistrationCommentLine";
        RecLRegisStep1: Record "WDC-QA Registration Step";
        RegistrationLine: Record "WDC-QA Registration Line";
        ResourceRegister: Record "Resource Register";
        LotNoInformation: Record "Lot No. Information";
        ManufacturingSetup: Record "Manufacturing Setup";
        InteractionTmplSetup: Record "Interaction Template Setup";
        TempRegistrationLine: Record "WDC-QA Registration Line" temporary;
        SegManagement: Codeunit SegManagement;
        LineResult: Decimal;
        ParamGroupOrder: Integer;
        Palletisation: Integer;
        OptionChifApreVirgu: Option "0","1";
        Affichetexte: Boolean;
        AfficheComment: Boolean;
        LogInteraction: Boolean;
        OptionParamValue: Boolean;
        AfficherMicrobio: Boolean;
        CustItemParametersFound: Boolean;
        ExpirDate: Date;
        ProdDateFin: Date;
        ProdDateDebut: Date;
        ProductionDate1: Date;
        ProductionDate2: Date;
        ProductionDate3: Date;
        ProductionDate4: Date;
        ProductionDate5: Date;
        ProductionDate6: Date;
        ProductionDate7: Date;
        ProductionDate8: Date;
        ProductionDate9: Date;
        ProductionDate10: Date;
        Print: Text[30];
        StarText: Text[30];
        ProdDate1: Text[20];
        ProdDate2: Text[20];
        ProdDate3: Text[20];
        ProdDate4: Text[20];
        ProdDate5: Text[20];
        ProdDate6: Text[20];
        ProdDate7: Text[20];
        ProdDate8: Text[20];
        ProdDate9: Text[20];
        FooterText: Text[100];
        Commentaire: Text[50];
        DateProdFin: Text[20];
        ProdDate10: Text[20];
        DateExpire: Text[20];
        Uniteoption: Text[20];
        ResultOption: Text[10];
        ProdDateMicro: Text;
        PackagingText: Text[30];
        ShipContainer: Text[100];
        DateProdDebut: Text[20];
        DateExpireMicro: Text;
        DescriptionGroupe: Text[30];
        QtyPerShipmentUnit: Text[100];
        ShipmUnitsPerShipContainer: Text[100];
        Err001: TextConst ENU = 'End date must be greater than the current day date',
                          FRA = 'Date fin doit être supérieur à la date du jour';
        Text001: TextConst ENU = '*) As soon as the results are known, we will send these through by fax.',
                           FRA = '*) Dès que les résultats seront connus, nous les enverrons par fax.';
        Text002: TextConst ENU = 'Analysis Certificate',
                           FRA = 'Certificat d''analyse';
        Text003: TextConst ENU = 'Printed on:',
                           FRA = 'Imprimé le :';
        Text004: TextConst ENU = 'by:',
                           FRA = 'Par:';
        Text005: TextConst ENU = '%1 %2',
                           FRA = '%1 %2';
        Text006: TextConst ENU = '%1 %2',
                           FRA = '%1 %2';
        Text007: TextConst ENU = 'kg bag-in-box',
                           FRA = 'kg bag-in-box';
        LotNoCaption: TextConst ENU = 'Batch Number',
                                FRA = 'Batch Number';
        ItemNoCaption: TextConst ENU = 'Product Number',
                                 FRA = 'Product Number';
        QCDateCaption: TextConst ENU = 'QC Date',
                                 FRA = 'QC Date';
        ResultCaptionLbl: TextConst ENU = 'Result',
                                    FRA = 'Résultat';
        ItemDescCaption: TextConst ENU = 'Product Description',
                                   FRA = 'Product Description';
        ResultValueUOMCaption: TextConst ENU = 'Unit Value Result',
                                         FRA = 'Unit Value Result';
        ProductionDateCaption: TextConst ENU = 'Production Date',
                                         FRA = 'Production date';
        ExpirationDateCaption: TextConst ENU = 'Shelf life expiration date',
                                         FRA = 'Shelf life expiration date';
        Customer_NameCaptionLbl: TextConst ENU = 'Customer Name',
                                           FRA = 'Nom client';
        Customer_ContactCaptionLbl: TextConst ENU = 'Customer Contact',
                                              FRA = 'Contact client';
        Fax_No__CustomerCaptionLbl: TextConst ENU = 'Fax No. Customer',
                                              FRA = 'N° fax client';
        Parameter_DescriptionCaptionLbl: TextConst ENU = 'Parameter Description',
                                                   FRA = 'Description paramètre';
        Certificate_of_AnalysisCaptionLbl: TextConst ENU = 'Certificate of Analysis',
                                                     FRA = 'Certificat d''analyses';
}

