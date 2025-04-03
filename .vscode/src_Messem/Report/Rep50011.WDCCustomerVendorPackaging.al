report 50011 "WDC Customer/Vendor Packaging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/CustomerVendorPackaging.rdlc';

    CaptionML = ENU = 'Customer/Vendor Packaging', FRA = 'Client/Fournisseur Emballage';

    dataset
    {
        dataitem("WDC Customer/Vendor Packaging"; "WDC Customer/Vendor Packaging")
        {
            DataItemTableView = SORTING("Source Type", "Source No.", Code);
            RequestFilterFields = "Code", "Item No.";
            column(COMPANYNAME; companyinfo.Name)
            {
            }
            column(USERID; USERID)
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PAGENO)
            // {
            // }
            column(TIME; TIME)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Customer_Vendor_Packaging__TABLECAPTION___Text000__________CustomerVendorPackagingFilter; "WDC Customer/Vendor Packaging".TABLECAPTION + Text000 + ': ' + CustomerVendorPackagingFilter)
            {
            }
            column(CustomerVendorPackagingFilter; CustomerVendorPackagingFilter)
            {
            }
            column(BeginDate_; BeginDate)
            {
            }
            column(EndDate_; EndDate)
            {
            }
            column(BeginDate__Control1100481043; BeginDate)
            {
            }
            column(EndDate__Control1100481045; EndDate)
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(NewPageSource; NewPageSource)
            {
            }
            column(DetailsPrinted; DetailsPrinted)
            {
            }
            column(Customer_Vendor_Packaging__Source_No__; "Source No.")
            {
            }
            column(Customer_Vendor_Packaging__Item_No__; "Item No.")
            {
            }
            column(Customer_Vendor_Packaging_Balance; Balance)
            {
            }
            column(SourceName; SourceName)
            {
            }
            column(SourceShippingAgent; SourceShippingAgent)
            {
            }
            column(Customer_Vendor_Packaging_Code; Code)
            {
            }
            column(Customer_Vendor_Packaging_Description; Description)
            {
            }
            column(Customer_Vendor_Packaging__Starting_Balance_; "Starting Balance")
            {
            }
            column(Customer_Vendor_Packaging__Balance_Normal_; "Balance Normal")
            {
            }
            column(Customer_Vendor_Packaging__Balance_Return_; "Balance Return")
            {
            }
            column(Customer_Vendor_Packaging__Ending_Balance_; "Ending Balance")
            {
            }
            column(Customer_Vendor_Packaging__Starting_Balance__Control1100481035; "Starting Balance")
            {
            }
            column(Customer_Vendor_Packaging__Balance_Normal__Control1100481036; "Balance Normal")
            {
            }
            column(Customer_Vendor_Packaging__Balance_Return__Control1100481037; "Balance Return")
            {
            }
            column(Customer_Vendor_Packaging__Ending_Balance__Control1100481038; "Ending Balance")
            {
            }
            column(SourceName_Control1100481041; SourceName)
            {
            }
            column(Customer_Vendor_Packaging__Source_No___Control1100481051; "Source No.")
            {
            }
            column(SourceType_Control1100481052; SourceType)
            {
            }
            column(Packaging_overview_Customer___VendorCaption; Packaging_overview_Customer___VendorCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(SourceShippingAgentCaption; SourceShippingAgentCaptionLbl)
            {
            }
            column(Customer_Vendor_Packaging_BalanceCaption; Customer_Vendor_Packaging_BalanceCaptionLbl)
            {
            }
            column(Customer_Vendor_Packaging__Ending_Balance_Caption; FIELDCAPTION("Ending Balance"))
            {
            }
            column(Customer_Vendor_Packaging__Balance_Normal_Caption; FIELDCAPTION("Balance Normal"))
            {
            }
            column(Customer_Vendor_Packaging__Balance_Return_Caption; FIELDCAPTION("Balance Return"))
            {
            }
            column(SourceNameCaption; SourceNameCaptionLbl)
            {
            }
            column(Customer_Vendor_Packaging__Starting_Balance_Caption; FIELDCAPTION("Starting Balance"))
            {
            }
            column(Customer_Vendor_Packaging__Source_No__Caption; FIELDCAPTION("Source No."))
            {
            }
            column(SourceTypeCaption; SourceTypeCaptionLbl)
            {
            }
            column(Customer_Vendor_Packaging__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Customer_Vendor_Packaging_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Customer_Vendor_Packaging_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Source_No_Caption; Source_No_CaptionLbl)
            {
            }
            column(Source_NameCaption; Source_NameCaptionLbl)
            {
            }
            column(Starting_BalanceCaption; Starting_BalanceCaptionLbl)
            {
            }
            column(Ending_BalanceCaption; Ending_BalanceCaptionLbl)
            {
            }
            column(Balance_NormalCaption; Balance_NormalCaptionLbl)
            {
            }
            column(Balance_ReturnCaption; Balance_ReturnCaptionLbl)
            {
            }
            column(Source_TypeCaption; Source_TypeCaptionLbl)
            {
            }
            column(Customer_Vendor_Packaging_Source_Type; "Source Type")
            {
            }
            column(True_Caption; True_CaptionLBL)
            {
            }
            column(False_Caption; False_CaptionLBL)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SourceShippingAgent := IsShippingAgent;
                IF SourceShippingAgent THEN BEGIN
                    IF SaldoPer IN [SaldoPer::Customer, SaldoPer::Vendor] THEN
                        CurrReport.SKIP;
                END ELSE
                    IF SaldoPer = SaldoPer::"Shipping Agent" THEN
                        CurrReport.SKIP;

                CASE "Source Type" OF
                    DATABASE::Customer:
                        SETRANGE("Source Type Filter", "Source Type Filter"::Customer);
                    DATABASE::Vendor:
                        SETRANGE("Source Type Filter", "Source Type Filter"::Vendor);
                    ELSE
                        SETRANGE("Source Type Filter");
                END;
                CALCFIELDS(Balance, "Starting Balance", "Balance Normal", "Balance Return", "Ending Balance");

                IF (Balance = 0) AND ("Starting Balance" = 0) AND ("Ending Balance" = 0) AND
                   ("Balance Normal" = 0) AND ("Balance Return" = 0) THEN
                    CurrReport.SKIP;

                SourceName := '';
                CASE "Source Type" OF
                    DATABASE::Customer:
                        BEGIN
                            SourceType := Customer.TABLECAPTION;
                            IF Customer.GET("Source No.") THEN
                                SourceName := Customer.Name;
                        END;
                    DATABASE::Vendor:
                        BEGIN
                            SourceType := Vendor.TABLECAPTION;
                            IF Vendor.GET("Source No.") THEN
                                SourceName := Vendor.Name;
                        END;
                END;

                DetailsPrinted := TRUE;

                IF FirstLineHasBeenOutput THEN
                    CLEAR(CompanyInfo.Picture);
                FirstLineHasBeenOutput := TRUE;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

                SETFILTER("Start Posting Date Filter", '<%1', BeginDate);
                SETFILTER("End Posting Date Filter", '..%1', EndDate);
                SETFILTER("Range Posting Date Filter", '%1..%2', BeginDate, EndDate);

                CASE SaldoPer OF
                    SaldoPer::All:
                        SETRANGE("Source Type");
                    SaldoPer::Customer:
                        SETRANGE("Source Type", DATABASE::Customer);
                    SaldoPer::Vendor:
                        SETRANGE("Source Type", DATABASE::Vendor);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BeginDate; BeginDate)
                {
                    Caption = 'Begin Date';
                    ApplicationArea = all;
                }
                field("End Date"; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
                }
                field("Show balance per"; SaldoPer)
                {
                    Caption = 'Show balance per';
                    OptionCaption = 'All,Customer,Vendor,Shipping Agent';
                    ApplicationArea = all;
                }
                field("Print Details"; PrintDetails)
                {
                    Caption = 'Print Details';
                    ApplicationArea = all;
                }
                field("Per number new page"; NewPageSource)
                {
                    Caption = 'Per number new page';
                    ApplicationArea = all;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintDetails := FALSE;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF BeginDate = 0D THEN
            BeginDate := 00000101D;
        IF EndDate = 0D THEN
            EndDate := 99991231D;

        CASE SaldoPer OF
            SaldoPer::All:
                "WDC Customer/Vendor Packaging".SETRANGE("Source Type");
            SaldoPer::Customer:
                "WDC Customer/Vendor Packaging".SETRANGE("Source Type", DATABASE::Customer);
            SaldoPer::Vendor:
                "WDC Customer/Vendor Packaging".SETRANGE("Source Type", DATABASE::Vendor);
        END;

        CustomerVendorPackagingFilter := "WDC Customer/Vendor Packaging".GETFILTERS;
    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        SaldoPer: Option All,Customer,Vendor,"Shipping Agent";
        Balance: Decimal;
        SourceType: Text[50];
        SourceName: Text[50];
        CustomerVendorPackagingFilter: Text[250];
        Text000: TextConst ENU = 'Filters', FRA = 'Filtres';
        SourceShippingAgent: Boolean;
        PrintDetails: Boolean;
        NewPageSource: Boolean;
        DetailsPrinted: Boolean;
        BeginDate: Date;
        EndDate: Date;
        Packaging_overview_Customer___VendorCaptionLbl: TextConst ENU = 'Packaging overview Customer / Vendor', FRA = 'Aperçu emballage client / fournisseur';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        SourceShippingAgentCaptionLbl: TextConst ENU = 'Shipping Agent', FRA = 'Transporteur';
        Customer_Vendor_Packaging_BalanceCaptionLbl: TextConst ENU = 'Actual Balance', FRA = 'Solde actuel';
        SourceNameCaptionLbl: TextConst ENU = 'Source Name', FRA = 'Nom origine';
        SourceTypeCaptionLbl: TextConst ENU = 'Source Type', FRA = 'Type origine';
        Source_No_CaptionLbl: TextConst ENU = 'Source No.', FRA = 'N° origine';
        Source_NameCaptionLbl: TextConst ENU = 'Source Name', FRA = 'Nom origine';
        Starting_BalanceCaptionLbl: TextConst ENU = 'Starting Balance', FRA = 'Solde début';
        Ending_BalanceCaptionLbl: TextConst ENU = 'Ending Balance', FRA = 'Solde final';
        Balance_NormalCaptionLbl: TextConst ENU = 'Balance Normal', FRA = 'Solde normal';
        Balance_ReturnCaptionLbl: TextConst ENU = 'Balance Return', FRA = 'Solde retour';
        Source_TypeCaptionLbl: TextConst ENU = 'Source Type', FRA = 'Type origine';
        True_CaptionLBL: TextConst ENU = 'Yes', FRA = 'oui';
        False_CaptionLBL: TextConst ENU = 'No', FRA = 'Non';
        FirstLineHasBeenOutput: Boolean;
}

