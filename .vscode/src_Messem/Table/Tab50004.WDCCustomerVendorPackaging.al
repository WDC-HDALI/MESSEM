table 50004 "WDC Customer/Vendor Packaging"
{
    CaptionML = ENU = 'Customer/Vendor Packaging', FRA = 'Client/Fournisseur Emballage';
    DataClassification = ToBeClassified;
    DrillDownPageID = 50002;
    LookupPageID = 50002;


    fields
    {
        field(1; "Source Type"; Integer)
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
        }
        field(2; "Source No."; Code[20])
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
            TableRelation = IF ("Source Type" = CONST(18)) Customer."No."
            ELSE IF ("Source Type" = CONST(23)) Vendor."No.";
        }

        field(3; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
            TableRelation = "WDC Packaging";
            trigger OnValidate()
            begin

                IF Packaging.GET(Code) THEN BEGIN
                    Description := Packaging.Description;
                    "Item No." := Packaging."Item No.";
                    "Register Balance" := Packaging."Register Balance";
                    Type := Packaging.Type;
                END ELSE BEGIN
                    Description := '';
                    "Item No." := '';
                    "Register Balance" := FALSE;
                    Type := Type::"Shipment Unit";
                END;
            end;

        }
        field(4; Description; TEXT[100])
        {
            Captionml = ENU = 'Description', FRA = 'Désignation';
        }
        field(5; Print; Boolean)
        {
            CaptionML = ENU = 'Print', FRA = 'Imprimer';
            InitValue = true;
        }
        field(6; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
            TableRelation = Item;
        }
        field(7; "Location Filter"; Code[20])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
        }
        field(8; balance; Decimal)
        {
            CaptionML = ENU = 'Actual Balance', FRA = 'Solde actuel';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Balance Reg. Customer/Vend.No." = FIELD("Source No."), "Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Filter")));
        }
        field(9; "Register Balance"; Boolean)
        {
            CaptionML = ENU = 'Register Balance', FRA = 'Enregistrer solde';
        }
        field(10; "Balance Reg. Shipping Agent"; Boolean)
        {
            CaptionML = ENU = 'Balance Registration Shipping Agent', FRA = 'Enregistrer solde transporteur ';
        }
        field(11; Type; enum "WDC Packaging Type")
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
        }
        field(12; "Invoice To Shipping Agent"; Boolean)
        {
            CaptionML = ENU = 'Invoice to Shipping Agent', FRA = 'Facture pour transporteur';
        }
        field(13; "Start Posting Date Filter"; Date)
        {
            captionml = ENU = 'Start Posting Date Filter', FRA = 'Filtre date début comptabilisation';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(14; "External Document No. Filter"; Code[20])
        {
            captionMl = ENU = 'External Document No. Filter', FRA = 'Filtre n° document externe';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(15; "Document No. Filter"; Code[20])
        {
            CaptionML = ENU = 'Document No. Filter', FRA = 'Filtre N° document';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(16; "End Posting Date Filter"; Date)
        {
            captionMl = ENU = 'End Posting Date Filter', FRA = 'Filtre date fin comptabilisation';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(17; "Range Posting Date Filter"; Date)
        {
            captionML = ENU = 'Range Posting Date Filter', FRA = 'Filtre plage date comptabilisation';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(18; "Packaging Consolidation No."; Code[20])
        {
            captionML = ENU = 'Packaging Consolidation No.', FRA = 'N° regroupement emballage';
            Editable = false;
        }
        field(19; "Name Packaging Cons. No."; Text[50])
        {
            captionML = ENU = 'Name Packaging Cons. No.', FRA = 'Nom regroupement emballage';
            Editable = false;
        }
        field(20; "Starting Balance"; Decimal)
        {
            CaptionML = ENU = 'Starting Balance', FRA = 'Solde début';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Balance Reg. Customer/Vend.No." = FIELD("Source No."), "Item No." = FIELD("Item No."), "Location Code" = FIELD("Location Filter"), "Posting Date" = FIELD("Start Posting Date Filter"), "Document No." = FIELD("Document No. Filter"), "External Document No." = FIELD("External Document No. Filter")));
        }
        field(21; "Ending Balance"; Decimal)
        {
            CaptionML = ENU = 'Ending Balance', FRA = 'Solde final';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Balance Reg. Customer/Vend.No." = FIELD("Source No."),
                                                                   "Item No." = FIELD("Item No."),
                                                                   "Location Code" = FIELD("Location Filter"),
                                                                   "Posting Date" = FIELD("End Posting Date Filter"),
                                                                   "Document No." = FIELD("Document No. Filter"),
                                                                   "External Document No." = FIELD("External Document No. Filter")));


        }
        field(22; "Balance Normal"; Decimal)
        {
            CaptionML = ENU = 'Balance Normal', FRA = 'Solde normal';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Balance Reg. Customer/Vend.No." = FIELD("Source No."),
                                                                   "Item No." = FIELD("Item No."),
                                                                   "Location Code" = FIELD("Location Filter"),
                                                                   "Posting Date" = FIELD("Range Posting Date Filter"),
                                                                   "Balance Registration Direction" = CONST("Outbound"),
                                                                   "Document No." = FIELD("Document No. Filter"),
                                                                   "External Document No." = FIELD("External Document No. Filter")));
        }
        field(23; "Balance Return"; Decimal)
        {
            captionml = ENU = 'Balance Return', FRA = 'Solde retour';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Item Ledger Entry".Quantity WHERE("Balance Reg. Customer/Vend.No." = FIELD("Source No."),
                                                                   "Item No." = FIELD("Item No."),
                                                                   "Location Code" = FIELD("Location Filter"),
                                                                   "Posting Date" = FIELD("Range Posting Date Filter"),
                                                                   "Balance Registration Direction" = CONST("Inbound"),
                                                                   "Document No." = FIELD("Document No. Filter"),
                                                                   "External Document No." = FIELD("External Document No. Filter")));

        }
        field(24; "Source Type Filter"; Enum "WDC Packaging Type Filter")
        {
            Caption = 'Source Type Filter';
            FieldClass = FlowFilter;
        }


    }




    keys
    {
        key(Key1; "Source Type", "Source No.", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Source Type", "Source No.")
        {
        }
    }
    procedure IsShippingAgent(): Boolean
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        CASE "Source Type" OF
            DATABASE::Customer:
                ShippingAgent.SETRANGE("Customer No.", "Source No.");
            DATABASE::Vendor:
                ShippingAgent.SETRANGE("Vendor No.", "Source No.");
        END;

        EXIT(NOT ShippingAgent.ISEMPTY);
    end;

    var
        Customer: record Customer;
        Vendor: record Vendor;
        Packaging: Record "WDC Packaging";

}
