codeunit 50801 "WDC-ED RIB Key"
{

    trigger OnRun()
    begin
    end;

    procedure Check(Bank: Text; Agency: Text; Account: Text; RIBKey: Integer): Boolean
    var
        LongAccountNum: Code[30];
        Index: Integer;
        Remaining: Integer;
    begin
        if not ((StrLen(Bank) = 5) and
                (StrLen(Agency) = 5) and
                (StrLen(Account) = 11) and
                (RIBKey < 100))
        then
            exit(false);

        LongAccountNum :=
          CopyStr(Bank + Agency + Account + ConvertStr(Format(RIBKey, 2), ' ', '0'), 1, MaxStrLen(LongAccountNum));
        LongAccountNum := ConvertStr(LongAccountNum, Coding, Uncoding);

        Remaining := 0;
        for Index := 1 to 23 do
            Remaining := (Remaining * 10 + (LongAccountNum[Index] - '0')) mod 97;

        exit(Remaining = 0);
    end;

    var
        Coding: TextConst ENU = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                          FRA = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        Uncoding: TextConst ENU = '12345678912345678923456789',
                            FRA = '12345678912345678923456789';
}

