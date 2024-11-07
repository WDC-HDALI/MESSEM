namespace MESSEM.MESSEM;

using Microsoft.Inventory.Tracking;
using Microsoft.Purchases.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Journal;

pageextension 50016 "WDC Item Tracking Lines" extends "Item Tracking Lines"
{
    layout
    {

        addlast(Control1)
        {

            field(LotAttributes1; LotAttributes[1])
            {
                ApplicationArea = all;
                CaptionClass = '13,1,1';
                TableRelation = "WDC Lot Attribute Value".Code WHERE(
                  "Lot Attribute No." = CONST("WDC Lot Attribute"::"1"));

                trigger OnValidate()
                begin
                    ModifyLotAttributes;
                end;

            }
            field(LotAttributes2; LotAttributes[2])
            {
                ApplicationArea = all;
                CaptionClass = '13,1,2';
                Editable = LotAttributesEditable;
                TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"2"));

                trigger OnValidate()
                begin
                    ModifyLotAttributes;
                end;
            }
            field(LotAttributes3; LotAttributes[3])
            {
                ApplicationArea = all;
                CaptionClass = '13,1,3';
                Editable = LotAttributesEditable;
                TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"3"));

                trigger OnValidate()
                begin
                    ModifyLotAttributes;
                end;
            }
            field(LotAttributes4; LotAttributes[4])
            {
                ApplicationArea = all;
                CaptionClass = '13,1,4';
                Editable = LotAttributesEditable;
                TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"4"));

                trigger OnValidate()
                begin
                    ModifyLotAttributes;
                end;

            }
            field(LotAttributes5; LotAttributes[5])
            {
                ApplicationArea = all;
                CaptionClass = '13,1,5';
                Editable = LotAttributesEditable;
                TableRelation = "WDC Lot Attribute Value".Code WHERE("Lot Attribute No." = CONST("WDC Lot Attribute"::"5"));

                trigger OnValidate()
                begin
                    ModifyLotAttributes;
                end;

            }

        }
    }
    var
        LotAttributes: array[5] of Code[20];
        LotNoRequiredErr: TextConst ENU = 'Cannot assign Lot Attributes without Lot No.', FRA = 'Impossible d''attribuer des attributs sans numéro de lot. »';
        TextSI003: TextConst ENU = 'Consignment Management in use.', FRA = 'Gestion des expéditions en cours d''utilisation.';
        LotAttributesEditable: Boolean;
        LotAttributeManagement: Codeunit "WDC Lot Attribute Mngmt";

    local procedure SetLotAttributesEditable(pTrackingSpec: Record "Tracking Specification")
    Begin
        IF ((pTrackingSpec."Source Type" = DATABASE::"Item Journal Line") AND (pTrackingSpec."Source Subtype" IN [2, 6])) OR
            ((pTrackingSpec."Source Type" = DATABASE::"Purchase Line") AND (pTrackingSpec."Source Subtype" IN [0, 1, 2, 4])) OR
            (pTrackingSpec."Source Type" = DATABASE::"Prod. Order Line") THEN
            LotAttributesEditable := TRUE;
    End;

    local procedure GetAtrributes()
    begin
        CLEAR(LotAttributes);
        IF Rec."Lot No." <> '' THEN
            LotAttributeManagement.GetLotAttributes(LotAttributes, Rec."Item No.", Rec."Variant Code", Rec."Lot No.", Rec."Source Type", Rec."Source Subtype", Rec."Source ID", Rec."Source Ref. No.", Rec."Source Batch Name", Rec."Source Prod. Order Line");
    end;

    local procedure ModifyLotAttributes()
    var
        TempTrackingSpecification: Record 336 temporary;
    begin
        IF Rec."Lot No." <> '' THEN BEGIN
            LotAttributeManagement.ModifyLotAttributes(LotAttributes, Rec."Item No.", Rec."Variant Code", Rec."Lot No.", Rec."Source Type", Rec."Source Subtype", Rec."Source ID", Rec."Source Ref. No.", Rec."Source Batch Name", Rec."Source Prod. Order Line");
            CurrPage.UPDATE;
        END ELSE
            ERROR(LotNoRequiredErr);
    end;

}
