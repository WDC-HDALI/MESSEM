page 50010 "WDC Purchase Rebates"
{

    CaptionML = ENU = 'Purchase Rebates', FRA = 'Bonus achat';
    DataCaptionExpression = GetCaption;
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "WDC Purchase Rebate";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(PurchaseCodeFilterCtrl; VendorNoFilter)
                {
                    CaptionML = ENU = 'Vendor No Filter', FRA = 'Filtre N° fournisseur';
                    Enabled = PurchaseCodeFilterCtrlEnable;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendorList: Page 27;
                    begin
                        VendorList.LOOKUPMODE := TRUE;
                        IF VendorList.RUNMODAL = ACTION::LookupOK THEN
                            Text := VendorList.GetSelectionFilter
                        ELSE
                            EXIT(FALSE);

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        VendorNoFilterOnAfterValidate;
                    end;
                }
                field(StartingDateFilter; StartingDateFilter)
                {
                    CaptionML = ENU = 'Starting Date Filter', FRA = 'Fitre date début';
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        StartingDateFilterOnAfterValid;
                    end;
                }
                field(CodeFilterCtrl; CodeFilter)
                {
                    CaptionML = ENU = 'Code Filter', FRA = 'Filtre Code';
                    Enabled = CodeFilterCtrlEnable;
                    ApplicationArea = all;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ItemRebateGroup: Record "WDC Item Rebate Group";
                        ItemList: Page 31;
                        ItemRebateGrList: Page "WDC Item Rebate Groups";
                    begin
                        // CASE Rec.Type OF
                        //     Rec.Type::Item:
                        //         BEGIN
                        //             ItemList.LOOKUPMODE := TRUE;
                        //             IF ItemList.RUNMODAL = ACTION::LookupOK THEN
                        //                 Text := ItemList.GetSelectionFilter
                        //             ELSE
                        //                 EXIT(FALSE);
                        //         END;
                        //     Rec.Type::"Item Rebate Group":
                        //         BEGIN
                        //             ItemRebateGrList.LOOKUPMODE := TRUE;
                        //             ItemRebateGrList.SETTABLEVIEW(ItemRebateGroup);
                        //             IF ItemRebateGrList.RUNMODAL = ACTION::LookupOK THEN
                        //                 Text := ItemRebateGrList.GetSelectionFilter
                        //             ELSE
                        //                 EXIT(FALSE);
                        //         END;
                        // END;

                        EXIT(TRUE);
                    end;

                    trigger OnValidate()
                    begin
                        CodeFilterOnAfterValidate;
                    end;
                }
            }
            repeater(Control1)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = "Vendor No.Editable";
                    ApplicationArea = all;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = all;
                }

                field("Rebate Code"; Rec."Rebate Code")
                {
                    ApplicationArea = all;
                }
                field("Accrual Value (LCY)"; Rec."Accrual Value (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Rebate Scale"; Rec."Rebate Scale")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnInit()
    begin
        CodeFilterCtrlEnable := TRUE;
        PurchaseCodeFilterCtrlEnable := TRUE;
        "Vendor No.Editable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF StartingDateFilter <> '' THEN
            Rec."Starting Date" := Rec.GETRANGEMIN(Rec."Starting Date")
        ELSE
            Rec."Starting Date" := WORKDATE();
    end;

    trigger OnOpenPage()
    begin
        GetRecFilters;
        SetRecFilters;
    end;

    var
        Vendor: Record 23;
        Item: Record 27;
        ItemRebateGr: Record "WDC Item Rebate Group";
        VendorNoFilter: Text[250];
        CodeFilter: Text[250];
        StartingDateFilter: Text[30];
        "Vendor No.Editable": Boolean;
        PurchaseCodeFilterCtrlEnable: Boolean;
        CodeFilterCtrlEnable: Boolean;

    procedure GetRecFilters()
    begin
        IF Rec.GETFILTERS <> '' THEN BEGIN
            EVALUATE(StartingDateFilter, Rec.GETFILTER("Starting Date"));

            VendorNoFilter := Rec.GETFILTER("Vendor No.");
            CodeFilter := Rec.GETFILTER(Code);
        END;
    end;

    procedure SetRecFilters()
    begin
        PurchaseCodeFilterCtrlEnable := TRUE;
        CodeFilterCtrlEnable := TRUE;

        IF VendorNoFilter <> '' THEN
            Rec.SETFILTER("Vendor No.", VendorNoFilter)
        ELSE
            Rec.SETRANGE("Vendor No.");

        IF StartingDateFilter <> '' THEN
            Rec.SETFILTER("Starting Date", StartingDateFilter)
        ELSE
            Rec.SETRANGE("Starting Date");

        IF CodeFilter <> '' THEN BEGIN
            Rec.SETFILTER(Code, CodeFilter);
        END ELSE
            Rec.SETRANGE(Code);

        CurrPage.UPDATE(FALSE);
    end;

    procedure GetCaption(): Text[250]
    var
        ObjTransl: Record 377;
        SourceTableName: Text[100];
        PurchaseSrcTableName: Text[100];
        Description: Text[250];
    begin
        GetRecFilters;
        "Vendor No.Editable" := TRUE;

        SourceTableName := '';


        PurchaseSrcTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
        Vendor."No." := VendorNoFilter;
        IF Vendor.FIND THEN
            Description := Vendor.Name;

        EXIT(STRSUBSTNO('%1 %2 %3 %4 %5', PurchaseSrcTableName, VendorNoFilter, Description, SourceTableName, CodeFilter));
    end;

    procedure SetParameters(CodeFilter2: Code[20])
    begin
        CodeFilter := CodeFilter2;
    end;

    local procedure VendorNoFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure ItemTypeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        CodeFilter := '';
        SetRecFilters;
    end;

    local procedure CodeFilterOnAfterValidate()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure StartingDateFilterOnAfterValid()
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;
}

