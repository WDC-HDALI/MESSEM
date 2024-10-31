namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Account;

tableextension 50021 "WDC Gen Posting Setup " extends "General Posting Setup"
{
    fields
    {
        field(50000; "Bonus Purchase Account"; Code[20])
        {
            CaptionML = ENU = 'Bonus Purchase Account', FRA = 'Compte d''achats bonus';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
