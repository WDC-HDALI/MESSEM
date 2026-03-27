namespace MESSEM.MESSEM;

report 50510 "WDC Insert Registration Line"
{
    ApplicationArea = All;
    CaptionML = ENU = 'WDC Insert Registration Line', FRA = 'Inserer ligne enregistrements CQ';
    UsageCategory = Administration;
    ProcessingOnly = true;
    Permissions = tabledata "WDC-QA Registration Line" = RIMD, tabledata "WDC-QA Registration Step" = RIMD;
    dataset
    {
        dataitem("CoA Registration Header"; "WDC-QA Registration Header")
        {
            DataItemTableView = where("Document Type" = filter('CoA'), "Lot No." = filter(<> ''));
            trigger OnAfterGetRecord()
            var
                CQRegistrationHeader: Record "WDC-QA Registration Header";
                CQRegistrationLine: Record "WDC-QA Registration Line";
                CoARegistrationLine: Record "WDC-QA Registration Line";
                CQRegistrationStep: Record "WDC-QA Registration Step";
                CoARegistrationStep: Record "WDC-QA Registration Step";

            begin
                CQRegistrationHeader.Reset();
                CQRegistrationHeader.SetRange("Document Type", "Document Type"::QC);
                CQRegistrationHeader.SetRange("Lot No.", "CoA Registration Header"."Lot No.");
                CQRegistrationHeader.SetRange("Item No.", "CoA Registration Header"."Item No.");
                if CQRegistrationHeader.FindSet() then begin
                    CQRegistrationLine.Reset();
                    CQRegistrationLine.SetRange("Document Type", CQRegistrationHeader."Document Type");
                    CQRegistrationLine.SetRange("Document No.", CQRegistrationHeader."No.");
                    if not CQRegistrationLine.FindSet() then begin
                        CoARegistrationLine.Reset();
                        CoARegistrationLine.SetRange("Document Type", "CoA Registration Header"."Document Type");
                        CoARegistrationLine.SetRange("Document No.", "CoA Registration Header"."No.");
                        if CoARegistrationLine.FindSet() then begin
                            repeat
                                CQRegistrationLine.Init();
                                CQRegistrationLine.TRANSFERFIELDS(CoARegistrationLine);
                                CQRegistrationLine."Document Type" := CQRegistrationHeader."Document Type";
                                CQRegistrationLine."Document No." := CQRegistrationHeader."No.";
                                CQRegistrationLine.Insert();

                                CoARegistrationStep.Reset();
                                CoARegistrationStep.SETRANGE("Document Type", CoARegistrationLine."Document Type");
                                CoARegistrationStep.SETFILTER("Document No.", CoARegistrationLine."Document No.");
                                CoARegistrationStep.SETRANGE("Line No.", CoARegistrationLine."Line No.");
                                IF CoARegistrationStep.FINDSET THEN
                                    REPEAT
                                        CQRegistrationStep.INIT;
                                        CQRegistrationStep.TRANSFERFIELDS(CoARegistrationStep);
                                        CQRegistrationStep."Document Type" := CQRegistrationLine."Document Type";
                                        CQRegistrationStep."Document No." := CQRegistrationLine."Document No.";
                                        CQRegistrationStep."Line No." := CQRegistrationLine."Line No.";
                                        CQRegistrationStep.INSERT;
                                    UNTIL CoARegistrationStep.NEXT <= 0;
                            until CoARegistrationLine.Next() = 0;
                            NB += 1;
                            NEnregistrement += '/' + CQRegistrationHeader."No.";
                            window.Update(1, CQRegistrationHeader."No.");
                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
            begin
                NB := 0;
                window.Open('Traitement des lignes enregistrement CQ : #1######\');
            end;

            trigger OnPostDataItem()
            var
            begin
                window.Close();
                Message('%1 enregistrement ont etait mise à jour %2', NB, NEnregistrement);
            end;
        }
    }
    var
        window: Dialog;
        NB: Integer;
        NEnregistrement: Text;
}
