page 50002 "WDC Customer/Vendor Packaging"
{
    ApplicationArea = All;
    captionml = ENU = 'Customer/Vendor Packaging', FRA = 'Client/Fournisseur Emballage';
    PageType = Worksheet;
    SourceTable = "WDC Customer/Vendor Packaging";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(StartingDateFilter; StartingDateFilter)
                {
                    captionml = ENU = 'Starting Date Filter', FRA = 'Filtre date début';
                    trigger OnValidate()

                    begin

                        IF EndingDateFilter < StartingDateFilter THEN
                            ERROR(Text001);
                        SetRecFilters;
                    end;
                }
                field(EndingDateFilter; EndingDateFilter)
                {
                    captionml = ENU = 'Ending Date Filter', FRA = 'Filtre date fin';

                    trigger OnValidate()

                    begin
                        IF EndingDateFilter = 0D THEN
                            ERROR(Text000, rec."End Posting Date Filter");
                        IF (EndingDateFilter < StartingDateFilter) THEN
                            ERROR(Text002);
                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;
                }
                field(ExternDocNoFilter; ExternDocNoFilter)
                {
                    CaptionML = ENU = 'External DocumentNo. Filter', FRA = 'Filtre N° doc. externe';
                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;


                }
                field(DocNoFilterCtrl; DocNoFilter)
                {
                    CaptionML = ENU = 'Document No. Filter', FRA = 'Filtre N° document';
                    trigger OnValidate()
                    begin
                        CurrPage.SAVERECORD;
                        SetRecFilters;
                    end;



                }
            }
            repeater(control1)
            {
                field("Source No."; rec."Source No.")
                {
                    Visible = false;
                }
                field("Source Name"; GetSourceName)
                {
                    CaptionML = ENU = 'Name', FRA = 'Nom';
                }
                field(Code; rec.Code)
                {
                }
                field(Description; rec.Description)
                {
                }
                field(Type; rec.Type)
                {
                }
                field("Register Balance"; rec."Register Balance")
                {
                }
                field("Balance Reg. Shipping Agent"; rec."Balance Reg. Shipping Agent")
                {
                }
                field("Invoice To Shipping Agent"; rec."Invoice To Shipping Agent")
                {
                    Visible = false;
                }
                field("Starting Balance"; rec."Starting Balance")
                {
                }
                field("Balance Normal"; rec."Balance Normal")
                {
                }
                field("Balance Return"; rec."Balance Return")
                {
                }
                field("Ending Balance"; rec."Ending Balance")
                {
                }
                field(Balance; rec.Balance)
                {
                }
                field(Print; rec.Print)
                {
                    Visible = false;

                }
            }
        }

    }
    trigger OnOpenPage()
    begin
        if EndingDateFilter = 0D then
            EndingDateFilter := WORKDATE;
        SetRecFilters;
    end;

    procedure GetSourceName(): TEXT[30]
    begin
        CASE rec."Source Type" OF
            DATABASE::Customer:
                IF Customer.GET(rec."Source No.") THEN
                    EXIT(Customer.Name);
            DATABASE::Vendor:
                IF Vendor.GET(rec."Source No.") THEN
                    EXIT(Vendor.Name);
        end;
    end;

    procedure SetRecFilters()
    begin
        rec.SETFILTER(rec."Start Posting Date Filter", '<%1', StartingDateFilter);
        rec.SETFILTER(rec."End Posting Date Filter", '<=%1', EndingDateFilter);
        rec.SETFILTER(rec."Range Posting Date Filter", '%1..%2', StartingDateFilter, EndingDateFilter);
        IF ExternDocNoFilter <> '' THEN
            rec.SETRANGE(rec."External Document No. Filter", ExternDocNoFilter)
        ELSE
            rec.SETRANGE(rec."External Document No. Filter");

        IF DocNoFilter <> '' THEN
            rec.SETFILTER(rec."Document No. Filter", DocNoFilter)
        ELSE
            rec.SETRANGE(rec."Document No. Filter");

        CurrPage.UPDATE(FALSE);

    end;

    var
        customer: Record customer;
        vendor: record vendor;
        StartingDateFilter: date;
        EndingDateFilter: date;
        ExternDocNoFilter: text[250];
        DocNoFilter: text[250];

        Text000: TextConst ENU = '%1 is mandatory.', FRA = '%1 est obligatoire.';
        Text001: TextConst ENU = 'Startingdate has to be before endingdate.', FRA = 'Date début doit être avant date de fin';
        Text002: TextConst ENU = 'Endingdate has to be after Startingdate.', FRA = 'Date de fin doit être postérieure à date de début';
}



