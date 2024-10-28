report 50502 "WDC-QA Formlulaire Spécificati"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Formlulaire Spécification CQ', FRA = 'Formlulaire Spécification CQ';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './.vscode/src/Report/RDLC/FormlulaireSpécification.rdl.rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(WDCQASpecificationHeader; "WDC-QA Specification Header")
        {
            DataItemTableView = SORTING("Document Type", "No.", "Version No.");
            RequestFilterFields = "No.";
            column(CompanyPicture; Company.Picture)
            { }
            column(No; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemCategory; "Item Category Code")
            {
            }
            column(ItemDescription; "Item Description")
            { }
            column(VersionNo; "Version No.")
            {
            }
            column(VersionDate; "Version Date")
            {
            }
            column(RevisedBy; RevisedBy)
            { }
            column(Frequence; Frequence)
            { }
            column(Item_QtyPerShipmentUnit; Item."Qty. per Shipment Unit")
            { }
            column(Packaging_Description; Packaging.Description)
            { }
            column(Sampling_frequency; SH_frequency)
            { }
            column(SH_frequencyText; SH_frequencyText)
            { }
            dataitem(WDCQASpecificationLine; "WDC-QA Specification Line")
            {
                DataItemLink = "Document No." = FIELD("No."), "Document Type" = FIELD("Document Type"), "Version No." = FIELD("Version No.");
                DataItemTableView = WHERE(Imprimable = FILTER(true));
                column(ParameterCode; "Parameter Code")
                { }
                column(ParameterDescription; "Parameter Description")
                { }
                column(LowerLimit; "Lower Limit")
                { }
                column(UpperLimit; "Upper Limit")
                { }
                column(UnitMeas; UnitMeas)
                { }
                column(ResulLimit; ResulLimit)
                { }
                column(UnitMeasDescp; UnitofMeasure.Description)
                { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF (rType = rType::"P.F") AND (WDCQASpecificationLine.Type = WDCQASpecificationLine.Type::"P.S.F") THEN
                        CurrReport.SKIP
                    ELSE IF (rType = rType::"P.S.F") AND (WDCQASpecificationLine.Type = WDCQASpecificationLine.Type::"P.F") THEN
                        CurrReport.SKIP;

                    RecGMethod.RESET;
                    IF RecGMethod.GET("Method No.") THEN
                        UnitMeas := RecGMethod."Result UOM";
                    IF UnitofMeasure.GET(UnitMeas) THEN;


                    IF WDCQASpecificationLine."Type of Result" = 1 THEN BEGIN
                        ResulLimit := 'OK';

                    END ELSE BEGIN
                        IF ("Lower Limit" <> 0) AND ("Upper Limit" <> 0) THEN ResulLimit := FORMAT("Lower Limit") + '  -  ' + FORMAT("Upper Limit");
                        IF ("Lower Limit" <> 0) AND ("Upper Limit" = 0) THEN ResulLimit := ' > ' + FORMAT("Lower Limit");
                        IF ("Lower Limit" = 0) AND ("Upper Limit" <> 0) THEN ResulLimit := ' < ' + FORMAT("Upper Limit");
                        IF ("Lower Limit" = 0) AND ("Upper Limit" = 0) THEN ResulLimit := FORMAT("Upper Limit");
                        IF ("Lower Limit" = 0) AND ("Upper Limit" = 0) THEN ResulLimit := FORMAT("Upper Limit");
                    END;

                    IF (UnitofMeasure.Code <> '°C') AND (WDCQASpecificationLine."Parameter Code" <> 'TARE EMB')
                      AND (WDCQASpecificationLine."Parameter Code" <> 'CALIB-BAL')
                      AND (WDCQASpecificationLine."Parameter Code" <> 'CALIB-BAL10')
                      THEN BEGIN

                        IF ("Lower Limit" <> 0) AND ("Upper Limit" <> 0) THEN ResulLimit := FORMAT("Lower Limit" * SH_frequency) + '  -  ' + FORMAT("Upper Limit" * SH_frequency);
                        IF ("Lower Limit" <> 0) AND ("Upper Limit" = 0) THEN ResulLimit := ' > ' + FORMAT("Lower Limit" * SH_frequency);
                        IF ("Lower Limit" = 0) AND ("Upper Limit" <> 0) THEN ResulLimit := ' < ' + FORMAT("Upper Limit" * SH_frequency);
                        IF ("Lower Limit" = 0) AND ("Upper Limit" = 0) THEN ResulLimit := FORMAT("Upper Limit" * SH_frequency);
                        IF UnitofMeasure.Code = '%' THEN
                            UnitofMeasure.Description := '';
                    END;
                    IF (WDCQASpecificationLine."Parameter Group Code" = 'ORGANO') OR (WDCQASpecificationLine."Parameter Code" = 'WRAPPING/ PALLET') OR (WDCQASpecificationLine."Parameter Code" = 'LABEL') THEN BEGIN
                        UnitofMeasure.Description := 'C';
                        IF ResulLimit = '0' THEN
                            ResulLimit := '';
                    END;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                pos := STRPOS(WDCQASpecificationHeader."Revised By", '\');
                IF pos <> 0 THEN
                    RevisedBy := COPYSTR(WDCQASpecificationHeader."Revised By", pos + 1)
                ELSE
                    RevisedBy := WDCQASpecificationHeader."Revised By";
                IF Item.GET(WDCQASpecificationHeader."Item No.") THEN
                    IF Packaging.GET(Item."Shipment Container") THEN;

                IF (rType = rType::"P.S.F") THEN
                    SH_frequency := WDCQASpecificationHeader."Sampling frequency PSF"
                ELSE
                    SH_frequency := WDCQASpecificationHeader."Sampling frequency PF";

                IF SH_frequency = 2 THEN
                    SH_frequencyText := Text002
                ELSE IF SH_frequency = 20 THEN
                    SH_frequencyText := Text003;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = FRA = 'Options';
                    field(Frequence; Frequence)
                    {
                        CaptionML = ENU = 'Frequence', FRA = 'Fréquence';
                    }
                    field(rType; rType)
                    {
                        CaptionML = ENU = 'Type', FRA = 'Type';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
        trigger OnInit()
        var
            myInt: Integer;
        begin
            Frequence := Text001;
        end;
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Company.GET;
        Company.CALCFIELDS(Picture);
    end;

    var
        RecGMethod: Record "WDC-QA Method Header";
        UnitMeas: Code[10];
        Company: Record "Company Information";
        ResulLimit: Text[50];
        Frequence: Text[250];
        UnitofMeasure: Record "Unit of Measure";
        rType: Option "P.F/P.S.F","P.F","P.S.F";
        pos: Integer;
        RevisedBy: Text;
        Item: Record Item;
        Packaging: Record "WDC Packaging";
        SH_frequency: Decimal;
        SH_frequencyText: Text;
        Text001: TextConst ENU = '', FRA = 'Fréquence d''échantillonnage: (Soit un carton chaque 2 palette)';
        Text002: TextConst ENU = '', FRA = '2kg chaque 30min';
        Text003: TextConst ENU = '', FRA = '20kg chaque 2 palettes';
}
