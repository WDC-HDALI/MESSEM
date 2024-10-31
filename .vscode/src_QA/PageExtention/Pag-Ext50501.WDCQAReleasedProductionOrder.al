pageextension 50501 "WDC-QAReleased ProductionOrder" extends "Released Production Order"
{
    actions
    {
        addafter("&Print")
        {
            action("QC Registration List 2")
            {

                CaptionML = ENU = 'QC Registrations', FRA = 'Enregistrement CQ';
                Image = Agreement;
                RunObject = page "WDC-QA QC Registration List2";
                ApplicationArea = all;
                RunPageView = where("Document Type" = filter('QC'), "Source Document Type" = filter('Production Order'));
                RunPageLink = "Source Document No." = field("No.");
            }
        }
    }
}
