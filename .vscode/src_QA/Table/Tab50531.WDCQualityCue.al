table 50531 "WDC Quality Cue"
{
    CaptionML = ENU = 'Quality Cue', FRA = 'Quality Cue';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "QC Specification - Open"; Integer)
        {
            CalcFormula = count("WDC-QA Specification Header" where(Status = const(Open)));
            CaptionML = ENU = 'QC Specifications - Open', FRA = 'Spécifications CQ - Ouverts';
            FieldClass = FlowField;
        }
        field(3; "QC Specification - Certified"; Integer)
        {
            CalcFormula = count("WDC-QA Specification Header" where(Status = const(Certified)));
            CaptionML = ENU = 'QC Specification - Certified', FRA = 'Spécifications CQ - Certifiés';
            FieldClass = FlowField;
        }
        field(4; "QC Specification - Closed"; Integer)
        {
            CalcFormula = count("WDC-QA Specification Header" where(Status = const(Closed)));
            CaptionML = ENU = 'QC Specification - Closed', FRA = 'Spécifications CQ - Clôturés';
            FieldClass = FlowField;
        }
        field(5; "QC Registration - Open"; Integer)
        {
            CalcFormula = count("WDC-QA Registration Header" where(Status = const(Open), "Document Type" = const(QC)));
            CaptionML = ENU = 'QC Registration - Open', FRA = 'Enregistrements CQ - Ouverts';
            FieldClass = FlowField;
        }
        field(6; "QC Registration - Closed"; Integer)
        {
            CalcFormula = count("WDC-QA Registration Header" where(Status = const(Closed), "Document Type" = const(QC)));
            CaptionML = ENU = 'QC Registration - Closed', FRA = 'Enregistrements CQ - Clôturés';
            FieldClass = FlowField;
        }
        field(7; "CoA Rgistration - Open"; Integer)
        {
            CalcFormula = count("WDC-QA Registration Header" where(Status = const(Open), "Document Type" = const(CoA)));
            CaptionML = ENU = 'CoA Rgistration - Open', FRA = 'Certificats d''analyse - Ouverts';
            FieldClass = FlowField;
        }
        field(8; "CoA Rgistration - Closed"; Integer)
        {
            CalcFormula = count("WDC-QA Registration Header" where(Status = const(Closed), "Document Type" = const(CoA)));
            CaptionML = ENU = 'CoA Rgistration - Closed', FRA = 'Certificats d''analyse - Clôturés';
            FieldClass = FlowField;
        }
        field(9; "Released Prod. Orders - All"; Integer)
        {
            CalcFormula = count("Production Order" where(Status = const(Released)));
            Caption = 'Released Prod. Orders';
            FieldClass = FlowField;
        }
        field(10; "Planned Prod. Orders - All"; Integer)
        {
            CalcFormula = count("Production Order" where(Status = const(Planned)));
            Caption = 'Planned Prod. Orders';
            FieldClass = FlowField;
        }
        field(11; "Purchase Orders"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order)));
            Caption = 'Purchase Orders';
            FieldClass = FlowField;
        }
        field(12; "Ongoing Purchase Invoices"; Integer)
        {
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Invoice)));
            Caption = 'Ongoing Purchase Invoices';
            FieldClass = FlowField;
        }
        field(15; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}
