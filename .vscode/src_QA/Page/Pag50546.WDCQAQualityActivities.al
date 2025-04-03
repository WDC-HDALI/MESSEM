namespace Projet.Projet;
using System.Environment;
using Microsoft.EServices.EDocument;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;

page 50546 "WDC-QA Quality Activities"
{
    ApplicationArea = all;
    CaptionML = ENU = 'Activities', FRA = 'Activités';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "WDC Quality Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Ongoing Purchases")
            {
                CaptionML = ENU = 'Ongoing Purchases', FRA = 'Achats en cours';
                field("Purchase Orders"; Rec."Purchase Orders")
                {
                    CaptionML = ENU = 'Purchase Orders', FRA = 'Commandes achat';
                    ApplicationArea = Suite;
                    DrillDownPageID = "Purchase Order List";
                }
                field("Ongoing Purchase Invoices"; Rec."Ongoing Purchase Invoices")
                {
                    CaptionML = ENU = 'Ongoing Purchase Invoices', FRA = 'Factures achat en cours';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Purchase Invoices";
                }
            }
            cuegroup("Production Orders")
            {
                CaptionML = ENU = 'Production Orders', FRA = 'Ordres de fabrication';
                field("Released Prod. Orders - All"; Rec."Released Prod. Orders - All")
                {
                    CaptionML = ENU = 'Released Prod. Orders - All', FRA = 'O.F. lancés';
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Released Production Orders";
                }
                field("Planned Prod. Orders - All"; Rec."Planned Prod. Orders - All")
                {
                    CaptionML = ENU = 'Planned Prod. Orders - All', FRA = 'O.F. planifiés';
                    ApplicationArea = Manufacturing;
                    DrillDownPageID = "Planned Production Orders";
                }
            }
            Cuegroup(QCSpecification)
            {
                CaptionML = ENU = 'QC Specification', FRA = 'Spécifications CQ';

                field("QC Specification - Open"; Rec."QC Specification - Open")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QA QC Specification List";
                }
                field("QC Specification - Certified"; Rec."QC Specification - Certified")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QA QC Specification List";
                }
                field("QC Specification - Closed"; Rec."QC Specification - Closed")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QAClosedQCSpecifiList";
                }
            }
            cuegroup(QCRegistration)
            {
                CaptionML = ENU = 'QC Registration', FRA = 'Enregistrements CQ';
                field("QC Registration - Open"; Rec."QC Registration - Open")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QA QC Registration List";
                }
                field("QC Registration - Closed"; Rec."QC Registration - Closed")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QA Closed QC Regist List";
                }
            }
            cuegroup(CoARegistration)
            {
                CaptionML = ENU = 'CoA Registration', FRA = 'Certificats d''analyse';
                field("CoA Rgistration - Open"; Rec."CoA Rgistration - Open")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QA CoA Registration List";
                }
                field("CoA Rgistration - Closed"; Rec."CoA Rgistration - Closed")
                {
                    ApplicationArea = all;
                    DrillDownPageId = "WDC-QAClosedCoARegistList";
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetRange("User ID Filter", UserId());

        ShowIntelligentCloud := not EnvironmentInfo.IsSaaS();
    end;

    var
        ShowIntelligentCloud: Boolean;
        EnvironmentInfo: Codeunit "Environment Information";
}
