page 50008 "WDC Rebate Entries"
{

    CaptionML = ENU = 'Rebate Entries', FRA = 'Ecritures Bonus';
    DataCaptionFields = "Sell-to/Buy-from No.";
    Editable = true;
    PageType = List;
    SourceTable = "WDC Rebate Entry";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Rebate Code"; Rec."Rebate Code")
                {
                    ApplicationArea = all;
                }
                field("Rebate Document Type"; Rec."Rebate Document Type")
                {
                    ApplicationArea = all;
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = all;
                }
                field("Sell-to/Buy-from No."; Rec."Sell-to/Buy-from No.")
                {
                    ApplicationArea = all;
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = all;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = all;
                }
                field("Base Quantity"; Rec."Base Quantity")
                {
                    ApplicationArea = all;
                }
                field("Rebate Unit of Measure Code"; Rec."Rebate Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field(Open; rec.Open)
                {
                    ApplicationArea = all;
                }
                field("Rebate Method"; Rec."Rebate Method")
                {
                    ApplicationArea = all;
                }
                field("Accrual Value (LCY)"; Rec."Accrual Value (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Accrual Amount (LCY)"; Rec."Accrual Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Rebate Amount (LCY)"; Rec."Rebate Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Rebate Difference (LCY)"; Rec."Rebate Difference (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Bill-to/Pay-to No."; Rec."Bill-to/Pay-to No.")
                {
                    ApplicationArea = all;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = all;
                }
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = all;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Correction Amount (LCY)"; Rec."Correction Amount (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Correction Posted"; Rec."Correction Posted")
                {
                    ApplicationArea = all;
                }
                field("Correction Posted by Entry No."; Rec."Correction Posted by Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Navigate")
            {
                CaptionML = ENU = '&Navigate', FRA = 'Naviguer';

                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    var
        Navigate: Page 344;
}

