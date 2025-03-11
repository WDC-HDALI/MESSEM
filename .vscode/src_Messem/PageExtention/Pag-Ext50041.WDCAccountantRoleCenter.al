namespace MESSEM.MESSEM;

using Microsoft.Finance.RoleCenters;

pageextension 50041 "WDC Accountant Role Center" extends "Accountant Role Center"
{
    actions
    {
        addlast(reporting)
        {
            action("Payments Deadline")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Payments Deadline', FRA = 'Délai des paiments';
                Image = "Report";
                RunObject = Report "WDC Payments Deadline";
            }

        }
        addlast("VAT Reports")
        {
            action("MM VAT Return")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'MM VAT Return', FRA = 'MM Déclaration TVA';
                Image = "Report";
                RunObject = Report "WDC MM VAT Return";
            }
        }
        addlast("Customers and Vendors")
        {
            action(CustomerBalancetoDate)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Customer - Balance to Date', FRA = 'Clients : Ecritures ouvertes';
                Image = "Report";
                RunObject = Report "WDC CustBal toDate inclComm";
            }
            action("VendorBalancetoDate")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Vendor - Balance to Date', FRA = 'Fourn. : Détail écr. ouvertes';
                Image = "Report";
                RunObject = Report "WDC VendBal toDate inclComm.";
            }
        }
    }
}
