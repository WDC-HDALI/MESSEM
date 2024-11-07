xmlport 50500 "WDC-QA Import Result Line CQ"
{
    FieldSeparator = ';';
    FileName = 'LigneCQ.CSV';
    Format = VariableText;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement(LigEnregCQ; "Payment Terms")
            {
                XmlName = 'LigEnregCQ';
                textelement(LineNo)
                {
                }
                textelement(Result)
                {
                }
                textelement(Doco)
                {
                }
            }

            trigger OnBeforePassVariable()
            begin
                MESSAGE('%1', Valeur);
            end;

            trigger OnAfterAssignVariable()
            begin
                EVALUATE(Valeur, LineNo);
                RecGRegStep.RESET;
                RecGRegStep.SETRANGE("Document No.", Doco);
                RecGRegStep.SETRANGE("Line No.", Valeur);
                IF RecGRegStep.FINDSET THEN BEGIN
                    EVALUATE(Valeur, Result);
                    RecGRegStep."Value Measured" := Valeur;
                    RecGRegStep.MODIFY;
                END;
            end;
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

    var
        RecGRegStep: Record "WDC-QA Registration Step";
        Valeur: Integer;
}

