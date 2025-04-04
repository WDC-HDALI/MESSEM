xmlport 50800 "WDC-ED Export G/L Entries"
{
    captionML = ENU = 'Export G/L Entries', FRA = 'Exporter écritures comptables';

    schema
    {
        textelement(FichierAudit)
        {
            textelement(FiltreDate)
            {
                textelement(startingdate)
                {
                    XmlName = 'DateDébut';
                }
                textelement(endingdate)
                {
                    XmlName = 'DateFin';
                }
            }
            tableelement("g/l entry"; "G/L Entry")
            {
                XmlName = 'EcritureComptable';
                fieldelement("NoSéquence"; "G/L Entry"."Entry No.")
                {
                }
                fieldelement("NoCpteGénéral"; "G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(DateComptabilisation; "G/L Entry"."Posting Date")
                {
                }
                fieldelement(TypeDocument; "G/L Entry"."Document Type")
                {
                }
                fieldelement(NoDocument; "G/L Entry"."Document No.")
                {
                }
                fieldelement("Désignation"; "G/L Entry".Description)
                {
                }
                fieldelement(NoCpteContrepartie; "G/L Entry"."Bal. Account No.")
                {
                }
                fieldelement(Montant; "G/L Entry".Amount)
                {
                }
                fieldelement(CodeAxePrincipale1; "G/L Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(CodeAxePrincipale2; "G/L Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(CodeUtilisateur; "G/L Entry"."User ID")
                {
                }
                fieldelement(CodeJournal; "G/L Entry"."Source Code")
                {
                }
                fieldelement(EcritureSysteme; "G/L Entry"."System-Created Entry")
                {
                }
                fieldelement("EcritureExercicePrécédent"; "G/L Entry"."Prior-Year Entry")
                {
                }
                fieldelement(NoProjet; "G/L Entry"."Job No.")
                {
                }
                fieldelement("Quantité"; "G/L Entry".Quantity)
                {
                }
                fieldelement(MontantTVA; "G/L Entry"."VAT Amount")
                {
                }
                fieldelement(CodeCentreDeProfit; "G/L Entry"."Business Unit Code")
                {
                }
                fieldelement(NomFeuille; "G/L Entry"."Journal Batch Name")
                {
                }
                fieldelement(CodeMotif; "G/L Entry"."Reason Code")
                {
                }
                fieldelement(TypeComptaTVA; "G/L Entry"."Gen. Posting Type")
                {
                }
                fieldelement("GroupeComptaMarché"; "G/L Entry"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GroupeComptaProduit; "G/L Entry"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(TypeCpteContrepartie; "G/L Entry"."Bal. Account Type")
                {
                }
                fieldelement(NoTransaction; "G/L Entry"."Transaction No.")
                {
                }
                fieldelement("MontantDébit"; "G/L Entry"."Debit Amount")
                {
                }
                fieldelement("MontantCrédit"; "G/L Entry"."Credit Amount")
                {
                }
                fieldelement(DateDocument; "G/L Entry"."Document Date")
                {
                }
                fieldelement(NoDocExterne; "G/L Entry"."External Document No.")
                {
                }
                fieldelement(TypeOrigine; "G/L Entry"."Source Type")
                {
                }
                fieldelement(NoOrigine; "G/L Entry"."Source No.")
                {
                }
                fieldelement("GroupeComptaMarchéTVA"; "G/L Entry"."VAT Bus. Posting Group")
                {
                }
                fieldelement(GroupeComptaProduitTVA; "G/L Entry"."VAT Prod. Posting Group")
                {
                }
                fieldelement("Contre-passé"; "G/L Entry".Reversed)
                {
                }
                fieldelement("Contre-passéParNoEcriture"; "G/L Entry"."Reversed by Entry No.")
                {
                }
                fieldelement("NoEcritureContre-passée"; "G/L Entry"."Reversed Entry No.")
                {
                }
                fieldelement(IDLettrage; "G/L Entry"."Applies-to ID")
                {
                }
                fieldelement(Lettre; "G/L Entry".Letter)
                {
                }
                fieldelement(DateLettre; "G/L Entry"."Letter Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Window.UPDATE(1, "G/L Entry"."Entry No.");
                    Window.UPDATE(2, "G/L Entry"."Posting Date");
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        Window.CLOSE;
    end;

    trigger OnPreXmlPort()
    begin
        Window.OPEN(
          Text001 +
          Text002 +
          Text003);
    end;

    procedure InitializeRequest(var GLEntry: Record "G/L Entry"; StartDate: Date; EndDate: Date)
    begin
        "G/L Entry".COPYFILTERS(GLEntry);
        StartingDate := FORMAT(StartDate);
        EndingDate := FORMAT(EndDate);
    end;

    var
        Text001: TextConst ENU = 'Exporting G/L Entries to XML File...\\',
                           FRA = 'Exportation d''écritures comptables vers un fichier XML...\\';
        Text002: TextConst ENU = 'Entry No.           #1######\',
                           FRA = 'Écriture n°                     #1######\';
        Text003: TextConst ENU = 'Posting Date        #2######',
                           FRA = 'Date de comptabilisation        #2######';
        Window: Dialog;
}

