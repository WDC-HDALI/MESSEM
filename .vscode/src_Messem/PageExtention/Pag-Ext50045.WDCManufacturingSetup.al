namespace MESSEM.MESSEM;

using Microsoft.Manufacturing.Setup;

pageextension 50045 "WDC Manufacturing Setup" extends "Manufacturing Setup"
{
    layout
    {
        addafter("Routing Nos.")
        {
            field("Box No."; Rec."Box No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Planning)
        {
            group(Colos)
            {
                field("Colos Link"; Rec."Colos Link")
                {
                    ApplicationArea = All;
                }
                field("Trigger"; Rec."Trigger")
                {
                    ApplicationArea = All;
                }
            }
            group(Production)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code Sous taitance"; Rec."Location Code Sous taitance")
                {
                    ApplicationArea = All;
                }
                field("Bin Code Sous Traitance"; Rec."Bin Code Sous Traitance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
