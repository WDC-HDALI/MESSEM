page 50407 "WDC Enter Carrier Code"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    CaptionML = ENG = 'Enter Carrier Code',
                FRA = 'Saisie Code transporteur';

    layout
    {
        area(Content)
        {
            field(CarrierCode; CarrierCode)
            {
                ApplicationArea = All;
                CaptionML = ENG = 'Carrier Code',
                            FRA = 'Code transporteur';
                TableRelation = "Shipping Agent".Code;
            }
        }
    }

    var
        CarrierCode: Code[20];

    procedure SetCarrierCode(DefaultCode: Code[20])
    begin
        CarrierCode := DefaultCode;
    end;

    procedure GetCode(): Code[20]
    begin
        exit(CarrierCode);
    end;
}