namespace Messem.Messem;

using Microsoft.Foundation.Company;

tableextension 50505 "WDC-QA Company Information" extends "Company Information"
{
    fields
    {
        field(50000; Background; Blob)
        {
            CaptionML = ENU = 'Background', FRA = 'Arrière-plans';
            DataClassification = ToBeClassified;
            SubType = Bitmap;

            trigger OnValidate()
            begin
                // PictureUpdated := true;
            end;
        }
    }
}
