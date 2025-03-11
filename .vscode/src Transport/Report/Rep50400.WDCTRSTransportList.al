namespace MESSEM.MESSEM;
using Microsoft.Foundation.Company;

report 50400 "WDC -TRS Transport List"
{
    ApplicationArea = All;
    RDLCLayout = './.vscode/Src Transport/Report/RDLC/TransportList.rdlc';
    CaptionML = ENU = 'Vendor Transport List', FRA = 'Liste transport par fournisseur';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(WDCTRSTrasportOrderHeader; "WDC-TRS Trasport Order Header")
        {
            RequestFilterFields = "Vendor No.", "Posting Date", "Transport Type", "Transport To";

            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(No; "No.")
            {
            }
            column(OriginOrderNo; "Origin Order No.")
            {
            }
            column(PurchaseOrderNo; "Purchase Order No.")
            {
            }
            column(Purchase_Receip_No_; "Purchase Receip No.")
            {
            }
            column(External_Doc_No_; "External Doc No.")
            {
            }
            column(ShipmentMethodcode; "Shipment Method code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(City; City)
            {
            }
            column(Comment; Comment)
            {
            }
            column(CountryCode; "Country Code")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(Desitnation; Desitnation)
            {
            }
            column(Driver; Driver)
            {
            }
            column(GrossWeight; "Gross Weight")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(NetWeight; "Net Weight")
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(Status; Status)
            {
            }
            column(TransportTo; "Transport To")
            {
            }
            column(TransportType; "Transport Type")
            {
            }
            column(TransporttoName; "Transport to Name")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
        }
    }

    trigger OnPreReport()
    begin

        CompanyInfo.get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
