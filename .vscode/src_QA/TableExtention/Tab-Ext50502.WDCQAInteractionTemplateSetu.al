namespace MESSEM.MESSEM;

using Microsoft.CRM.Interaction;

tableextension 50502 "WDC-QA InteractionTemplateSetu" extends "Interaction Template Setup"
{
    fields
    {
        field(50500; "Product Specifications"; Code[10])
        {
            CaptionML = ENU = 'Product Specifications', FRA = 'Spécification produit';
            DataClassification = ToBeClassified;
            TableRelation = "Interaction Template" WHERE("Attachment No." = CONST(0));
        }
        field(50501; CoA; Code[10])
        {
            CaptionML = ENU = 'CoA', FRA = 'Certificat d''analyse';
            DataClassification = ToBeClassified;
            TableRelation = "Interaction Template" WHERE("Attachment No." = CONST(0));
        }
        field(50502; "Non Conformances"; Code[10])
        {
            CaptionML = ENU = 'Non Conformances', FRA = 'Non conformité';
            DataClassification = ToBeClassified;
            TableRelation = "Interaction Template" WHERE("Attachment No." = CONST(0));
        }
    }
}
