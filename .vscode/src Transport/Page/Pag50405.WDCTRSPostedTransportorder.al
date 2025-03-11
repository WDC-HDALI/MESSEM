namespace MESSEM.MESSEM;

page 50405 "WDC-TRS Posted Transport order"
{
    CaptionML = ENU = 'Posted Transport order', FRA = 'Ordre transport validé';
    PageType = Document;
    SourceTable = "WDC-TRS Trasport Order Header";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTableView = where(Status = const(Posted));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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

            part(TrasportOrderLines; "WDC-TRS Trasport Order Line")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }

    }
}
