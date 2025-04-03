namespace MESSEM.MESSEM;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 50052 "WDC General Journal" extends "General Journal"
{
    layout
    {
        addbefore(Amount)
        {
            field("Debit Amount_"; Rec."Debit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Amount_"; Rec."Credit Amount")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            action("Import from Excel")
            {
                CaptionML = ENU = 'Import Paye', FRA = 'Importer Paie';
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                vAR
                    CUimportFromExcell: Codeunit "WDC Import PAIE Excel";
                begin
                    CUimportFromExcell.ReadExcelSheet;
                end;
            }
        }
    }
}
