report 50500 "WDC-QA Products Specifications"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Product Specification', FRA = 'Production spécifique';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_QA/Report/RDLC/ProductsSpecifications.rdlc';
    dataset
    {
        dataitem("Specification Header"; "WDC-QA Specification Header")
        {
            RequestFilterFields = "No.";
            column(Picture; Gcompany.Picture)
            {
            }
            column(Type; "Specification Header"."Document Type")
            {
            }
            column("Numéro"; "Specification Header"."No.")
            {
            }
            column(DateVersion; "Specification Header"."Version Date")
            {
            }
            column(ItemNo; "Specification Header"."Item No.")
            {
            }
            column(ItemDescription; "Specification Header"."Item Description")
            {
            }
            column(ItemDescription2; "Specification Header"."Item Description2")
            {
            }
            column(VesionNo; "Specification Header"."Version No.")
            {
            }
            column(DescriptItem; DescriptItem)
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
            column(Period; Period)
            {
            }
            column(PalletisationValue; PalletisationValue)
            {
            }
            dataitem("Specification Line"; "WDC-QA Specification Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No."),
                               "Version No." = FIELD("Version No.");
                DataItemTableView = WHERE(Imprimable = FILTER(Oui));
                column(DescriptionParameter; "Specification Line"."Parameter Description")
                {
                }
                column(GroupeParameter; "Specification Line"."Parameter Group Code")
                {
                }
                column(DescriptionGroup; DescriptionGroupe)
                {
                }
                column(Methode; "Specification Line"."Method Description")
                {
                }
                column(TypeofResult; "Specification Line"."Type of Result")
                {
                }
                column(LowerLimit; "Specification Line"."Lower Limit")
                {
                }
                column(UpperLimit; "Specification Line"."Upper Limit")
                {
                }
                column(ResultUOM; Uniteoption)
                {
                }
                column(TextOption; "Specification Line"."Texte specification option")
                {
                }
                column(PhysicDescrip; PhysicDecript)
                {
                }
                column(ChemiscalDescrip; ChimicalDescrp)
                {
                }
                column(ResulLimit; ResulLimit)
                {
                }
                column(UnitDesc; UnitOfMesure.Description)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Parameter.GET("Parameter Group Code") THEN
                        DescriptionGroupe := Parameter.Description
                    ELSE
                        DescriptionGroupe := '';
                    Uniteoption := "Result UOM";

                    IF UnitOfMesure.GET(Uniteoption) THEN;
                    IF "Specification Line"."Type of Result" = 1 THEN BEGIN
                        ResulLimit := "Specification Line"."Texte specification option";

                    END ELSE BEGIN
                        IF "Specification Line"."Texte specification option" <> '' THEN BEGIN
                            ResulLimit := "Specification Line"."Texte specification option";
                        END ELSE BEGIN
                            IF ("Lower Limit" <> 0) AND ("Upper Limit" <> 0) THEN ResulLimit := FORMAT("Lower Limit") + '  -  ' + FORMAT("Upper Limit");
                            IF ("Lower Limit" <> 0) AND ("Upper Limit" = 0) THEN ResulLimit := ' >= ' + FORMAT("Lower Limit");
                            IF ("Lower Limit" = 0) AND ("Upper Limit" <> 0) THEN ResulLimit := ' <= ' + FORMAT("Upper Limit");
                            IF ("Lower Limit" = 0) AND ("Upper Limit" = 0) THEN ResulLimit := FORMAT("Upper Limit");
                            IF ("Lower Limit" = 0) AND ("Upper Limit" = 0) THEN ResulLimit := FORMAT("Upper Limit");
                        END;
                    END;
                end;
            }
            dataitem(DataItem1100281018; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    ORDER(Ascending)
                                    WHERE(Number = FILTER(0 .. 1));
                column(Number; Number)
                {
                }
                column(Description; Description)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CASE Number OF
                        0:
                            Description := Text001;
                        1:
                            Description := Text002;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Item.RESET;
                Item.SETCURRENTKEY("No.");
                IF Item.GET("Item No.") THEN;

                Packaging.RESET;
                Packaging.SETRANGE(code, Item."Shipment Unit");
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

                PalletisationValue := Item."Qty. per Shipment Unit" * Item."Shipm.Units per Shipm.Containr";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Process Decription"; PhysicDecript)
                {
                    ApplicationArea = all;
                    MultiLine = false;
                    StyleExpr = TRUE;
                    CaptionML = ENU = 'Process Decription', FRA = 'Process Décription';
                }
                field("Chemical Standard"; ChimicalDescrp)
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    CaptionML = ENU = 'Chemical Standard', FRA = 'Chemical Standard';
                }
                field("Item Description"; DescriptItem)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = TRUE;
                    CaptionML = ENU = 'Item Description', FRA = 'Déscription Article';
                }
                field(Palletisation; Palletisation)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Palletisation', FRA = 'Palletisation';
                }
                field(PackagingText; PackagingText)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Packaging', FRA = 'Emballage';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Period; Period)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Period', FRA = 'Période';
                }
            }
        }

        trigger OnOpenPage()
        begin
            //PhysicDecript:=Text001;
            //ChimicalDescrp:=Text002;


            DescriptItem := '';
            Palletisation := 0;
            PackagingText := Text007;
            Period := 24;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Gcompany.GET;
        Gcompany.CALCFIELDS(Picture);
        //Gcompany.CALCFIELDS(Image);
    end;

    procedure SetValues(pPhysiclDesc: Text[250]; pChimicalDescrp: Text[250])
    begin
        PhysicDecript := pPhysiclDesc;
        ChimicalDescrp := pChimicalDescrp;
    end;

    var
        Gcompany: Record "Company Information";
        Parameter: Record "WDC-QA Parameter Group";
        ParameterCode: Record "WDC-QA Parameter Group";
        Item: Record Item;
        Packaging: Record "WDC Packaging";
        UnitOfMesure: Record "Unit of Measure";

        Text001: Label 'Sound and mature strawberries (fragaria sp.), wich have been picked in plastic crates,calices removed,cut into halves,inspected,washed with chlorinated water,inspected,individually quick frozen,inspected,packed and metal detected.';
        Text002: Label 'Residues of pesticides : in compliance with EU legislation (Messem Agronomical framework 031)';
        Text003: Label 'IQF Diced Strawberries, 10x10mm';
        Text005: Label '%1 %2';
        Text006: Label '%1 %2';
        Text007: Label 'kg bag-in-box';
        Text008: Label 'MMMM dd, YYYY';
        Description: Text[250];
        Uniteoption: Text[30];
        ResulLimit: Text[50];
        DescriptionGroupe: Text[30];
        PhysicDecript: Text[1024];
        ChimicalDescrp: Text[1024];
        DescriptItem: Text[1024];
        PackagingText: Text[30];
        ShipContainer: Text[100];
        QtyPerShipmentUnit: Text[100];
        ShipmUnitsPerShipContainer: Text[100];
        ParamGroupOrder: Integer;
        Palletisation: Integer;
        Period: Integer;
        PalletisationValue: Decimal;
}

