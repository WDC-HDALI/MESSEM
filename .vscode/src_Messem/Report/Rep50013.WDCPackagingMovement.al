report 50013 "WDC Packaging Movement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/PackagingMovement.rdlc';

    CaptionML = ENU = 'Packaging Movement', FRA = 'Mouvement de caisse';

    dataset
    {
        dataitem("Item Journal Batch"; "Item Journal Batch")
        {
            DataItemTableView = SORTING("Journal Template Name", "Name");
            column(JournalTempName_ItemJournalBatch; "Journal Template Name")
            {
            }
            column(Name_ItemJournalBatch; Name)
            {
            }
            column(InventoryMovementCaption; InventoryMovementCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(JournalTempNameFieldCaption; "Item Journal Line".FIELDCAPTION("Journal Template Name"))
            {
            }
            column(JournalBatchNameFieldCaption; "Item Journal Line".FIELDCAPTION("Journal Batch Name"))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(Time; TIME)
            {
            }
            dataitem("Item Journal Line"; "Item Journal Line")
            {
                DataItemLink = "Journal Template Name" = FIELD("Journal Template Name"),
                               "Journal Batch Name" = FIELD(Name);
                RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Location Code", "Bin Code", "Item No.", "Variant Code";
                column(JournalTempName_ItemJournalLine; "Journal Template Name")
                {
                }
                column(JournalBatchName_ItemJournalLine; "Journal Batch Name")
                {
                }
                column(ActivityType; ActivityType)
                {
                    OptionCaption = ' ,Put-away,Pick,Movement';
                }
                column(ItemJnlLineActTypeShowOutput; ActivityType <> ActivityType::" ")
                {
                }
                column(ItemJournalLineTableCaption; TABLECAPTION + ': ' + ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineFilter; ItemJnlLineFilter)
                {
                }
                column(ItemJnlLineHeader1ShowOutput; ItemJnlTemplate.Type IN [ItemJnlTemplate.Type::Item, ItemJnlTemplate.Type::Consumption, ItemJnlTemplate.Type::Output, ItemJnlTemplate.Type::"Prod. Order"])
                {
                }
                column(ItemJnlLineHeader2ShowOutput; ItemJnlTemplate.Type = ItemJnlTemplate.Type::Transfer)
                {
                }
                column(UOM_ItemJournalLine; "Unit of Measure Code")
                {
                }
                column(Qty_ItemJournalLine; Quantity)
                {
                }
                column(BinCode_ItemJournalLine; "Bin Code")
                {
                }
                column(LocationCode_ItemJournalLine; "Location Code")
                {
                }
                column(VariantCode_ItemJournalLine; "Variant Code")
                {
                }
                column(Description_ItemJournalLine; Description)
                {
                }
                column(ItemNo_ItemJournalLine; "Item No.")
                {
                }
                column(PostingDate_ItemJournalLine; FORMAT("Posting Date"))
                {
                }
                column(EntryType_ItemJournalLine; "Entry Type")
                {
                }
                column(QuantityBase_ItemJournalLine; "Quantity (Base)")
                {
                }
                column(QuantityFormat; Quantity)
                {
                }
                column(NewBinCode_ItemJournalLine; "New Bin Code")
                {
                }
                column(NewLocationCode_ItemJournalLine; "New Location Code")
                {
                }
                column(QuantityBaseFormat; "Quantity (Base)")
                {
                }
                column(SourceType; "Source Type")
                {
                }
                column(SourceNo; "Source No.")
                {
                }
                column(RecVendor_Name; RecVendor.Name)
                {
                }
                column(ActivityTypeCaption; ActivityTypeCaptionLbl)
                {
                }
                column(UOMFieldCaption; FIELDCAPTION("Unit of Measure Code"))
                {
                }
                column(QtyFieldCaption; FIELDCAPTION(Quantity))
                {
                }
                column(BinCodeFieldCaption; FIELDCAPTION("Bin Code"))
                {
                }
                column(LocationCodeFieldCaption; FIELDCAPTION("Location Code"))
                {
                }
                column(VariantCodeFieldCaption; FIELDCAPTION("Variant Code"))
                {
                }
                column(DescriptionFieldCaption; FIELDCAPTION(Description))
                {
                }
                column(ItemNoFieldCaption; FIELDCAPTION("Item No."))
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(EntryTypeFieldCaption; FIELDCAPTION("Entry Type"))
                {
                }
                column(QuantityBaseFieldCaption; FIELDCAPTION("Quantity (Base)"))
                {
                }
                column(NewBinCodeFieldCaption; FIELDCAPTION("New Bin Code"))
                {
                }
                column(NewLocationCodeFieldCaption; FIELDCAPTION("New Location Code"))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF ("Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::Purchase, "Entry Type"::Output]) AND
                       (Quantity > 0) AND
                       (ActivityType IN [ActivityType::Pick, ActivityType::Movement])
                    THEN
                        CurrReport.SKIP;

                    IF ("Entry Type" IN ["Entry Type"::"Negative Adjmt.", "Entry Type"::Sale, "Entry Type"::Consumption]) AND
                       (Quantity < 0) AND
                       (ActivityType IN [ActivityType::Pick, ActivityType::Movement])
                    THEN
                        CurrReport.SKIP;

                    IF ("Entry Type" IN ["Entry Type"::"Positive Adjmt.", "Entry Type"::Purchase, "Entry Type"::Output]) AND
                       (Quantity < 0) AND
                       (ActivityType IN [ActivityType::"Put-away", ActivityType::Movement])
                    THEN
                        CurrReport.SKIP;

                    IF ("Entry Type" IN ["Entry Type"::"Negative Adjmt.", "Entry Type"::Sale, "Entry Type"::Consumption]) AND
                       (Quantity > 0) AND
                       (ActivityType IN [ActivityType::"Put-away", ActivityType::Movement])
                    THEN
                        CurrReport.SKIP;

                    IF ("Entry Type" <> "Entry Type"::Transfer) AND
                       (ActivityType = ActivityType::Movement)
                    THEN
                        CurrReport.SKIP;

                    IF ("Source Type" = "Item Journal Line"."Source Type"::Vendor) AND ("Source No." <> '') THEN BEGIN
                        RecVendor.RESET;
                        RecVendor.GET("Source No.");
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    ItemJnlTemplate.GET("Item Journal Batch"."Journal Template Name");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.PAGENO := 1;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
    }
    trigger OnPreReport()
    begin
        ItemJnlLineFilter := "Item Journal Line".GETFILTERS;
    end;

    var
        ItemJnlTemplate: Record "Item Journal Template";
        RecVendor: Record Vendor;
        ItemJnlLineFilter: Text[250];
        ActivityType: Option " ","Put-away",Pick,Movement;
        InventoryMovementCaptionLbl: TextConst ENU = 'Packaging Movement', FRA = 'Mouvement des caisses';
        PageCaptionLbl: TextConst ENU = 'Page', FRA = 'page';
        ActivityTypeCaptionLbl: TextConst ENU = 'Activity Type', FRA = 'Type activité';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', FRA = 'Date comptabilistion';

    procedure InitializeRequest(NewActivityType: Option)
    begin
        ActivityType := NewActivityType;
    end;
}

