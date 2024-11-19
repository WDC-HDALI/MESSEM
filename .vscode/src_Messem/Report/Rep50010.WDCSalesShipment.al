report 50010 "WDC Sales Shipment"
{
    // WDC01   24.08.2023  WDC.IM  Add Field
    // WDC02   30.08.2023  WDC.IM  Add Variable
    // WDC03   31.08.2023  WDC.IM  Update
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/MESSEMSalesShipment.rdlc';

    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(ExternalDocumentNo_SalesShipmentHeader; "Sales Shipment Header"."External Document No.")
            {
            }
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem(CopyLoop; integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfoPicture5; CompanyInfo5.Picture)
                    {
                    }
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesShptHeader; "Sales Shipment Header"."Your Reference")
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(ShptDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Shipment Date", 0, '<Day,2><Filler Character, > <Month Text,3> <Year4>'))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(TranspName; ShippingAgent.Name)
                    {
                    }
                    column(ContainerNo_SalesHeader; "Sales Shipment Header"."Container No.")
                    {
                    }
                    column(ScelleNo_SalesHeader; "Sales Shipment Header"."Scelle No.")
                    {
                    }
                    column(Incoterm; "Sales Shipment Header"."Shipment Method Code")
                    {
                    }
                    column(ShptMethodDescCaption; ShptMethodDescCaptionLbl)
                    {
                    }
                    column(DestPort_SalesShipHeader; Harbor.Description)
                    {
                    }
                    column(NotifyParty1value; "Sales Shipment Header"."Notify Party 1")
                    {
                    }
                    column(NotifyParty2value; "Sales Shipment Header"."Notify Party 2")
                    {
                    }
                    column(NotifyPartyAdress; NotifyPartyAdress)
                    {
                    }
                    column(NotifyPartyPhone; NotifyPartyPhone)
                    {
                    }
                    column(NotifyPartyEmail; NotifyPartyEmail)
                    {
                    }
                    column(NotifyParty_Designation; NotifyParty.Désignation)
                    {
                    }
                    column(NotifyParty2_Designation; NotifyParty2.Désignation)
                    {
                    }
                    column(NotifyParty_City; NotifyParty.City)
                    {
                    }
                    column(NotifyParty2_City; NotifyParty2.City)
                    {
                    }
                    column(NotifyPostCode; NotifyPostCode)
                    {
                    }
                    column(NotifyPartyAdress2; NotifyPartyAdress2)
                    {
                    }
                    column(NotifyPartyPhone2; NotifyPartyPhone2)
                    {
                    }
                    column(NotifyPartyEmail2; NotifyPartyEmail2)
                    {
                    }
                    column(NotifyPostCode2; NotifyPostCode2)
                    {
                    }
                    column(ShipAddressCode; ShipAddress.Name)
                    {
                    }
                    column(ShipAddressAddress; ShipAddress.Address)
                    {
                    }
                    column(ShipAddressAddress2; ShipAddress."Address 2")
                    {
                    }
                    column(ShipAddressCity; ShipAddress.City)
                    {
                    }
                    column(ShipAddressPostCode; ShipAddress."Post Code")
                    {
                    }
                    column(ShipAddressCountry; ShipAddress."Country/Region Code")
                    {
                    }
                    column(OrderNo; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(TotalWeight; TotalWeight)
                    {
                    }
                    column(FreightPayable; text1)
                    {
                    }
                    column(PalletQuantity; "Sales Shipment Header"."Pallet Quantity")
                    {
                    }
                    column(LoseBoxes; text2)
                    {
                    }
                    column(CountryRegionName; CountryRegion.Name)
                    {
                    }
                    column(BillName; "Sales Shipment Header"."Bill-to Name")
                    {
                    }
                    column(BillAdress; "Sales Shipment Header"."Bill-to Address")
                    {
                    }
                    column(BillCity; "Sales Shipment Header"."Bill-to City")
                    {
                    }
                    column(BillPostCode; "Sales Shipment Header"."Bill-to Post Code")
                    {
                    }
                    column(CountryRegionName1; CountryRegion1.Name)
                    {
                    }
                    column(PalletNumbCaption; PalletNumbCaption)
                    {
                    }
                    column(LosesBoxCaption; LosesBoxCaption)
                    {
                    }
                    column(FreightPayableCaption; FreightPayableCaption)
                    {
                    }
                    column(TotalWeightCaption; TotalWeightCaption)
                    {
                    }
                    column(ShipAdressCaption; ShipAdressCaption)
                    {
                    }
                    column(DestHarborCaption; DestHarborCaption)
                    {
                    }
                    column(ContainerNoCaption; ContainerCaption)
                    {
                    }
                    column(ScelleNoCaption; ScelleNoCaption)
                    {
                    }
                    column(TranspNameCaption; TranspNameCaption)
                    {
                    }
                    column(NotifyPartyCaption; NotifyParty1Caption)
                    {
                    }
                    column(NotifyParty2Caption; NotifyParty2Caption)
                    {
                    }
                    column(HarmTariffCodeCaption; HarmTariffCodeCaption)
                    {
                    }
                    column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
                    {
                    }
                    column(Coment_1; Coment[1])
                    {
                    }
                    column(Coment_2; Coment[2])
                    {
                    }
                    dataitem(DimensionLoop1; integer)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Shipment Line"; 111)
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ItemNoGrp; ItemNoGrp)
                        {
                        }
                        column(GrossWeightt; GrossWeightt)
                        {
                        }
                        column(GrossWeight_SalesShipmentLine; "Sales Shipment Line"."Gross Weight")
                        {
                        }
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        // column(LotNo_SalesShipmentLine;"Sales Shipment Line"."Lot No.")
                        // {
                        // }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; UnitMeas)
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(PalletNum_SalesLine; "Sales Shipment Line"."Quantity Shipment Containers")
                        {
                        }
                        column(Pallet_Description; PalletDescription)
                        {
                        }
                        column(Shipment_Container; "Sales Shipment Line"."Shipment Container")
                        {
                        }
                        column(UniContainer; UniContainer)
                        {
                        }
                        column(BoxNum_SalesLine; "Sales Shipment Line"."Quantity Shipment Units")
                        {
                        }
                        column(BoxType_SalesLine; "Sales Shipment Line"."Shipment Unit")
                        {
                        }
                        column(HarmTariff; "Sales Shipment Line"."Harmonised Tariff Code")
                        {
                        }
                        column(TotalQty2_SalesLine; TotalQty2)
                        {
                        }
                        column(TotalBox_SalesLine; TotalBox)
                        {
                        }
                        column(BoxNumCaption; BoxNumCaption)
                        {
                        }
                        column(BoxTypeCaption; BoxTypeCaption)
                        {
                        }
                        column(Description_SalesShptLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesShptLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(lPAL; lPAL)
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(X; X)
                        {
                        }
                        column(Format2; Format2)
                        {
                        }
                        column(Format3; Format3)
                        {
                        }
                        column(Format4; Format4)
                        {
                        }
                        dataitem("Item Ledger Entry"; "Item Ledger Entry")
                        {
                            DataItemLink = "Item No." = FIELD("No."),
                                           "Document Line No." = FIELD("Order Line No."),
                                           "Document No." = FIELD("Document No.");
                            column(LotNo_ItemLedgerEntry; "Item Ledger Entry"."Lot No.")
                            {
                            }
                            column(DocumentLineNo_ItemLedgerEntry; "Item Ledger Entry"."Document Line No.")
                            {
                            }
                            column(OrderLineNo_ItemLedgerEntry; "Item Ledger Entry"."Order Line No.")
                            {
                            }
                            column(ItemNo_ItemLedgerEntry; "Item Ledger Entry"."Item No.")
                            {
                            }
                            column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.")
                            {
                            }
                        }
                        dataitem(DimensionLoop2; integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;
                            end;
                        }
                        dataitem(DisplayAsmInfo; integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                                //DecimalPlaces = 0:5;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    PostedAsmLine.FINDSET
                                ELSE
                                    PostedAsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmHeaderExists THEN
                                    CurrReport.BREAK;

                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            LinNo := "Line No.";
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            IF DisplayAssemblyInformation THEN
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            //Cal. Poids Total
                            IF "Sales Shipment Line".Type = "Sales Shipment Line".Type::Item THEN //WDC03
                                TotalWeight += Quantity;
                            GrossWeightt := 0;//WDC01
                            GrossWeightt := Quantity; //WDC01
                            Packaging.RESET;
                            IF Packaging.GET("Shipment Unit") THEN BEGIN
                                GrossWeightt += "Quantity Shipment Units" * Packaging.Weight;//WDC01
                                TotalWeight += "Quantity Shipment Units" * Packaging.Weight;
                            END;
                            Packaging.RESET;

                            IF Packaging.GET("Shipment Container") THEN BEGIN
                                BEGIN
                                    GrossWeightt += "Quantity Shipment Containers" * Packaging.Weight; //WDC01
                                    TotalWeight += "Quantity Shipment Containers" * Packaging.Weight;
                                END;

                                PalletDescription := Packaging.Description;
                            END;

                            IF "Sales Shipment Line".Type = "Sales Shipment Line".Type::Item THEN //WDC03
                                TotalQty2 += Quantity;
                            TotalBox += "Quantity Shipment Units";
                            IF "Unit of Measure" = 'Kilo' THEN
                                UnitMeas := 'KG' ELSE
                                UnitMeas := "Unit of Measure";
                            UniContainer := '';
                            CASE "Shipment Container" OF
                                'PAL B':
                                    UniContainer := 'PC';
                                'PAL E':
                                    UniContainer := 'PC';
                            END;

                            IF "Shipment Container" = 'PAL B' THEN
                                lPAL := 'BLOCPallet'
                            ELSE IF "Shipment Container" = 'PAL E' THEN
                                lPAL := 'EUROPallet';


                            IF "Sales Shipment Line".Quantity > 999 THEN
                                X := '#0"."###'
                            ELSE
                                X := '###';


                            IF TotalQty2 > 999 THEN
                                Format2 := '#0"."###'
                            ELSE
                                Format2 := '###';

                            IF TotalWeight > 999 THEN
                                Format3 := '#0"."###'
                            ELSE
                                Format3 := '###';

                            IF TotalBox > 999 THEN
                                Format4 := '#0"."###'
                            ELSE
                                Format4 := '###';
                            //<<WDC02
                            IF ("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) OR ("Sales Shipment Line".Type = "Sales Shipment Line".Type::"Charge (Item)") THEN
                                ItemNoGrp := "Sales Shipment Line"."No.";
                            //>>WDC02
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF ShowLotSN THEN BEGIN
                                ItemTrackingMgt.SetRetrieveAsmItemTracking(TRUE);
                                TrackingSpecCount := ItemTrackingMgt.RetrieveDocumentItemTracking(TrackingSpecBuffer, "Sales Shipment Header"."No.",
                                    DATABASE::"Sales Shipment Header", 0);
                                ItemTrackingMgt.SetRetrieveAsmItemTracking(FALSE);
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total; integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(BilltoCustNo_SalesShptHeader; "Sales Shipment Header"."Bill-to Customer No.")
                        {
                        }
                        column(CustAddr1; CustAddr[1])
                        {
                        }
                        column(CustAddr2; CustAddr[2])
                        {
                        }
                        column(CustAddr3; CustAddr[3])
                        {
                        }
                        column(CustAddr4; CustAddr[4])
                        {
                        }
                        column(CustAddr5; CustAddr[5])
                        {
                        }
                        column(CustAddr6; CustAddr[6])
                        {
                        }
                        column(CustAddr7; CustAddr[7])
                        {
                        }
                        column(CustAddr8; CustAddr[8])
                        {
                        }
                        column(BilltoAddressCaption; BilltoAddressCaptionLbl)
                        {
                        }
                        column(BilltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Bill-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCustAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(ItemTrackingLine; integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TrackingSpecBufferNo; TrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; TrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; TrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; TrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; TrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NoCaption; NoCaptionLbl)
                        {
                        }
                        dataitem(TotalItemTracking; integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(Quantity1; TotalQty)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TrackingSpecBuffer.FINDSET
                            ELSE
                                TrackingSpecBuffer.NEXT;

                            ShowTotal := FALSE;
                            IF ItemTrackingAppendix.IsStartNewGroup(TrackingSpecBuffer) THEN
                                ShowTotal := TRUE;

                            ShowGroup := FALSE;
                            IF (TrackingSpecBuffer."Source Ref. No." <> OldRefNo) OR
                               (TrackingSpecBuffer."Item No." <> OldNo)
                            THEN BEGIN
                                OldRefNo := TrackingSpecBuffer."Source Ref. No.";
                                OldNo := TrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            END ELSE
                                ShowGroup := TRUE;
                            TotalQty += TrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF TrackingSpecCount = 0 THEN
                                CurrReport.BREAK;
                            CurrReport.NEWPAGE;
                            SETRANGE(Number, 1, TrackingSpecCount);
                            TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        IF ShowLotSN THEN BEGIN
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := FALSE;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END;
                    TotalQty := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        ShptCountPrinted.RUN("Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                lNotifyPartyAPostCode: Record "Post Code";
            begin
                CurrReport.LANGUAGE := Languagerec.GetLanguageID("Language Code");

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                FormatAddr.SalesShptShipTo(ShipToAddr, "Sales Shipment Header");

                FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, "Sales Shipment Header");
                ShowCustAddr := "Bill-to Customer No." <> "Sell-to Customer No.";
                FOR i := 1 TO ARRAYLEN(CustAddr) DO
                    IF CustAddr[i] <> ShipToAddr[i] THEN
                        ShowCustAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                Harbor.RESET;
                NotifyParty.RESET;
                NotifyPartyAdress := '';
                NotifyPartyEmail := '';
                NotifyPartyPhone := '';
                NotifyPartyAdress2 := '';
                NotifyPartyEmail2 := '';
                NotifyPartyPhone2 := '';
                CLEAR(NotifyParty);
                IF Harbor.GET("Sales Shipment Header"."Destination Port") THEN
                    IF "Notify Party 1" = '' THEN BEGIN
                        IF NotifyParty.GET(Harbor."Notify Party", Harbor.Code) THEN BEGIN
                            NotifyPartyAdress := NotifyParty.Adress;
                            NotifyPartyEmail := NotifyParty."E-mail";
                            NotifyPartyPhone := NotifyParty."Phone No.";
                        END;
                    END ELSE BEGIN
                        IF NotifyParty.GET("Notify Party 1", "Destination Port") THEN BEGIN
                            NotifyPartyAdress := NotifyParty.Adress;
                            NotifyPartyEmail := NotifyParty."E-mail";
                            NotifyPartyPhone := NotifyParty."Phone No.";
                            lNotifyPartyAPostCode.RESET;
                            lNotifyPartyAPostCode.SETRANGE(City, NotifyParty.City);
                            IF lNotifyPartyAPostCode.FINDFIRST THEN
                                NotifyPostCode := lNotifyPartyAPostCode.Code;
                        END;
                    END;
                //<<wdc.HG
                NotifyParty2.RESET;
                clear(NotifyParty2);
                IF "Notify Party 2" = '' THEN BEGIN
                    IF NotifyParty2.GET(Harbor."Notify Party", Harbor.Code) THEN BEGIN
                        NotifyPartyAdress2 := NotifyParty2.Adress;
                        NotifyPartyEmail2 := NotifyParty2."E-mail";
                        NotifyPartyPhone2 := NotifyParty2."Phone No.";
                    END;
                END ELSE BEGIN
                    IF NotifyParty2.GET("Notify Party 2", "Destination Port") THEN BEGIN
                        NotifyPartyAdress2 := NotifyParty2.Adress;
                        NotifyPartyEmail2 := NotifyParty2."E-mail";
                        NotifyPartyPhone2 := NotifyParty2."Phone No.";
                        lNotifyPartyAPostCode.RESET;
                        lNotifyPartyAPostCode.SETRANGE(City, NotifyParty2.City);
                        IF lNotifyPartyAPostCode.FINDFIRST THEN
                            NotifyPostCode2 := lNotifyPartyAPostCode.Code;
                    END;
                END;
                ShippingAgent.RESET;
                IF ShippingAgent.GET("Sales Shipment Header"."Shipping Agent Code") THEN;

                ShipAddress.RESET;
                IF ShipAddress.GET("Sell-to Customer No.", "Ship-to Code") THEN;

                CountryRegion.RESET;
                IF CountryRegion.GET("Sales Shipment Header"."Ship-to Country/Region Code") THEN;

                CountryRegion1.RESET;
                IF CountryRegion1.GET("Sales Shipment Header"."Bill-to Country/Region Code") THEN;

                CreateComment;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo5.GET;
                CompanyInfo5.CALCFIELDS(Picture);

                TotalWeight := 0;
                TotalQty2 := 0;
                TotalBox := 0;
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
                    CaptionML = ENU = 'Options', FRA = 'Options', NLD = 'Opties';
                    field(NoOfCopies; NoOfCopies)
                    {
                        CaptionML = ENU = 'No. of Copies', FRA = 'Nombre de copies', NLD = 'Aantal exemplaren';
                        ApplicationArea = all;
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        CaptionML = ENU = 'Show Internal Information', FRA = 'Afficher info. internes', NLD = 'Interne informatie weergeven';
                        ApplicationArea = all;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        CaptionML = ENU = 'Log Interaction', FRA = 'Journal interaction', NLD = 'Interactie registreren';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = all;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        CaptionML = ENU = 'Show Correction Lines', FRA = 'Afficher lignes correction', NLD = 'Correctieregels weergeven';
                        ApplicationArea = all;
                    }
                    field(ShowLotSN; ShowLotSN)
                    {
                        CaptionML = ENU = 'Show Serial/Lot Number Appendix', FRA = 'Afficher annexe numéro série/lot', NLD = 'Bijlage serie-/lotnummers weergeven';
                        ApplicationArea = all;
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
                    {
                        CaptionML = ENU = 'Show Assembly Components', FRA = 'Afficher composants d''assemblage', NLD = 'Assemblagecomponenten weergeven';
                        ApplicationArea = all;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
        Quantity = 'Nett Qtty';
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
        AsmHeaderExists := FALSE;
    end;

    var
        Text000: TextConst ENU = 'Salesperson', FRA = 'Vendeur';
        Text001: TextConst ENU = 'COPY', FRA = 'COPIE';
        Text002: TextConst ENU = 'Packing List', FRA = 'Liste de colisage';
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        CompanyInfo5: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Languagerec: Record Language;
        TrackingSpecBuffer: Record "Tracking Specification" temporary;
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        ShptCountPrinted: Codeunit "Sales Shpt.-Printed";
        SegManagement: Codeunit SegManagement;
        ItemTrackingMgt: Codeunit "Item Tracking Doc. Management";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[20];
        ReferenceText: Text[80];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        OutputNo: Integer;
        NoOfLoops: Integer;
        TrackingSpecCount: Integer;
        OldRefNo: Integer;
        OldNo: Code[20];
        CopyText: Text[30];
        ShowCustAddr: Boolean;
        i: Integer;
        FormatAddr: Codeunit "Format Address";
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        ShowCorrectionLines: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        ShowGroup: Boolean;
        TotalQty: Decimal;
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmHeaderExists: Boolean;
        LinNo: Integer;
        ItemTrackingAppendixCaptionLbl: TextConst ENU = 'Item Tracking - Appendix', FRA = 'Traçabilité - Annexe';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', FRA = 'N° téléphone';
        VATRegNoCaptionLbl: TextConst ENU = 'VAT Reg. No.', FRA = 'N° id. intracomm.';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', FRA = 'N° CCP';
        BankNameCaptionLbl: TextConst ENU = 'Bank', FRA = 'Banque';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', FRA = 'N° compte';
        ShipmentNoCaptionLbl: TextConst ENU = 'Shipment No.', FRA = 'N° expédition';
        ShipmentDateCaptionLbl: TextConst ENU = 'Shipment Date', FRA = 'Date d''expédition';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', FRA = 'Page d''accueil';
        EmailCaptionLbl: TextConst ENU = 'E-Mail', FRA = 'E-Mail';
        DocumentDateCaptionLbl: TextConst ENU = 'Document Date', FRA = 'Date document';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', FRA = 'Analytique en-tête';
        LineDimensionsCaptionLbl: TextConst ENU = 'Line Dimensions', FRA = 'Analytique ligne';
        BilltoAddressCaptionLbl: TextConst ENU = 'Bill-to Address', FRA = 'Adresse facturation';
        QuantityCaptionLbl: TextConst ENU = 'Quantity', FRA = 'Quantité';
        SerialNoCaptionLbl: TextConst ENU = 'Serial No.', FRA = 'N° de série';
        LotNoCaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        NoCaptionLbl: TextConst ENU = 'No.', FRA = 'N°';
        ShptMethodDescCaptionLbl: TextConst ENU = 'Incoterm', NLD = 'Verzendwijze';
        ContainerCaption: TextConst ENU = 'Container No.', FRA = 'N° Conteneur';
        ScelleNoCaption: TextConst ENU = 'Seal No.', FRA = 'N° Scellé';
        TranspNameCaption: TextConst ENU = 'Transporter Name', FRA = 'Nom transporteur';
        PalletNumbCaption: TextConst ENU = 'Pallet Quantity', FRA = 'Nombre de palette';
        BoxNumCaption: TextConst ENU = 'Boxes Quantity', FRA = 'Nombre de carton';
        BoxTypeCaption: TextConst ENU = 'Box Type', FRA = 'Type de carton';
        "--------------------------": Text;
        ShippingAgent: Record "Shipping Agent";
        DestHarborCaption: TextConst ENU = 'Destination Harbor', FRA = 'Port de destination';
        NotifyParty1Caption: TextConst ENU = 'Notify Party 1', FRA = 'à inforPartie mer 1';
        NotifyParty2Caption: TextConst ENU = 'Notify Party 2', FRA = 'Partie à informer 2';
        Harbor: Record "WDC Harbor";
        NotifyParty: Record "WDC Notify Party";
        NotifyParty2: Record "WDC Notify Party";
        ShipAddress: Record "Ship-to Address";
        Packaging: Record "WDC Packaging";
        CountryRegion: Record 9;
        CountryRegion1: Record 9;
        NotifyPartyAdress: Text[50];
        NotifyPartyEmail: Text[50];
        NotifyPartyPhone: Text[30];
        NotifyPartyAdress2: Text[50];
        NotifyPartyEmail2: Text[50];
        NotifyPartyPhone2: Text[30];
        HarmTariffCodeCaption: TextConst ENU = 'Harm. Tariff Code', FRA = 'Code tarifiaire harmonisé';
        ShipAdressCaption: TextConst ENU = 'Ship to Adress', FRA = 'Adresse destinataire';
        NotifyPostCode: Code[30];
        NotifyPostCode2: Code[30];

        TotalWeight: Decimal;
        TotalWeightCaption: TextConst ENU = 'Gross Weight', FRA = 'Poids total';
        FreightPayableCaption: TextConst ENU = 'Freight Payable';
        LosesBoxCaption: TextConst ENU = 'Loose Boxes', FRA = 'Cartons perdues';
        TotalQty2: Decimal;
        TotalBox: Decimal;
        Coment: array[10] of Text;
        PalletDescription: Text;
        UnitMeas: Code[20];
        UniContainer: Code[20];
        TotalWeighttxt: Text[15];
        posit: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        lPAL: Code[10];
        X: Code[10];
        Format2: Code[10];
        Format3: Code[10];
        Format4: Code[10];
        GrossWeightt: Decimal;
        SalesShipmentLine: Record "Sales Shipment Line";
        ProdDate: Text;
        LotNoInformation: Record "Lot No. Information";
        lNo: Code[10];
        ItemNoGrp: Code[20];
        text1: text[10];
        text2: text[10];

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractionTemplateCode(5) <> '';
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record 204;
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    procedure CreateComment()
    var
        lNbLineText: Integer;
        DocumentComment: Record "Sales Comment Line";
    begin
        DocumentComment.SETCURRENTKEY("Document Type", "No.", "Line No.");
        DocumentComment.SETRANGE("Document Type", DocumentComment."Document Type"::Shipment);
        DocumentComment.SETRANGE("Shipment/Receipt", TRUE);
        DocumentComment.SETRANGE("Document Line No.", 0);
        DocumentComment.SETRANGE("No.", "Sales Shipment Header"."No.");
        lNbLineText := 1;
        IF DocumentComment.FINDSET THEN
            REPEAT
                Coment[lNbLineText] := DocumentComment.Comment;
                lNbLineText += 1;
            UNTIL (DocumentComment.NEXT = 0) OR (lNbLineText = 11)
    end;
}

