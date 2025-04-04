report 50860 "WDC-ED Payment List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_ED/report/RDLC/PaymentList.rdlc';
    captionML = ENU = 'Payment List', FRA = 'Liste règlement';

    dataset
    {
        dataitem("Payment Line"; "WDC-ED Payment Line")
        {
            DataItemTableView = SORTING("No.", "Line No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Payment lines';
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Payment_Line__No__; "No.")
            {
            }
            column(Payment_Line__No___Control1120011; "No.")
            {
            }
            column(Payment_Line_Amount; Amount)
            {
            }
            column(Payment_Line__Account_Type_; "Account Type")
            {
            }
            column(Payment_Line__Account_No__; "Account No.")
            {
            }
            column(Payment_Line__Posting_Group_; "Posting Group")
            {
            }
            column(Payment_Line__Due_Date_; Format("Due Date"))
            {
            }
            column(Payment_Line_Line_No_; "Line No.")
            {
            }
            column(Payments_LinesCaption; Payments_LinesCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payment_Line__No___Control1120011Caption; FieldCaption("No."))
            {
            }
            column(Payment_Line_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Payment_Line__Account_Type_Caption; FieldCaption("Account Type"))
            {
            }
            column(Payment_Line__Account_No__Caption; FieldCaption("Account No."))
            {
            }
            column(Payment_Line__Posting_Group_Caption; FieldCaption("Posting Group"))
            {
            }
            column(Payment_Line__Due_Date_Caption; Payment_Line__Due_Date_CaptionLbl)
            {
            }
            column(Payment_Line__No__Caption; FieldCaption("No."))
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
        Payments_LinesCaptionLbl: TextConst ENU = 'Payments Lines',
                                            FRA = 'Lignes paiement';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page',
                                               FRA = 'Page';
        Payment_Line__Due_Date_CaptionLbl: TextConst ENU = 'Due Date',
                                                     FRA = 'Date d''échéance';
}

