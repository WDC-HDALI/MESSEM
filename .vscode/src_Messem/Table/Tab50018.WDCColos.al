table 50018 "WDC Colos"
{
    CaptionML = ENU = 'Colos', FRA = 'Colos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Num_OF; Code[20])
        {
            Caption = 'Num_OF';
        }
        field(2; Nom_Article_Anglais; Text[250])
        {
            Caption = 'Nom_Article_Anglais';
        }
        field(3; "Nom_Article_Français"; Text[250])
        {
            Caption = 'Nom_Article_Français';
        }
        field(4; Num_Article; Code[20])
        {
            Caption = 'Num_Article';
        }
        field(5; Num_Lot; Code[20])
        {
            Caption = 'Num_Lot';
        }
        field(6; Poids_Net; Text[100])
        {
            Caption = 'Poids_Net';
        }
        field(7; Type_Etiq; Text[20])
        {
            Caption = 'Type_Etiq';
        }
        field(8; "No."; Integer)
        {
            Caption = 'No.';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
