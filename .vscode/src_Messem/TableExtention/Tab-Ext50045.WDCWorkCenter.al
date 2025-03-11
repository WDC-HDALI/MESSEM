namespace Messem.Messem;

using Microsoft.Manufacturing.WorkCenter;
using System.Security.User;

tableextension 50045 "WDC Work Center" extends "Work Center"
{
    fields
    {
        modify("Direct Unit Cost")
        {
            trigger OnBeforeValidate()
            var
                lUserSetup: Record "User Setup";
            begin
                lUserSetup.Get(UserId);
                lUserSetup.TestField("Routing Modification", true);
            end;
        }
        modify("Unit Cost")
        {
            trigger OnBeforeValidate()
            var
                lUserSetup: Record "User Setup";
            begin
                lUserSetup.Get(UserId);
                lUserSetup.TestField("Routing Modification", true);
            end;
        }
    }
}
