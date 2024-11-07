report 50507 "WDC-QA Lot Information"
{
    CaptionML = ENU = 'Lot Information', FRA = 'Information lot';
    RDLCLayout = './.vscode/src_QA/Report/RDLC/LotInformation.rdlc';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ApplicationArea = All;

    dataset
    {
        dataitem("Lot No. Information"; "Lot No. Information")
        {
            DataItemTableView = SORTING("Item No.", "Lot No.");
            RequestFilterFields = "Item No.", "Lot No.", "Item Category Code", "Inspection Status", QC;
            column(Lot_information_Caption; Lot_information_CaptionLbl)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(Item_Caption; Item_CaptionLbl)
            {
            }
            column(Lot_No_Information__Item_No; "Item No.")
            {
            }
            column(Lot_No_Information__Description; Description)
            {
            }
            column(Lot_No_Information__Variant_Code_Caption; FIELDCAPTION("Variant Code"))
            {
            }
            column(Lot_No_Information__Variant_Code; "Variant Code")
            {
            }
            column(Lot_No_Caption; Lot_No_CaptionLbl)
            {
            }
            column(Lot_No_Information__Lot_No; "Lot No.")
            {
            }
            column(Inspection_status_Caption; Inspection_status_CaptionLbl)
            {
            }
            column(Lot_No_Information__Inspection_Status; "Inspection Status")
            {
            }
            column(Vendor_Lot_No_Caption; Vendor_Lot_No_CaptionLbl)
            {
            }
            column(Lot_No_Information__Vendor_Lot_No; "Vendor Lot No.")
            {
            }
            column(Certificate_Number_Caption; Certificate_Number_CaptionLbl)
            {
            }
            column(Lot_No_Information__Certificate_Number; "Certificate Number")
            {
            }
            column(Customer_Caption; Customer_CaptionLbl)
            {
            }
            column(Blocked_Caption; Blocked_CaptionLbl)
            {
            }
            column(Lot_No__Information_Blocked; Blocked)
            {
            }
            column(Available_Caption; Available_CaptionLbl)
            {
            }
            //column(Lot_No_Information__Available_for_Customer; "Available for Customer")
            //{
            //}
            column(Specific_Exp_Date_Caption; Specific_Exp_Date_CaptionLbl)
            {
            }
            //column(Lot_No_Information__Sales_Expiration_date; "Sales Expiration date")
            //{
            //}
            column(Date_2nd_Inspection_Date_Caption; Date_2nd_Inspection_Date_CaptionLbl)
            {
            }
            column(Lot_No_Information__Next_Inspection_Status; "Next Inspection Status")
            {
            }
            column(Second_Inspection_Status_Caption; Second_Inspection_Status_CaptionLbl)
            {
            }
            column(Lot_No_Information__Date_Second_Inspection_Status; "Date Second Inspection Status")
            {
            }
            column(Warranty_Date_Caption; Warranty_Date_CaptionLbl)
            {
            }
            column(Lot_No_Information__Warranty_Date; "Warranty Date")
            {
            }
            column(Expiration_Date_Caption; Expiration_Date_CaptionLbl)
            {
            }
            column(Lot_No_Information__Expiration_Date; "Expiration Date")
            {
            }
            column(Age_days_Caption; Age_days_CaptionLbl)
            {
            }
            column(Lot_No_Information__Age_days; "Age (days)")
            {
            }
            column(Days_until_Expiration_Caption; Days_until_Expiration_CaptionLbl)
            {
            }
            column(Lot_No_Information__Days_until_Expiration; "Days until Expiration")
            {
            }
            column(Inventory_Caption; Inventory_CaptionLbl)
            {
            }
            column(Lot_No_Information__Inventory; Inventory)
            {
            }
            column(True_Caption; True_CaptionLbl)
            {
            }
            column(False_Caption; False_CaptionLbl)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Lot_information_CaptionLbl: TextConst ENU = 'Lot information', FRA = 'Information lot';
        Page_CaptionLbl: TextConst ENU = 'Page', FRA = 'Page';
        Item_CaptionLbl: TextConst ENU = 'Item', FRA = 'Article';
        Lot_No_CaptionLbl: TextConst ENU = 'Lot No.', FRA = 'N° lot';
        Inspection_status_CaptionLbl: Label 'Inspection status';
        Vendor_Lot_No_CaptionLbl: Label 'Vendor Lot No.';
        Certificate_Number_CaptionLbl: Label 'Certificate Number';
        Blocked_CaptionLbl: Label 'Blocked';
        Available_CaptionLbl: Label 'Available';
        Specific_Exp_Date_CaptionLbl: Label 'Specific Exp. Date';
        Second_Inspection_Status_CaptionLbl: Label 'Second Inspection Status';
        Date_2nd_Inspection_Date_CaptionLbl: Label 'Date 2nd Inspection Date';
        Warranty_Date_CaptionLbl: Label 'Warranty Date';
        Expiration_Date_CaptionLbl: Label 'Expiration Date';
        Age_days_CaptionLbl: Label 'Age (days)';
        Days_until_Expiration_CaptionLbl: Label 'Days until Expiration';
        Inventory_CaptionLbl: Label 'Inventory';
        Customer_CaptionLbl: Label 'Customer';
        True_CaptionLbl: Label 'Yes';
        False_CaptionLbl: Label 'No';
}

