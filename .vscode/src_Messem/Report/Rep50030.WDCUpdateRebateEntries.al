//********************Documentation*************************
//WDC01  10/06/2025  HD  : Create current object 
report 50030 "WDC Update Rebate Entries"
{
    CaptionML = ENU = 'Update Rebate Entries', FRA = 'MAJ écritures bonus';
    UseRequestPage = true;
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Administration;
    Permissions = TableData 32 = rimd,
                  TableData 5802 = rimd,
                  TableData 50009 = rimd;


    dataset
    {
        dataitem("WDC Rebate Entry"; "WDC Rebate Entry")
        {
            trigger OnAfterGetRecord()
            begin
                "WDC Rebate Entry"."Accrual Value (LCY)" := NewUnitRebateValue;
                "WDC Rebate Entry"."Accrual Amount (LCY)" := "WDC Rebate Entry"."Base Quantity" * NewUnitRebateValue;
                "WDC Rebate Entry".Modify();
            end;

            trigger OnPreDataItem()
            begin
                IF VendorNo = '' THEN
                    ERROR(Err003);
                "WDC Rebate Entry".SetRange("Vendor No.", VendorNo);
                "WDC Rebate Entry".Setfilter("Posting Date", '%1..%2', 20260101D, 20260610D);
            end;
        }
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Document Type", "Document Line No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            Var
                lValueEntries: Record "Value Entry";
            begin
                lValueEntries.Reset();
                lValueEntries.SetCurrentKey("Item Ledger Entry No.", "Valuation Date", "Posting Date");
                lValueEntries.SetRange("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                lValueEntries.Setfilter("Rebate Accrual Amount (LCY)", '<>%1', 0);
                if lValueEntries.FindFirst() then
                    repeat
                        lValueEntries."Rebate Accrual Amount (LCY)" := lValueEntries."Valued Quantity" * NewUnitRebateValue;
                        lValueEntries.Modify();
                    until lValueEntries.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                IF VendorNo = '' THEN
                    ERROR(Err003);
                if NewUnitRebateValue = 0 then begin
                    if not Confirm(Text002) then
                        Error(Text003);
                end;
                "Item Ledger Entry".SetRange("Source No.", VendorNo);
                "Item Ledger Entry".SetRange("Entry Type", "Item Ledger Entry"."Entry Type"::Purchase);
                "Item Ledger Entry".SetFilter("Item No.", '10*');
                "Item Ledger Entry".Setfilter("Rebate Accrual Amount (LCY)", '<>%1', 0);
                "Item Ledger Entry".Setfilter("Posting Date", '%1..%2', 20260101D, 20260610D);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field("N° fournisseur"; VendorNo)
                {
                    TableRelation = Vendor;
                    ApplicationArea = all;
                    CaptionML = FRA = 'N° fournisseur', ENU = 'Vendor No.';
                }
                field(NewUnitRebateValue; NewUnitRebateValue)
                {
                    ApplicationArea = all;
                    CaptionML = FRA = 'New Rebate Value', ENU = 'Nouvelle valeur bonus';
                }
            }
        }

    }

    trigger OnPostReport()
    begin
        MESSAGE(Text001);
    end;



    var
        NewUnitRebateValue: Decimal;
        VendorNo: Code[20];
        Err003: TextConst FRA = 'Code fournisseur est Obligatoire!!!',
                          ENU = 'Vendor No. is mandatory!!!';
        Text001: TextConst FRA = 'Les écritures ont changé avec succés!!',
                           ENU = 'Entries has been successfully changed!!';
        Text002: TextConst FRA = 'La nouvelle valeur est 0, voulez-vous contunier?',
                           ENU = 'The new value equal 0 ,do you want to continue?';
        Text003: TextConst FRA = 'Opération annulée',
                           ENU = 'Opération canceled';
}

