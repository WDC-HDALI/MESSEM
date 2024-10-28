report 50501 "WDC-QACreateSpecifiVersion"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Create Specification Version', FRA = 'Créer version spécification';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    RDLCLayout = './.vscode/src/Report/RDLC/CreateSpecificationVersion.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(WDCQASpecificationHeader; "WDC-QA Specification Header")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                TESTFIELD("No.");
                TESTFIELD("Version No.");

                CopySpecification(WDCQASpecificationHeader);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', FRA = 'Options';
                    field(SpecificationNo; SpecificationNo)
                    {
                        CaptionML = ENU = 'Specification No.', FRA = 'N° spécification';
                        Editable = false;
                    }
                    field(NewVersionCode; NewVersionCode)
                    {
                        CaptionML = ENU = 'New Version Code', FRA = 'Nouveau code version';
                    }
                    field(RevisedBy; RevisedBy)
                    {
                        CaptionML = ENU = 'Revised By', FRA = 'Révisé par';
                        TableRelation = "User Setup"."User ID";
                    }
                    field(Reason; Reason)
                    {
                        CaptionML = ENU = 'Reason', FRA = 'Motif';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    procedure SetParameters(SpecificationNoIN: Code[20])
    begin
        SpecificationNo := SpecificationNoIN;
    end;

    procedure CopySpecification(SourceSpecificationHeader: Record "WDC-QA Specification Header"): Code[20]
    var
        TargetSpecificationHeader: Record "WDC-QA Specification Header";
        SourceSpecificationHeader2: Record "WDC-QA Specification Header";
        SourceSpecificationLine: Record "WDC-QA Specification Line";
        TargetSpecificationLine: Record "WDC-QA Specification Line";
        SourceSpecificationStep: Record "WDC-QA Specification Step";
        TargetSpecificationStep: Record "WDC-QA Specification Step";
    begin
        IF NewVersionCode <> '' THEN BEGIN
            TargetSpecificationHeader.INIT;
            TargetSpecificationHeader.TRANSFERFIELDS(SourceSpecificationHeader);
            TargetSpecificationHeader."Version No." := NewVersionCode;
            TargetSpecificationHeader."Version Date" := WORKDATE;
            TargetSpecificationHeader."Revised By" := RevisedBy;
            //TargetSpecificationHeader."Reason for Modification" := Reason;
            TargetSpecificationHeader.Status := TargetSpecificationHeader.Status::Open;
            TargetSpecificationHeader."Revised By" := RevisedBy;
            TargetSpecificationHeader.INSERT(TRUE);

            SourceSpecificationLine.SETRANGE("Document Type", SourceSpecificationHeader."Document Type");
            SourceSpecificationLine.SETFILTER("Document No.", SourceSpecificationHeader."No.");
            SourceSpecificationLine.SETFILTER("Version No.", SourceSpecificationHeader."Version No.");
            IF SourceSpecificationLine.FINDSET THEN
                REPEAT
                    TargetSpecificationLine.TRANSFERFIELDS(SourceSpecificationLine);
                    TargetSpecificationLine."Version No." := NewVersionCode;
                    TargetSpecificationLine.INSERT;
                UNTIL SourceSpecificationLine.NEXT = 0;

            SourceSpecificationStep.SETRANGE("Document Type", SourceSpecificationHeader."Document Type");
            SourceSpecificationStep.SETFILTER("Document No.", SourceSpecificationHeader."No.");
            SourceSpecificationStep.SETFILTER("Version No.", SourceSpecificationHeader."Version No.");
            IF SourceSpecificationStep.FINDSET THEN
                REPEAT
                    TargetSpecificationStep.TRANSFERFIELDS(SourceSpecificationStep);
                    TargetSpecificationStep."Version No." := NewVersionCode;
                    TargetSpecificationStep.INSERT;
                UNTIL SourceSpecificationStep.NEXT = 0;

            SourceSpecificationHeader2.SETRANGE("Document Type", SourceSpecificationHeader."Document Type");
            SourceSpecificationHeader2.SETFILTER("No.", SourceSpecificationHeader."No.");
            SourceSpecificationHeader2.SETFILTER(Status, '<>%1', SourceSpecificationHeader2.Status::Closed);
            IF SourceSpecificationHeader2.FINDSET(TRUE) THEN
                REPEAT
                    IF (SourceSpecificationHeader2."Version No." <> NewVersionCode) THEN BEGIN
                        SourceSpecificationHeader2."Date Closed" := WORKDATE;
                        SourceSpecificationHeader2.Status := SourceSpecificationHeader2.Status::Closed;
                        SourceSpecificationHeader2.MODIFY(TRUE);
                    END;
                UNTIL SourceSpecificationHeader2.NEXT = 0;
        END;
    end;

    var
        SpecificationNo: Code[20];
        NewVersionCode: Code[20];
        RevisedBy: Code[50];
        Reason: Text[80];
}
