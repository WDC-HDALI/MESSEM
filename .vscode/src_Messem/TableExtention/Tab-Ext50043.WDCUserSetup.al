namespace Messem.Messem;

using System.Security.User;

tableextension 50043 "WDC User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "Check Accounting"; Boolean)
        {
            CaptionML = ENU = 'Check Accounting', FRA = 'Vérif Compta';
            DataClassification = ToBeClassified;
        }
        field(50001; "Item Added"; Boolean)
        {
            CaptionML = ENU = 'Item Added', FRA = 'MAJ article';
            DataClassification = ToBeClassified;
        }
        field(50002; "BOM Modification"; Boolean)
        {
            CaptionML = ENU = 'BOM Modification', FRA = 'Modification de nomenclature';
            DataClassification = ToBeClassified;
        }
        field(50003; "Routing Modification"; Boolean)
        {
            CaptionML = ENU = 'Routing Modification', FRA = 'Modification de la gamme';
            DataClassification = ToBeClassified;
        }
        // field(50004; "G/L Account"; Boolean) //Field replaced by Field 50000
        // {
        //     CaptionML = ENU = 'Allow G/L Account', FRA = 'Voir Compte Comptable';
        // }
        field(50004; "G/L Account 2/6"; Boolean)
        {
            CaptionML = ENU = 'G/L Account 2/6 Allowed', FRA = 'Voir Compte Comptable 2/6';
        }
    }
}
