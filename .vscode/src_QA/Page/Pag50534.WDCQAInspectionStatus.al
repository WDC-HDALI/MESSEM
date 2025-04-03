namespace MESSEM.MESSEM;

page 50534 "WDC-QA Inspection Status"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Inspection Status', FRA = 'Statut d''inspection';
    PageType = List;
    SourceTable = "WDC-QA Inspection Status";
    UsageCategory = Lists;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(QC; Rec.QC)
                {
                    ApplicationArea = All;
                }
                field("Result Sample"; Rec."Result Sample")
                {
                    ApplicationArea = All;
                }
                field(Sales; Rec.Sales)
                {
                    ApplicationArea = All;
                }
                field("Planning Inventory"; Rec."Planning Inventory")
                {
                    ApplicationArea = All;
                }
                field(Pick; Rec.Pick)
                {
                    ApplicationArea = All;
                }
                field(Consumption; Rec.Consumption)
                {
                    ApplicationArea = All;
                }
                field("Transfer From"; Rec."Transfer From")
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice"; Rec."Purchase Invoice")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
