namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;

tableextension 50518 "WDC-QA Tracking Specification" extends "Tracking Specification"
{
    procedure SetTempTrackingSpecification(TrackingSpecification: Record "Tracking Specification")
    begin
        TempTrackingSpecification.INIT;
        TempTrackingSpecification := TrackingSpecification
    end;

    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
}
