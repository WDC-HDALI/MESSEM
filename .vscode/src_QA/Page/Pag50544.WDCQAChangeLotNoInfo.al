namespace MessemMA.MessemMA;
using System.IO;

page 50544 "WDC-QA Change Lot No. Info"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Change Lot No. Info', FRA = 'Modifier info N° lot';
    PageType = Card;
    SourceTable = "WDC-QA Registered Inspec Chang";
    InsertAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                CaptionML = ENU = 'General', FRA = 'Général';

                field("Current Inspection Status"; Rec."Current Inspection Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Inspection Status"; Rec."New Inspection Status")
                {
                    ApplicationArea = All;
                }
                field("Current Expiration Date"; Rec."Current Expiration Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Expiration Date"; Rec."New Expiration Date")
                {
                    ApplicationArea = All;
                }
                field("Current Warranty Date"; Rec."Current Warranty Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ShowWarranty;
                }
                field("New Warranty Date"; Rec."New Warranty Date")
                {
                    ApplicationArea = All;
                    Visible = ShowWarranty;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Delete Second Insp. Status"; Rec."Delete Second Insp. Status")
                {
                    ApplicationArea = All;
                }
            }
            group(Lot)
            {
                CaptionML = ENU = 'Lot', FRA = 'Lot';
                field("Current Vendor Lot No."; Rec."Current Vendor Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("New Vendor Lot No."; Rec."New Vendor Lot No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Modification)
            {
                Visible = ShowModificationGroup;
                CaptionML = ENU = 'Modification', FRA = 'Modification';
                field("Date Of Change"; Rec."Date Of Change")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Subtype"; Rec."Source Subtype")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        FileMgt: Codeunit "File Management";
    begin
        //ShowModificationGroup := FileMgt.IsWindowsClient;
        ShowWarranty := ShowModificationGroup;
    end;

    var
        ShowModificationGroup: Boolean;
        ShowWarranty: Boolean;
}
