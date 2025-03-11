namespace MESSEM.MESSEM;
using Microsoft.Inventory.Item;
using System.Visualization;
using Microsoft.Manufacturing.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Document;
using Microsoft.EServices.EDocument;
using System.Environment;
using Microsoft.Purchases.Vendor;
using Projet.Projet;
using Microsoft.Manufacturing.RoleCenters;
using Microsoft.Sales.History;
using Microsoft.Sales.FinanceCharge;
using Microsoft.Sales.Reminder;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;

page 50545 "WDC-QA Quality Role Center"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Quality Role Center', FRA = 'Tableau de bord qualité';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Accountant")
            {
                ApplicationArea = All;
            }
            part(control; "WDC-QA Quality Activities")
            {
                ApplicationArea = all;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Caption = '';
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group(Purchase)
            {
                CaptionML = ENU = 'Purchasing', FRA = 'Achat';
                Image = AdministrationSalesPurchases;
                action(Purchase_VendorList)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Vendors', FRA = 'Fournisseurs';
                    RunObject = Page "Vendor List";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Incoming Documents', FRA = 'Documents entrants';
                    Gesture = None;
                    RunObject = Page "Incoming Documents";
                }
                action("Item Charges")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Item Charges', FRA = 'Frais annexes';
                    RunObject = Page "Item Charges";
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Purchase Quotes', FRA = 'Demandes de prix';
                    RunObject = Page "Purchase Quotes";
                }
                action("<Page Purchase Orders>")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Purchase Orders', FRA = 'Commandes achat';
                    RunObject = Page "Purchase Order List";
                }
                action("Blanket Purchase Orders")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Blanket Purchase Orders', FRA = 'Commandes cadres achat';
                    RunObject = Page "Blanket Purchase Orders";
                }
                action("<Page Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Purchase Invoices', FRA = 'Factures achat';
                    RunObject = Page "Purchase Invoices";
                }
                action("<Page Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Purchase Credit Memos', FRA = 'Avoirs achat';
                    RunObject = Page "Purchase Credit Memos";
                }
                action("Purchase Return Orders")
                {
                    ApplicationArea = SalesReturnOrder;
                    CaptionML = ENU = 'Purchase Return Orders', FRA = 'Retours achat';
                    RunObject = Page "Purchase Return Order List";
                }
                action("<Page Posted Purchase Invoices>")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Posted Purchase Invoices', FRA = 'Factures achat enregistrées';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("<Page Posted Purchase Credit Memos>")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Posted Purchase Credit Memos', FRA = 'Avoirs achat enregistrés';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("<Page Posted Purchase Receipts>")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Posted Purchase Receipts', FRA = 'Réceptions achat enregistrées';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Return Shipments")
                {
                    ApplicationArea = SalesReturnOrder;
                    CaptionML = ENU = 'Posted Purchase Return Shipments', FRA = 'Expéditions retour achat enregistrées';
                    RunObject = Page "Posted Return Shipments";
                }
            }
            group("Production Orders")
            {
                CaptionML = ENU = 'Production Orders', FRA = 'Ordres de fabrication';
                action("Released Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    CaptionML = ENU = 'Released Production Orders', FRA = 'O.F. lancés';
                    RunObject = Page "Released Production Orders";
                }
                action("Finished Production Orders")
                {
                    ApplicationArea = Manufacturing;
                    CaptionML = ENU = 'Finished Production Orders', FRA = 'O.F. terminés';
                    RunObject = Page "Finished Production Orders";
                }
            }
            group(Quality)
            {
                CaptionML = ENG = 'Quality', FRA = 'Qualité';
                action(Methodes)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'Methods', FRA = 'Méthodes';
                    Image = SetupColumns;
                    RunObject = Page "WDC-QA Methods List";
                    RunPageMode = Edit;
                }
                action("CQ Specification")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Specification', FRA = 'Spécification CQ';
                    Image = TestFile;
                    RunObject = Page "WDC-QA QC Specification List";
                    RunPageMode = Edit;
                }
                action("CQ Registration")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Registration', FRA = 'Enregistrement CQ';
                    Image = Register;
                    RunObject = Page "WDC-QA QC Registration List";
                    RunPageMode = Edit;
                }
                action("CQ Registration Certificat")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Registration Certificat', FRA = 'Enregistrement certificat d''analyse CQ';
                    Image = Register;
                    RunObject = Page "WDC-QA CoA Registration List";
                    RunPageMode = Edit;
                }
                action("CQ Closed specification")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Closed Specification', FRA = 'Spécification CQ clôturée';
                    Image = Archive;
                    RunObject = Page "WDC-QAClosedQCSpecifiList";
                    RunPageMode = Edit;
                }
                action("CQ Closed Registration")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Closed Registration', FRA = 'Enregistrement CQ clôturée';
                    Image = Archive;
                    RunObject = Page "WDC-QA Closed QC Regist List";
                    RunPageMode = Edit;
                }
                action("CQ Closed Certificats")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENG = 'CQ Closed Certificats', FRA = 'Enregistrement certificats d''analyse clôturé';
                    Image = Archive;
                    RunObject = Page "WDC-QAClosedCoARegistList";
                    RunPageMode = Edit;
                }
            }
        }
        area(Embedding)
        {
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Customers', FRA = 'Clients';
                Image = Customer;
                RunObject = Page "Customer List";
                RunPageMode = Edit;
            }
            action(Items)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Items', FRA = 'Articles';
                Image = Item;
                RunObject = Page "Item List";
                RunPageMode = Edit;
            }
        }
        area(Processing)
        {
            action("QC Configuration")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Configuration', FRA = 'Configuration contrôle qualité';
                Image = SetupFluent;
                RunObject = Page "WDC-QA Quality Control Setup";
                RunPageMode = Edit;
            }
            action("QC Setting Group")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Setting Group', FRA = 'Groupes de paramétres';
                Image = SetupList;
                RunObject = Page "WDC-QA Parameter Group";
                RunPageMode = Edit;
            }
            action("QC Settings")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Setting', FRA = 'Paramétres';
                Image = Setup;
                RunObject = Page "WDC-QA QC Parameters";
                RunPageMode = Edit;
            }
            action("QC Equipment Group")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Equipment Group', FRA = 'Groupe équipement';
                Image = Group;
                RunObject = Page "WDC-QA Equipment Groups";
                RunPageMode = Edit;
            }
            action("QC measure")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Measures', FRA = 'mesures';
                Image = TaskQualityMeasure;
                RunObject = Page "WDC-QA Measurement";
                RunPageMode = Edit;
            }
            action("CQ checkpoint")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Checkpoint', FRA = 'Points de Contrôles';
                Image = CheckList;
                RunObject = Page "WDC-QA Check Points";
                RunPageMode = Edit;
            }
            action("CQ Controllers")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'CQ Controllers', FRA = 'Contrôleurs CQ';
                Image = Select;
                RunObject = Page "WDC-QA QC Controllers";
                RunPageMode = Edit;
            }
            action("CQ Certificate")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Certificate', FRA = 'Certificats';
                Image = Certificate;
                RunObject = Page "WDC-QA Certificates Of Analysi";
                RunPageMode = Edit;
            }
            action("CoA Template")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENG = 'Template', FRA = 'Modèle certificat d''analyse';
                Image = UserCertificate;
                RunObject = Page "WDC-QA CoA Template List";
                RunPageMode = Edit;
            }

        }
    }
    var
        n: Page 1310;
}
