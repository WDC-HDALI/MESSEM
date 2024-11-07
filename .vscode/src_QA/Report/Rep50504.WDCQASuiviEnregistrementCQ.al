report 50504 "WDC-QA Suivi Enregistrement CQ"
{

    CaptionML = ENU = 'Quality Control Report', FRA = 'Etat contrôle qualité';
    RDLCLayout = './.vscode/src_QA/Report/RDLC/SuiviEnregistrementCQ.rdlc';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ApplicationArea = All;
    dataset
    {
        dataitem("Registration Header"; "WDC-QA Registration Header")
        {
            DataItemTableView = SORTING(Status, "Item No.", "Lot No.", "Check Point Code", "Buy-from Vendor No.")
                                WHERE(Status = FILTER(Closed),
                                      "Document Type" = FILTER(QC));
            RequestFilterFields = "Item No.", "Lot No.", "QC Date", "No.", "Buy-from Vendor No.";
            column(Img; RecGCampanyInfo.Picture)
            {
            }
            column(Name; RecGCampanyInfo.Name)
            {
            }
            column(Address; RecGCampanyInfo.Address)
            {
            }
            column(Address_2_; RecGCampanyInfo."Address 2")
            {
            }
            column(City; RecGCampanyInfo.City + ' - ' + RecGCampanyInfo."Post Code")
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(LotNoFilt; LotNoFilt)
            {
            }
            column(DateLot; DateLot)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No; "No.")
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(LotNo; "Lot No.")
            {
            }
            column(QCDate; "QC Date")
            {
            }
            column(FrsNo; "Buy-from Vendor No.")
            {
            }
            dataitem("Registration Line"; "WDC-QA Registration Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Parameter Code")
                                    WHERE("Document Type" = CONST(QC));
                RequestFilterFields = "Parameter Code", "Conclusion Result", "Result Value";
                column(DocumentType_RegistrationLine; "Registration Line"."Document Type")
                {
                }
                column(ParameterCode_RegistrationLine; "Registration Line"."Parameter Code")
                {
                }
                column(ParameterCode; "Parameter Code")
                {
                }
                column(UpperLimit_RegistrationLine; "Upper Limit")
                {
                }
                column(LowerLimit_RegistrationLine; "Lower Limit")
                {
                }
                column(ResultValue; "Result Value")
                {
                }
                column(ConclusionResult; "Conclusion Result")
                {
                }
                column(LineCount; LineCount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    LineCount := COUNT;
                end;

                trigger OnPreDataItem()
                begin
                    LineCount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                LRegistrationLine: Record "wdc-QA Registration Line";
            begin
                LRegistrationLine.RESET;
                LRegistrationLine.SETRANGE("Document No.", "No.");
                LRegistrationLine.SETRANGE("Document Type", "Document Type");
                IF LRegistrationLine.ISEMPTY THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                RecGCampanyInfo.GET;
                RecGCampanyInfo.CALCFIELDS(Picture);

                IF GETFILTER("No.") <> '' THEN
                    DocNo := 'Filter Document:' + GETFILTER("No.");
                IF GETFILTER("Lot No.") <> '' THEN
                    LotNoFilt := 'Filter Lot:' + GETFILTER("Lot No.");
                IF GETFILTER("QC Date") <> '' THEN
                    DateLot := 'Filter Date:' + GETFILTER("QC Date");
                IF GETFILTER("Item No.") <> '' THEN
                    ItemFilter := 'Filter Article:' + GETFILTER("Item No.");
            end;
        }
    }



    var
        RecGCampanyInfo: Record "Company Information";
        DocNo: Text[800];
        LotNoFilt: Text[800];
        DateLot: Text[800];
        ItemFilter: Text[800];
        Param: Code[20];
        LineCount: Integer;
}

