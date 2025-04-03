namespace MESSEM.MESSEM;

page 50404 "WDC-TRS Posted Trans. Orders"
{
    CaptionML = ENU = 'Posted Transport orders', FRA = 'Ordres transport validés';
    SourceTable = "WDC-TRS Trasport Order Header";
    CardPageId = "WDC-TRS Posted Transport order";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where(Status = const(Posted));
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';

                field("Transport Type"; Rec."Transport Type")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Transport To"; Rec."Transport To")
                {
                    ApplicationArea = all;
                }
                field("Transport to Name"; Rec."Transport to Name")
                {
                    ApplicationArea = all;
                }
                field(Address; Rec.Desitnation)
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
                field("Shipment Method code"; Rec."Shipment Method code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Origin Order No."; Rec."Origin Order No.")
                {
                    ApplicationArea = all;
                }
                field("External Doc No."; Rec."External Doc No.")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = all;
                }
                field("Purchase Receip No."; Rec."Purchase Receip No.")
                {
                    ApplicationArea = all;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
