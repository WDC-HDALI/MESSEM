namespace MESSEM.MESSEM;

using Microsoft.Foundation.Shipping;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;

tableextension 50035 "WDCShipping Agent" extends "Shipping Agent"
{
    fields
    {
        field(50000; "Vendor No."; Code[20])
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            TableRelation = Vendor WHERE(Transporter = CONST(true));
        }
        field(50001; "Customer No."; Code[20])
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
            TableRelation = Customer;
        }

    }
}
