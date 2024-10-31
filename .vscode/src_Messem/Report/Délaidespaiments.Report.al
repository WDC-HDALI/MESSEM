report 50086 "Délai des paiments"
{
    // WDC001  06.09.2023  WDC.IM  Create Report
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/Délaidespaiments.rdlc';

    CaptionML = ENU = 'Payments Deadline', FRA = 'Délai des paiments';

    dataset
    {
        dataitem(DataItem1000000000; 17)
        {
            DataItemTableView = ORDER(Ascending)
                                WHERE("G/L Account No." = FILTER('4411*|4488*'),
                                      "Document Type" = FILTER(2 | 3));
            RequestFilterFields = "Posting Date";
            column(NomFournisseur; VendorName)
            {
            }
            column(NOFournisseur; CodeFour)
            {
            }
            column(FournisseurPayeur; VendorPayer)
            {
            }
            column(Patente; Patente)
            {
            }
            column(Convention; convention)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(FactureFournisseur; "External Document No.")
            {
            }
            column("Désignation"; Description)
            {
            }
            column(NomCompte; NomCompte)
            {
            }
            column(Datefacture; "Posting Date")
            {
            }
            column(DocumentDate; DocumentDate)
            {
            }
            column(NewDueDate; NewDueDate)
            {
            }
            column(DueDate; DueDate)
            {
            }
            column(DateReceipt; DateReceipt)
            {
            }
            column(DateP; DateP)
            {
            }
            column(MontantHT; MontantHT)
            {
            }
            column(MontantTTC; MontantTTC)
            {
            }
            column(MontantP; MontantP)
            {
            }
            column("PayéO_N"; Paye)
            {
            }
            column("CodeModeRèglement"; Vendor."Payment Method Code")
            {
            }
            column(CodeConditionPaiment; Vendor."Payment Terms Convention")
            {
            }
            column(NombreJ; NombreJ)
            {
            }
            column(ETATdupaiement; ETATdupaiement)
            {
            }
            column(NPJOURSRETARD; NPJOURSRETARD)
            {
            }
            column(ETATNP; ETATNP)
            {
            }
            column(Montantamende; Montantamende)
            {
            }
            column(MATF; MATF)
            {
            }
            column(ICE; ICE)
            {
            }
            column(FiltreDate; GETFILTER("Posting Date"))
            {
            }
            column(NumRC; NumRC)
            {
            }
            column(Adresse; Adresse)
            {
            }
            column(City; City)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(Vendor);
                CLEAR(VendorName);
                CLEAR(MATF);
                CLEAR(ICE);
                CLEAR(Patente);
                CLEAR(convention);
                CLEAR(VendorPayer);
                CLEAR(TermeConv);
                CLEAR(NumRC);
                CLEAR(Adresse);
                CLEAR(City);
                CLEAR(CodeFour);
                Tressource.INIT;
                Tressource."No." := "Document No.";
                IF NOT Tressource.INSERT(TRUE) THEN CurrReport.SKIP;
                //>>
                CLEAR(CodeFour);
                IF Purchase.GET("Document No.") THEN BEGIN
                    CodeFour := Purchase."Buy-from Vendor No."
                END;
                IF CrMemo.GET("Document No.") THEN BEGIN
                    CodeFour := CrMemo."Buy-from Vendor No."
                END;
                //<<
                IF Vendor.GET(CodeFour) THEN BEGIN
                    VendorName := Vendor.Name;
                    MATF := Vendor."VAT Registration No.";
                    ICE := Vendor.ICE;
                    convention := Vendor."Convention Y/N";
                    VendorPayer := "Source No.";
                    TermeConv := Vendor."Payment Terms Convention";
                    NumRC := Vendor."No. RC";
                    Adresse := Vendor.Address;
                    City := Vendor.City;
                END
                ELSE BEGIN
                    VendorName := '';
                    MATF := '';
                    ICE := '';
                    VendorPayer := '';
                    convention := FALSE;
                    TermeConv := '';
                    NumRC := '';
                    Adresse := '';
                    City := '';
                    NumRC := '';
                    Adresse := '';
                END;

                IF VendorPayer = '' THEN VendorPayer := "Source No.";
                //Nom du compte
                CLEAR(NomCompte);
                CLEAR(GlEntry);
                CLEAR(Glaccount);
                GlEntry.SETRANGE("Transaction No.", "Transaction No.");
                GlEntry.SETFILTER("G/L Account No.", '<>%1|<>%2', '4411*', '4488*');
                GlEntry.SETFILTER(Amount, '<>%1', 0);
                IF GlEntry.FINDFIRST THEN BEGIN
                    Glaccount.GET(GlEntry."G/L Account No.");
                    NomCompte := Glaccount.Name;
                END;
                //Date document Due Date et Date réception
                CLEAR(Purchase);
                CLEAR(CrMemo);
                CLEAR(DocumentDate);
                CLEAR(DueDate);
                CLEAR(DateReceipt);
                CLEAR(MontantHT);
                CLEAR(MontantTTC);
                CLEAR(PurchaseLine);
                CLEAR(PurchaseReceipt);
                IF Purchase.GET("Document No.") THEN BEGIN
                    Purchase.CALCFIELDS(Amount);
                    Purchase.CALCFIELDS("Amount Including VAT");
                    DocumentDate := Purchase."Document Date";
                    DueDate := Purchase."Due Date";
                    MontantHT := Purchase.Amount;
                    MontantTTC := Purchase."Amount Including VAT";
                END;
                IF CrMemo.GET("Document No.") THEN BEGIN
                    CrMemo.CALCFIELDS(Amount);
                    CrMemo.CALCFIELDS("Amount Including VAT");
                    DocumentDate := CrMemo."Document Date";
                    DueDate := CrMemo."Due Date";
                    MontantHT := CrMemo.Amount * -1;
                    MontantTTC := CrMemo."Amount Including VAT" * -1;
                END;
                PurchaseLine.SETRANGE("Document No.", "Document No.");
                PurchaseLine.SETFILTER("Receipt No.", '<>%1', '');
                IF PurchaseLine.FINDLAST THEN BEGIN
                    IF PurchaseReceipt.GET(PurchaseLine."Receipt No.") THEN
                        DateReceipt := PurchaseReceipt."Posting Date";
                END;
                IF DateReceipt = 0D THEN DateReceipt := "Posting Date";
                //Lettrage paiement
                CLEAR(DateP);
                CLEAR(rec25);
                CLEAR(MontantP);
                rec25.SETRANGE("Document No.", "Document No.");
                rec25.SETFILTER("Document Type", '%1|%2', rec25."Document Type"::Invoice, rec25."Document Type"::"Credit Memo");
                IF rec25.FINDFIRST THEN;
                rec380.RESET;
                rec380.SETRANGE("Vendor Ledger Entry No.", rec25."Entry No.");
                rec380.SETRANGE("Entry Type", rec380."Entry Type"::Application);
                rec380.SETFILTER("Posting Date", '%1..%2', GETRANGEMIN("Posting Date"), GETRANGEMAX("Posting Date"));
                rec380.SETRANGE(Unapplied, FALSE);
                IF rec380.FINDFIRST THEN BEGIN
                    DateP := rec380."Posting Date";
                    IF CrMemo.GET("Document No.") THEN
                        MontantP := ABS(rec380.Amount) * -1
                    ELSE
                        MontantP := ABS(rec380.Amount);
                END;
                //Calcul nouvelle date d'échéance
                CLEAR(Paye);
                CLEAR(NewDueDate);
                IF TermeConv <> '' THEN BEGIN
                    CLEAR(PaiemTerm);
                    IF PaiemTerm.GET(TermeConv) THEN
                        NewDueDate := CALCDATE(PaiemTerm."Due Date Calculation", DocumentDate);
                END;
                IF MontantP <> 0 THEN Paye := TRUE;
                CLEAR(NombreJ);
                IF (DateP <> 0D) AND (NewDueDate <> 0D) THEN
                    NombreJ := DateP - NewDueDate
                ELSE
                    NombreJ := 0;
                CLEAR(ETATdupaiement);
                CLEAR(NPJOURSRETARD);
                CLEAR(ETATNP);
                CLEAR(Montantamende);
                ParamCompt.GET;
                IF (NombreJ <= 0) AND (MontantP <> 0) THEN ETATdupaiement := NatureP ELSE IF (NombreJ >= 0) AND (MontantP <> 0) THEN ETATdupaiement := NatureP1 ELSE ETATdupaiement := '';
                IF NewDueDate <> 0D THEN
                    IF MontantP = 0 THEN NPJOURSRETARD := GETRANGEMAX("Posting Date") - NewDueDate;
                IF (NPJOURSRETARD <= 0) AND (MontantP = 0) THEN ETATNP := ETATnonp ELSE IF (NPJOURSRETARD > 0) AND (MontantP = 0) THEN ETATNP := ETATnonp1 ELSE ETATNP := '';
                IF ETATdupaiement = UPPERCASE(NatureP1) THEN BEGIN
                    CASE NombreJ OF
                        0 .. 30:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax  0 to 30 D", 0.001);
                        31 .. 60:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax 31 to 60 D", 0.001);
                        61 .. 90:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax 61 to 90 D", 0.001);
                        91 .. 9999:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax more 91 D", 0.001);
                        ELSE
                            Montantamende := ROUND(0, 0.001);
                    END;
                END;
                IF ETATNP = UPPERCASE(ETATnonp) THEN BEGIN
                    CASE NombreJ OF
                        0 .. 30:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax  0 to 30 D", 0.001);
                        31 .. 60:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax 31 to 60 D", 0.001);
                        61 .. 90:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax 61 to 90 D", 0.001);
                        91 .. 9999:
                            Montantamende := ROUND(MontantTTC * ParamCompt."Calculation of Tax more 91 D", 0.001);
                        ELSE
                            Montantamende := ROUND(0, 0.001);
                    END;
                END;
                IF MATF = '' THEN Montantamende := 0;
            end;
        }
    }



    trigger OnInitReport()
    begin
        CLEAR(Tressource);
        Tressource.DELETEALL;
    end;

    var
        VendorName: Text[50];
        Vendor: Record 23;
        Patente: Boolean;
        convention: Boolean;
        MATF: Code[20];
        ICE: Code[20];
        VendorPayer: Code[20];
        GlEntry: Record 17;
        NomCompte: Code[50];
        Glaccount: Record 15;
        DocumentDate: Date;
        Purchase: Record 122;
        CrMemo: Record 124;
        DueDate: Date;
        DateReceipt: Date;
        MontantHT: Decimal;
        MontantTTC: Decimal;
        PurchaseReceipt: Record 120;
        PurchaseLine: Record 123;
        DateP: Date;
        MontantP: Decimal;
        rec380: Record 380;
        rec25: Record 25;
        NewDueDate: Date;
        DateFilter: Text[20];
        TermeConv: Code[10];
        PaiemTerm: Record 3;
        Paye: Boolean;
        NombreJ: Integer;
        Tressource: Record 156 temporary;
        ETATdupaiement: Code[20];
        NPJOURSRETARD: Integer;
        ETATNP: Code[20];
        Montantamende: Decimal;
        NatureP: Label 'Payé à l''échéance';
        NatureP1: Label 'Hors échéance';
        ETATnonp: Label 'Non échus';
        ETATnonp1: Label 'Echus';
        CodeFour: Code[20];
        ParamCompt: Record 98;
        NumRC: Code[20];
        Adresse: Text[50];
        City: Text[30];
}

