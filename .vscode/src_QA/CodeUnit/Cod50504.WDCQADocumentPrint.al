codeunit 50504 "WDC-QA Document-Print"
{
    procedure PrintQCRegistration(RegistrationHeader: Record "WDC-QA Registration Header")
    var
        ReportSelections: Record "Report Selections";
    begin
        RegistrationHeader.SETRANGE(Status, RegistrationHeader.Status);
        RegistrationHeader.SETRANGE("No.", RegistrationHeader."No.");
        RegistrationHeader.SETRANGE("Document Type", RegistrationHeader."Document Type");

        //ReportSelections.Print(ReportSelections.Usage::"QC.Reg", RegistrationHeader, '');
        IF RegistrationHeader.FINDFIRST THEN
            REPORT.RUN(50505, TRUE, FALSE, RegistrationHeader);
    end;

    procedure PrintCoAHeader(RegistrationHeader: Record "WDC-QA Registration Header")
    var
        CertificateOfAnalysis: Record "WDC-QA Certificate of Analysis";
        Customer: Record Customer;
        CustomerList: Page "Customer List";
    begin
        CertificateOfAnalysis.SETCURRENTKEY("Customer No.");
        CLEAR(CustomerList);
        CustomerList.LOOKUPMODE := TRUE;
        IF CustomerList.RUNMODAL = ACTION::LookupOK THEN
            CertificateOfAnalysis.SETFILTER("Customer No.", CustomerList.GetSelectionFilter)
        ELSE
            CertificateOfAnalysis.SETRANGE("Customer No.", '');
        CertificateOfAnalysis.SETFILTER("Report ID", '<>0');
        CertificateOfAnalysis.ASCENDING := FALSE;
        CertificateOfAnalysis.FINDFIRST;

        IF STRLEN(CertificateOfAnalysis.GETFILTER("Customer No.")) = 2 THEN
            REPEAT
                RegistrationHeader.SETRECFILTER;
                RegistrationHeader.SETFILTER("Customer No. Filter", CertificateOfAnalysis.GETFILTER("Customer No."));
                REPORT.RUN(CertificateOfAnalysis."Report ID", TRUE, FALSE, RegistrationHeader);
            UNTIL CertificateOfAnalysis.NEXT = 0
        ELSE BEGIN
            Customer.SETFILTER("No.", CustomerList.GetSelectionFilter);
            Customer.FINDFIRST;
            REPEAT
                CertificateOfAnalysis.RESET;
                CertificateOfAnalysis.SETFILTER("Customer No.", Customer."No.");
                CertificateOfAnalysis.SETFILTER("Report ID", '<>0');
                IF CertificateOfAnalysis.FINDSET THEN
                    REPEAT
                        RegistrationHeader.SETRECFILTER;
                        RegistrationHeader.SETFILTER("Customer No. Filter", Customer."No.");
                        REPORT.RUN(CertificateOfAnalysis."Report ID", TRUE, FALSE, RegistrationHeader);
                    UNTIL CertificateOfAnalysis.NEXT = 0;
            UNTIL Customer.NEXT <= 0;
        END;
    end;
}
