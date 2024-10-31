report 50505 "WDC-QA Quality COntrol Report"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Quality Control Report', FRA = 'Etat contrôle qualité';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_QA/Report/RDLC/QualityCOntrolReport.rdlc';

    dataset
    {
        dataitem("Registration Header"; "WDC-QA Registration Header")
        {
            column(Document_Type_RH; "Document Type")
            {
            }
            column(No_RH; "No.")
            {
            }
            column(Specific_RH; Specific)
            {
            }
            // column(Variety_RH;Variety)
            // {
            // }
            // column(Size_RH;Size)
            // {
            // }
            column(FORMAT_TODAY_FORMAT_TIME_; FORMAT(TODAY) + ' /  ' + FORMAT(TIME))
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(RegistrationAddress_1_; RegistrationAddress[1])
            {
            }
            column(RegistrationAddress_2_; RegistrationAddress[2])
            {
            }
            column(RegistrationAddress_3_; RegistrationAddress[3])
            {
            }
            column(RegistrationAddress_4_; RegistrationAddress[4])
            {
            }
            column(RegistrationAddress_5_; RegistrationAddress[5])
            {
            }
            column(AddressText; AddressText)
            {
            }
            // column(Registration_Header___Item_Attribute_1_; "Registration Header"."Item Attribute 1")
            // {
            // }
            column(Registration_Header___QC_Date_; "Registration Header"."QC Date")
            {
            }
            column(Registration_Header___No__; "Registration Header"."No.")
            {
            }
            // column(Registration_Header___Item_Attribute_2_; "Registration Header"."Item Attribute 2")
            // {
            // }
            column(VendorName_; VendorName)
            {
            }
            // column(Registration_Header___Item_Attribute_3_; "Registration Header"."Item Attribute 3")
            // {
            // }
            // column(Registration_Header___Item_Attribute_4_; "Registration Header"."Item Attribute 4")
            // {
            // }
            column(Registration_Header___Lot_No__; "Registration Header"."Lot No.")
            {
            }
            // column(Registration_Header___Item_Attribute_5_; "Registration Header"."Item Attribute 5")
            // {
            // }
            column(Registration_Header___Check_Point_Code_; "Registration Header"."Check Point Code")
            {
            }
            // column(Registration_Header___Item_Attribute_6_; "Registration Header"."Item Attribute 6")
            // {
            // }
            // column(QCControllerRec_Name; QCControllerRec.Name)
            // {
            // }
            // column(Registration_Header___Item_Attribute_7_; "Registration Header"."Item Attribute 7")
            // {
            // }
            column(Registration_Header___Sample_Temperature_; "Registration Header"."Sample Temperature")
            {
            }
            // column(Registration_Header___Item_Attribute_8_; "Registration Header"."Item Attribute 8")
            // {
            // }
            column(Registration_Header___Item_No__; "Registration Header"."Item No.")
            {
            }
            // column(Registration_Header___Item_Attribute_9_; "Registration Header"."Item Attribute 9")
            // {
            // }
            column(Registration_Header___Item_Description_; "Registration Header"."Item Description")
            {
            }
            // column(Registration_Header___Item_Attribute_10_; "Registration Header"."Item Attribute 10")
            // {
            // }
            column(Registration_Header___Production_Order_No__; "Registration Header"."Production Order No.")
            {
            }
            column(Registration_Header___Return_Order_No__; "Registration Header"."Return Order No.")
            {
            }
            column(Registration_Header___Source_No__; "Registration Header"."Source No.")
            {
            }
            column(Registration_Header___Item_Category_Code_; "Registration Header"."Item Category Code")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(GeneralCaption; GeneralCaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_1_Caption; "Registration Header".FIELDCAPTION("Item Attribute 1"))
            // {
            // }
            // column(Registration_Header___Item_Attribute_2_Caption; "Registration Header".FIELDCAPTION("Item Attribute 2"))
            // {
            // }
            column(QC_DateCaption; QC_DateCaptionLbl)
            {
            }
            column(Registration_Header___No__Caption; Registration_Header___No__CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_3_Caption; "Registration Header".FIELDCAPTION("Item Attribute 3"))
            // {
            // }
            // column(Registration_Header___Item_Attribute_4_Caption; "Registration Header".FIELDCAPTION("Item Attribute 4"))
            // {
            // }
            column(Registration_Header___Lot_No__Caption; Registration_Header___Lot_No__CaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_5_Caption; "Registration Header".FIELDCAPTION("Item Attribute 5"))
            // {
            // }
            column(Registration_Header___Check_Point_Code_Caption; Registration_Header___Check_Point_Code_CaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_6_Caption; "Registration Header".FIELDCAPTION("Item Attribute 6"))
            // {
            // }
            column(ControllerCaption; ControllerCaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_7_Caption; "Registration Header".FIELDCAPTION("Item Attribute 7"))
            // {
            // }
            column(Registration_Header___Sample_Temperature_Caption; Registration_Header___Sample_Temperature_CaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_8_Caption; "Registration Header".FIELDCAPTION("Item Attribute 8"))
            // {
            // }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_9_Caption; "Registration Header".FIELDCAPTION("Item Attribute 9"))
            // {
            // }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            // column(Registration_Header___Item_Attribute_10_Caption; "Registration Header".FIELDCAPTION("Item Attribute 10"))
            // {
            // }
            column(Registration_Header___Production_Order_No__Caption; Registration_Header___Production_Order_No__CaptionLbl)
            {
            }
            column(Registration_Header___Return_Order_No__Caption; Registration_Header___Return_Order_No__CaptionLbl)
            {
            }
            column(Source_No_Caption; Source_No_CaptionLbl)
            {
            }
            column(Registration_Header___Item_Category_Code_Caption; Registration_Header___Item_Category_Code_CaptionLbl)
            {
            }
            dataitem("Registration Line"; "WDC-QA Registration Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(ParametreCode_RL; "Registration Line"."Parameter Code")
                {
                }
                column(ParametreDescription_RL; "Registration Line"."Parameter Description")
                {
                }
                column(Specification_Remark_RL; "Registration Line"."Specification Remark")
                {
                }
                column(ResultValue_RL; "Registration Line"."Result Value")
                {
                }
                column(PaletteNo_RL; "Registration Line"."Pallet No.")
                {
                }
                column(Controller_RL; "Registration Line".Controller)
                {
                }
                column(QcDate_RL; "Registration Line"."QC Date")
                {
                }
                column(QcTime_RL; "Registration Line"."QC Time")
                {
                }
                column(MesureNo; "Registration Line"."Measure No.")
                {
                }
                column(ResultCaption; ResultCaptionLbl)
                {
                }
                column(ResultsCaption; ResultsCaptionLbl)
                {
                }
                column(ConclusionResultTxt; ConclusionResultTxt)
                {
                }
                column(ResultValueTxt; ResultValueTxt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ResultValueTxt := '';
                    ConclusionResultTxt := '';
                    CASE "Type of Result" OF
                        "Type of Result"::Value:
                            BEGIN
                                ResultValueTxt := FORMAT("Average Result Value") + ' ' + FORMAT("Result Value UOM");
                                ConclusionResultTxt := FORMAT("Conclusion Average Result");
                            END;
                        "Type of Result"::Option:
                            BEGIN
                                ResultValueTxt := FORMAT("Result Option");
                                ConclusionResultTxt := FORMAT("Conclusion Result");
                                IF "Parameter Code" = 'PALLET' THEN BEGIN
                                    ConclusionResultTxt := '';
                                    IF "Result Option" = "Result Option"::Good THEN
                                        ResultValueTxt := '[Bloc(100x120cm)]'
                                    ELSE
                                        ResultValueTxt := '[Euro(80x120cm)]';
                                END;
                            END;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                // IF NOT QCControllerRec.GET(Controller) THEN
                //     QCControllerRec.INIT;

                IF NOT ItemRec.GET("Item No.") THEN
                    ItemRec.INIT;

                // IF NOT QCControllerRec.GET(Controller) THEN
                //     QCControllerRec.INIT;

                IF Specific = Specific::Customer THEN BEGIN
                    IF CustRec.GET("Registration Header"."Source No.") THEN BEGIN
                        FormatAddress.Customer(RegistrationAddress, CustRec);
                        AddressText := Text003;
                    END;
                END;

                IF Specific = Specific::Vendor THEN BEGIN
                    IF VendRec.GET("Registration Header"."Source No.") THEN BEGIN
                        VendorName := VendRec.Name;
                        FormatAddress.Vendor(RegistrationAddress, VendRec);
                        AddressText := Text004;
                    END;
                END;
            end;
        }
    }



    trigger OnPreReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        //QCControllerRec: Record "11018316";
        ItemRec: Record "Item Reference";
        CompanyInfo: Record "Company Information";
        CustRec: Record Customer;
        VendRec: Record Vendor;
        FormatAddress: Codeunit "Format Address";
        CopyText: Text[30];
        RegistrationAddress: array[8] of Text[50];
        AddressText: Text[30];
        HeaderTxt: Text[60];
        ValueMeasuredArray: array[2, 100] of Text[30];
        ValueUOMArray: array[2, 100] of Text[30];
        VendorName: Text[50];
        OptionValueMeasuredArray: array[2, 100] of Text[30];
        ResultArray: array[2, 100] of Text[100];
        ShowNulLine: Boolean;
        LayoutToPrint: Option "QC Report Concise","QC Report Extensively";
        i: Integer;
        NoOfColumns: Integer;
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        NoOfRecords: Integer;
        RecordNo: Integer;
        ColumnNo: Integer;
        ResultValueTxt: Text[30];
        ConclusionResultTxt: Text[30];
        ItemDescription: Text[50];
        OutputNo: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Quant: Decimal;
        Text001: Label 'COPY';
        Text003: Label 'Customer';
        Text004: Label 'Vendor';
        Text005: Label 'QUALITY CONTROL REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        GeneralCaptionLbl: Label 'General';
        QC_DateCaptionLbl: Label 'QC Date';
        Registration_Header___No__CaptionLbl: Label 'QR. No.';
        NameCaptionLbl: Label 'Name';
        Registration_Header___Lot_No__CaptionLbl: Label 'Lot No.';
        Registration_Header___Check_Point_Code_CaptionLbl: Label 'Check Point Code';
        ControllerCaptionLbl: Label 'Controller';
        Registration_Header___Sample_Temperature_CaptionLbl: Label 'Sample Temperature';
        Item_No_CaptionLbl: Label 'Item No.';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Registration_Header___Production_Order_No__CaptionLbl: Label 'Production Order No.';
        Registration_Header___Return_Order_No__CaptionLbl: Label 'Return Order No.';
        Source_No_CaptionLbl: Label 'Source No.';
        Registration_Header___Item_Category_Code_CaptionLbl: Label 'Item Category Code';
        ResultsCaptionLbl: Label 'Results';
        ResultCaptionLbl: Label 'Result';
        CommentsCaptionLbl: Label 'Comments';
        End_ResultsCaptionLbl: Label 'End Results';
        DescriptionCaptionLbl: Label 'Description';
        Next_on_new_pageCaptionLbl: Label 'Next on new page';
        QuantCaption: Label 'Quantity';
}

