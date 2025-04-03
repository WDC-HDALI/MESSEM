namespace Messem.Messem;

using Microsoft.Manufacturing.Setup;

tableextension 50504 "WDC-QA Manufacturing Setup" extends "Manufacturing Setup"
{
    fields
    {
        field(50500; "Expiration Date"; Date)
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date éxpiration';
            DataClassification = ToBeClassified;
        }
        field(50501; "Production Date"; Date)
        {
            CaptionML = ENU = 'Production Date', FRA = 'Date production';
            DataClassification = ToBeClassified;
        }

    }
}
