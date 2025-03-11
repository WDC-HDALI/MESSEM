namespace Messem.Messem;

using Microsoft.Manufacturing.ProductionBOM;
using System.Security.User;

tableextension 50044 "WDC Production BOM Header" extends "Production BOM Header"
{
    fields
    {
        modify(Status)
        {
            trigger OnBeforeValidate()
            var
                lUserSetup: Record "User Setup";
            begin
                lUserSetup.Get(UserId);
                lUserSetup.TestField("BOM Modification", true);
            end;
        }
    }
}
