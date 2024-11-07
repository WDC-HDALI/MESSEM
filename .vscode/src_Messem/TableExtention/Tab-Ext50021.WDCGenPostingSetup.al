namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Account;

tableextension 50021 "WDC Gen Posting Setup " extends "General Posting Setup"
{
    fields
    {
        field(50000; "Purchase Rebate Account"; Code[20])
        {
            CaptionML = ENU = '"Purchase Rebate Account"', FRA = 'Compte d''achats bonus';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" WHERE("Rebate G/L Account" = CONST(true));
        }

    }
}
