table 50401 "WDC-TRS Trasport Order Header"
{
    CaptionMl = ENU = 'Trasport Order Header', FRA = 'Transport Tarif';
    DataClassification = ToBeClassified;
    DrillDownPageId = "WDC-TRS Transport Orders";
    LookupPageId = "WDC-TRS Transport Orders";
    fields
    {
        field(1; "No."; Code[20])
        {
            CaptionMl = ENU = 'No.', FRA = 'N°';
            Editable = false;
        }

        field(2; "Transport Type"; Enum "WDC-TRS Transport Type")
        {
            CaptionML = ENU = 'Transport Type', FRA = 'Type transport';
            Editable = false;
        }

        field(3; "Transport To"; Code[20])
        {
            CaptionML = ENU = 'Transport To', FRA = 'Transporter à';
            TableRelation = IF ("Transport Type" = CONST(Customer)) Customer."No."
            ELSE IF ("Transport Type" = CONST(Vendor)) Vendor."No.";
            Editable = false;
        }
        field(4; "Transport to Name"; Text[100])
        {
            CaptionMl = ENU = 'Name', FRA = 'Nom';
            Editable = false;
        }

        field(5; Desitnation; Text[500])
        {
            CaptionMl = ENU = 'Adress', FRA = 'Adresse';
        }
        field(7; City; Text[30])
        {
            CaptionMl = ENU = 'City', FRA = 'Ville';
        }
        field(8; "Phone No."; Text[30])
        {
            CaptionMl = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        field(9; "Post Code"; Code[20])
        {
            CaptionMl = ENU = 'Post Code', FRA = 'Code postal';
            TableRelation = "Post Code";
        }
        field(10; "Location Code"; Code[20])
        {
            CaptionMl = ENU = 'Location Code', FRA = 'Code magasin';
            TableRelation = Location;
        }
        field(11; "Posting Date"; Date)
        {
            CaptionMl = ENU = 'Posting Date', FRA = 'Date comptabilsation';
        }
        field(12; "Gross Weight"; Decimal)
        {
            CaptionMl = ENU = 'Gross Weight', FRA = 'Poids Brut';
        }
        field(13; "Net Weight"; Decimal)
        {
            CaptionMl = ENU = 'Net Weight', FRA = 'Poids Net';
        }
        field(14; "Status"; Enum "WDC-TRS Order Trasport Status")
        {
            CaptionMl = ENU = 'Status', FRA = 'Statut';
            Editable = false;
        }
        field(15; "Country Code"; Code[20])
        {
            CaptionML = ENU = 'Country Code', FRA = 'Code Pays';
            TableRelation = "Country/Region";
        }
        field(16; "Origin Order No."; Code[20])
        {
            CaptionML = ENU = 'Origine Order No.', FRA = 'No. commande Source';
            Editable = false;
        }
        field(17; "Vendor No."; Code[20])
        {
            CaptionMl = ENU = 'Vendor No.', FRA = 'N° fournisseur';
            TableRelation = Vendor WHERE(Transporter = CONST(True));
            trigger OnValidate()
            var
                lVendor: Record Vendor;
            begin
                Rec."Vendor Name" := '';
                if lVendor.get("Vendor No.") Then begin
                    Rec."Vendor Name" := lVendor.Name;
                end;
            end;
        }
        field(18; "Vendor Name"; Text[100])
        {
            CaptionMl = ENU = 'Vendor Name', FRA = 'Nom fournisseur';
            Editable = false;
        }

        field(19; Driver; code[20])
        {
            CaptionML = ENU = 'Driver', FRA = 'Chauffeur';

        }
        field(20; "Comment"; Text[500])
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        field(21; "Purchase Order No."; code[20])
        {
            CaptionML = ENU = 'Purchase Order No.', FRA = 'N° commande achat';
            Editable = false;
            TableRelation = "Purchase Header"."No." where("No." = field("Purchase Order No."),
                                                          "Transport Order" = const(true));
        }
        field(23; "Currency Code"; code[20])
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
            TableRelation = Currency;
        }

        field(24; Amount; Decimal)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        field(25; "Shipment Method code"; code[20])
        {
            CaptionML = ENU = 'Shipment Method code', FRA = 'Condition livraison';
            TableRelation = "Shipment Method";
            Editable = false;
        }
        field(26; "External Doc No."; code[20])
        {
            CaptionML = ENU = 'External Doc No.', FRA = 'N° doc externe';
            Editable = false;

        }
        field(27; "Purchase Receip No."; code[20])
        {
            CaptionML = ENU = '"Purchase Receip No."', FRA = 'N° réception achat';
            Editable = false;

        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit "No. Series";
        lSalesSetup: Record "Sales & Receivables Setup";
    begin
        lSalesSetup.get;
        "Posting Date" := WorkDate();
        "No." := NoSeriesMgt.GetNextNo(lSalesSetup."Transport Order Nos.", WorkDate(), FALSE);
    end;

    trigger OnDelete()
    var
        lTransportLines: record "WDC-TRS Trasport Order Line";
        lPurchaseHeader: Record "Purchase Header";
    begin
        lTransportLines.Reset();
        lTransportLines.SetRange("Document No.", rec."No.");
        lTransportLines.DeleteAll();

        lPurchaseHeader.reset;
        lPurchaseHeader.SetRange("Document Type", lPurchaseHeader."Document Type"::Order);
        lPurchaseHeader.SetRange("No.", rec."Purchase Order No.");
        lPurchaseHeader.SetRange("Transport Order", true);
        if lPurchaseHeader.FindFirst() then
            Insert(true);
    end;
}
