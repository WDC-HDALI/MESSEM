tableextension 50019 "WDC GL Account" extends "G/L Account"
{
    fields
    {
        field(50000; "Purchase GL account"; Text[50])
        {
            CaptionML = ENU = 'Name 2', FRA = 'N° compte général achat', NLD = 'Naam 2';
            DataClassification = ToBeClassified;
        }
        field(50001; "G/L Entry Type Filter"; Enum "WDC GL Entry Type")
        {
            CaptionML = ENU = 'G/L Entry Type Filter', FRA = 'N° compte général achat';
            FieldClass = FlowFilter;
        }
        field(50002; "Rebate G/L Account"; Boolean)
        {
            CaptionML = ENU = 'Rebate G/L Account', FRA = 'Compte général bonus';
            DataClassification = ToBeClassified;

        }
    }
    trigger OnInsert()
    var
        lUserSetup: Record "User Setup";
    begin
        lUserSetup.get(UserId);
        lUserSetup.TestField("Check Accounting", true);
    end;
}
