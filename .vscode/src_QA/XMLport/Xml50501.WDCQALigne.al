xmlport 50501 "WDC-QA Ligne"
{
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Xml;

    schema
    {
        textelement(Root)
        {
            tableelement("Registration Line"; "WDC-QA Registration Line")
            {
                RequestFilterFields = "Document No.";
                XmlName = 'ContactHeader';
                fieldelement(A1; "Registration Line"."Document Type")
                {
                }
                fieldelement(A2; "Registration Line"."Document No.")
                {
                }
                fieldelement(A3; "Registration Line"."Line No.")
                {
                }
                fieldelement(A4; "Registration Line"."Parameter Code")
                {
                }
                fieldelement(A5; "Registration Line"."Parameter Description")
                {
                }
                fieldelement(A6; "Registration Line"."Parameter Group Code")
                {
                }
                fieldelement(A7; "Registration Line"."Method No.")
                {
                }
                fieldelement(A8A9; "Registration Line"."Method Description")
                {
                }
                fieldelement(A9; "Registration Line"."Specification Remark")
                {
                }
                fieldelement(A10; "Registration Line"."Measure No.")
                {
                }
                fieldelement(A11; "Registration Line"."Sample Quantity")
                {
                }
                fieldelement(A12; "Registration Line"."Sample UOM")
                {
                }
                fieldelement(A13; "Registration Line"."Lower Limit")
                {
                }
                fieldelement(A14; "Registration Line"."Lower Warning Limit")
                {
                }
                fieldelement(A15; "Registration Line"."Target Result value")
                {
                }
                fieldelement(A16; "Registration Line"."Upper Warning Limit")
                {
                }
                fieldelement(A17; "Registration Line"."Upper Limit")
                {
                }
                fieldelement(A18; "Registration Line"."Result Option")
                {
                }
                fieldelement(A19; "Registration Line"."Average Result Option")
                {
                }
                fieldelement(A20; "Registration Line"."Result Value")
                {
                }
                fieldelement(A21; "Registration Line"."Result Value UOM")
                {
                }
                fieldelement(A22; "Registration Line"."Average Result Value")
                {
                }
                fieldelement(A23; "Registration Line"."Conclusion Result")
                {
                }
                fieldelement(A24; "Registration Line"."Conclusion Average Result")
                {
                }
                fieldelement(A25; "Registration Line"."QC Date")
                {
                }
                fieldelement(A26; "Registration Line"."QC Time")
                {
                }
                fieldelement(A27; "Registration Line"."Sample Temperature")
                {
                }
                fieldelement(A28; "Registration Line".Controller)
                {
                }
                fieldelement(A29; "Registration Line"."Specification Line No.")
                {
                }
                fieldelement(A30; "Registration Line"."Specification No.")
                {
                }
                fieldelement(A31; "Registration Line"."Specification Version No.")
                {
                }
                fieldelement(A32; "Registration Line"."Target Result Option")
                {
                }
                fieldelement(A33; "Registration Line"."Type of Result")
                {
                }
                fieldelement(A34; "Registration Line".Formula)
                {
                }
                fieldelement(A35; "Registration Line"."Specification Type")
                {
                }
                fieldelement(A36; "Registration Line"."Item No. EP")
                {
                }
                fieldelement(A37; "Registration Line"."Lot No. EP")
                {
                }
                fieldelement(A38; "Registration Line"."Item No. HF")
                {
                }
                fieldelement(A39; "Registration Line"."Lot No. HF")
                {
                }
                fieldelement(A40; "Registration Line"."Check Point Code")
                {
                }
                fieldelement(A41; "Registration Line".Type)
                {
                }
                fieldelement(A42; "Registration Line"."Text Description")
                {
                }
                fieldelement(A43; "Registration Line"."CoA Type Value")
                {
                }
                fieldelement(A44; "Registration Line"."Date CQ")
                {
                }
                // fieldelement(A45; "Registration Line".Variety)
                // {
                // }
                // fieldelement(A46; "Registration Line".Calibre)
                // {
                // }
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

    var
        "Salarié": Record Employee;
}

