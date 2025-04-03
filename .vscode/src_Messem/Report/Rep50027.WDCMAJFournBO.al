//********************Documentation*************************
//WDC01  02/04/2025  HG  : Create current object 
report 50027 "WDC MAJ Fourn BO"
{
    CaptionML = FRA = 'MAJ Fourn BO', ENU = 'Update Vendor BO';
    TransactionType = UpdateNoLocks;
    UseRequestPage = true;
    ShowPrintStatus = true;
    ProcessingOnly = true;
    Permissions = TableData 17 = rimd,
                  TableData 32 = rimd,
                  TableData 36 = rimd,
                  TableData 37 = rimd,
                  TableData 110 = rimd,
                  TableData 111 = rimd,
                  TableData 5802 = rimd,
                  tableData 38 = rimd,
                  tableData 39 = rimd;



    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Document Type" = CONST("Blanket Order"));

            trigger OnAfterGetRecord()
            begin
                Gvendor.GET(NouveauCode);
                "Buy-from Vendor No." := Gvendor."No.";
                "Buy-from Vendor Name" := Gvendor.Name;
                "Buy-from Vendor Name 2" := Gvendor."Name 2";
                "Buy-from Address" := Gvendor.Address;
                "Buy-from City" := Gvendor.City;
                "Buy-from Contact" := Gvendor.Contact;
                "Invoice Disc. Code" := Gvendor."No.";
                "VAT Registration No." := Gvendor."VAT Registration No.";
                "Buy-from Post Code" := Gvendor."Post Code";
                "Buy-from County" := Gvendor.County;
                "Buy-from Country/Region Code" := Gvendor."Country/Region Code";
                "Buy-from Contact No." := Gvendor."Primary Contact No.";
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Document Type", "Document Type"::"Blanket Order");
                SETRANGE("No.", NumReceipt);
            end;
        }
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                Gvendor.GET(NouveauCode);
                "Buy-from Vendor No." := Gvendor."No.";
                MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Document Type", "Document Type"::"Blanket Order");
                SETRANGE("Document No.", NumReceipt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Numéro BO"; NumReceipt)
                {
                    Captionml = FRA = 'Numéro BO', ENU = 'BO No.';
                    TableRelation = "Purchase Header"."No." WHERE("Document Type" = FILTER("Blanket Order"));
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CLEAR(Gbo);
                        Gbo.SETRANGE("Document Type", Gbo."Document Type"::"Blanket Order");
                        Gbo.SETRANGE("No.", NumReceipt);
                        IF Gbo.FINDSET THEN
                            AncienCode := Gbo."Buy-from Vendor No."
                        ELSE
                            AncienCode := '';
                    end;
                }
                field("Ancien fournisseur"; AncienCode)
                {
                    TableRelation = Vendor;
                    ApplicationArea = all;
                    CaptionML = FRA = 'Ancien fournisseur', ENU = 'Old Vendor';
                }
                field("Nouveau fournisseur"; NouveauCode)
                {
                    TableRelation = Vendor;
                    ApplicationArea = all;
                    CaptionML = FRA = 'Nouveau fournisseur', ENU = 'New Vendor';
                }
            }
        }

        trigger OnAfterGetRecord()
        begin
            IF NumReceipt = '' THEN
                ERROR(Err002);
            IF AncienCode = '' THEN
                ERROR(Err003);
            IF NouveauCode = '' THEN
                ERROR(Err004);
        end;
    }


    trigger OnInitReport()
    begin
        IF Guser.GET(USERID) THEN
            IF NOT Guser."Mise à jour Fournisseur" THEN
                ERROR(Err001);
    end;

    trigger OnPostReport()
    begin
        MESSAGE(Text001);
    end;

    procedure ReplaceString(Description: Code[50]; ancien: Code[20]; nouveau: Code[20]): Code[50]
    begin
    end;

    procedure Numero(Numero: Code[20])
    begin
        NumReceipt := Numero;
        IF PurchaseReceipt.GET(NumReceipt) THEN
            AncienCode := PurchaseReceipt."Buy-from Vendor No."
        ELSE
            AncienCode := '';
    end;

    var
        NumReceipt: code[20];
        AncienCode: Code[20];
        NouveauCode: Code[20];
        PurchaseReceipt: record "Purch. Rcpt. Header";
        Gvendor: Record vendor;
        Err001: TextConst FRA = 'Vous n''avez pas le droit de modifier le fournisseur donneur d''ordre', ENU = 'You do not have the right to change the ordering supplier';
        Err002: TextConst FRA = 'Numéro de réception inexistant!!!', ENU = 'Reception number does not exist!!!';
        Err003: TextConst FRA = 'Ancien code fournisseur inexistant!!!', ENU = 'Old supplier code does not exist!!!';
        Err004: TextConst FRA = 'Nouveau code fournisseur inexistant!!!', ENU = 'New supplier code does not exist!!!';
        Text001: TextConst FRA = 'Numéro fournisseur changé avec succés!!', ENU = 'Supplier number successfully changed!!';
        GcontBrel: Record "Contact Business Relation";
        Guser: Record "User Setup";
        Gbo: Record "Purchase Header";
}

