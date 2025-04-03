report 50022 "WDC Purch. By Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PurchByVendor.rdlc';

    CaptionML = ENU = 'Vendor reception matrix', FRA = 'Matrice réception par fournisseur';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Date_; Date)
        {
            DataItemTableView = SORTING("Period Type", "Period Start");
            column(Period_Type; Date_."Period Type")
            {
            }
            column(Period_Start; Date_."Period Start")
            {
            }
            column(Period_End; Date_."Period End")
            {
            }
            column(Period_No; Date_."Period No.")
            {
            }
            column(Period_Name; Date_."Period Name")
            {
            }
            column(GETFILTERS; GETFILTERS)
            {
            }
            column(HeaderText; GetDateHeader(Date_))
            {
            }
            column(Companyname; CompanyInfo.Name)
            {
            }
            column(Title; Title)
            {
            }
            column(FiltreVender; Vendor.GETFILTERS)
            {
            }
            dataitem(Vendor; Vendor)
            {
                DataItemTableView = WHERE("Vendor Posting Group" = CONST('FR-MAT 1ER'));
                RequestFilterFields = "Pay-to Vendor No.", "Item Category Filter", "Item Filter";

                column(Vendor_No; Vendor."No.")
                {
                    IncludeCaption = true;
                }
                column(Vendor_Name; Vendor.Name)
                {
                    IncludeCaption = true;
                }
                column(PurchasesQty; Vendor."Purchases (Qty.)")
                {
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Date Filter", Date_."Period Start", Date_."Period End");
                end;
            }

            trigger OnPreDataItem()
            begin
                IF StartDate = 0D THEN
                    ERROR(Text001);

                SETRANGE("Period Type", PeriodType);
                SETFILTER("Period Start", '%1..%2', StartDate, EndDate);

                //SETFILTER("Period End", '%1', EndDate);

                CompanyInfo.get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PeriodType; PeriodType)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'View by', FRA = 'Afficher par';
                        OptionCaptionML = ENU = 'Day,Week,Month,Quarter,Year', FRA = 'Jour,Semaine,Mois,Trimestre,Année';
                    }
                    field(DateFilter; StartDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Starting Date', FRA = 'Date début';

                        trigger OnValidate()
                        var
                            lItem: Record 27;
                        begin
                            lItem.SETFILTER("Date Filter", DateFilter);
                            DateFilter := lItem.GETFILTER("Date Filter");
                        end;
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Ending Date', FRA = 'Date fin';

                    }
                }
            }
        }
    }

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        DateFilter: Text;
        StartDate: Date;
        EndDate: Date;
        Text001: TextConst ENU = 'You must enter the date filter', FRA = 'Vous devez entrer le filtre date';
        Text002: Label 'W. %1 : %2';
        Text003: Label 'TRIM. %1 : %2';
        Title: TextConst ENU = 'Matrice Réception par Fournisseur', FRA = 'Matrice Réception par Fournisseur';
        CompanyInfo: Record "Company Information";

    procedure GetDateHeader(pDate: Record 2000000007): Text[20]
    begin
        CASE pDate."Period Type" OF
            PeriodType::Day:
                EXIT(FORMAT(pDate."Period Start"));
            PeriodType::Week:
                EXIT(STRSUBSTNO(Text002, pDate."Period Name", DATE2DMY(pDate."Period Start", 3)));
            PeriodType::Quarter:
                EXIT(STRSUBSTNO(Text003, pDate."Period Name", DATE2DMY(pDate."Period Start", 3)));
            PeriodType::Month:
                EXIT(pDate."Period Name");
            PeriodType::Year:
                EXIT(pDate."Period Name");
        END;
    end;
}

