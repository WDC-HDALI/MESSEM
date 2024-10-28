table 50504 "WDC-QA Quality Control Setup"
{
    CaptionML = ENU = 'Quality Control Setup', FRA = 'Configuration contrôle qualité';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        field(2; "Equipment Nos."; Code[20])
        {
            CaptionML = ENU = 'Equipment No.', FRA = 'N° équipement';
            TableRelation = "No. Series";
        }
        field(3; "QC Specification Nos."; Code[20])
        {
            CaptionML = ENU = 'QC Specification Nos.', FRA = 'N° spécification CQ';
            TableRelation = "No. Series";
        }
        field(4; "QC Registration Nos."; Code[20])
        {
            CaptionML = ENU = 'QC Registration Nos. ', FRA = 'N° enregistrement CQ';
            TableRelation = "No. Series";
        }
        field(5; "Calibration Reg. Nos."; Code[20])
        {
            CaptionML = ENU = 'Calibration Reg. Nos.', FRA = 'N° enregistrement calibration';
            TableRelation = "No. Series";
        }
        field(6; "Calibration Spec.Nos."; Code[20])
        {
            CaptionML = ENU = 'Calibration Spec.Nos.', FRA = 'N° spécification calibration';
            TableRelation = "No. Series";
        }
        field(7; "CoA Registration Nos."; Code[20])
        {
            CaptionML = ENU = 'CoA Registration Nos.', FRA = 'N° enregistrement certificat d''analyse';
            TableRelation = "No. Series";
        }
        field(8; "Initial Calibration Version"; Code[20])
        {
            CaptionML = ENU = 'Initial Calibration Version', FRA = 'Version calibration initiale';
        }
        field(9; "Initial QC Spec. Version"; Code[20])
        {
            CaptionML = ENU = 'Initial QC Spec. Version', FRA = 'Version spéc. CQ initiale';
        }
        field(10; "Method Nos."; Code[20])
        {
            CaptionML = ENU = 'Method Nos.', FRA = 'N° méthode';
            TableRelation = "No. Series";
        }
        field(11; "QC Photo Path"; Text[250])
        {
            CaptionML = ENU = 'QC Photo Path', FRA = 'Contrôle en sortie';
            trigger OnLookup()
            var
                FileManagement: Codeunit "File Management";
                FilePath: Text;
                Selected: Boolean;
            begin
                // FilePath := "QC Photo Path";
                // Selected := FileManagement.SelectFolderDialog(SaveFolderMsg, FilePath);
                // IF Selected THEN
                //     "QC Photo Path" := COPYSTR(FilePath, 1, 250);
            end;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
