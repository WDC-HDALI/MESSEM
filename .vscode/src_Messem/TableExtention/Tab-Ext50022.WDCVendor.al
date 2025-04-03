namespace MESSEM.MESSEM;

using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Inventory.Ledger;

tableextension 50022 "WDC Vendor " extends Vendor
{
    fields
    {
        field(50000; Transporter; Boolean)
        {
            CaptionML = ENU = 'Transporter', FRA = 'Transporteur';
            DataClassification = ToBeClassified;
        }

        field(50002; "Packaging Price"; Boolean)
        {
            CaptionML = ENU = 'Packaging Price', FRA = 'Facturer emballage';
            DataClassification = ToBeClassified;
        }
        field(50003; "Purchases (Qty.)"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = filter(Purchase),
                                                                  "Posting Date" = FIELD("Date Filter"),
                                                                  "Source No." = FIELD("No."),
                                                                  "Item No." = field("Item Filter"),
                                                                  "Item Category Code" = field("Item Category Filter"),
                                                                  "Source Type" = filter(Vendor)));
            CaptionML = ENU = 'Purchases (Qty.)', FRA = 'Qty achat';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }


        field(50004; RIB; Code[24])
        {
            Caption = 'RIB';
            DataClassification = ToBeClassified;
        }
        field(50005; ICE; Code[20])
        {
            Caption = 'ICE';
            Description = 'WDC01';
            DataClassification = ToBeClassified;
        }
        field(50006; "Solde Bonus"; Decimal)
        {
            CalcFormula = Sum("WDC Rebate Entry"."Accrual Amount (LCY)" WHERE("Buy-from No." = FIELD("No."),
                                                                       Open = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
            CaptionML = ENU = 'Solde Bonus', FRA = 'Solde Bonus';
        }
        field(50007; "Convention Y/N"; Boolean)
        {
            CaptionML = ENU = 'Convention O/N', FRA = 'Convention O/N';
            Description = 'WDC02  DELAI DE PAIEMENT';
            DataClassification = ToBeClassified;
        }
        field(50008; "Payment Terms Convention"; Code[20])
        {
            CaptionML = ENU = 'Payment Terms Code', FRA = 'Code termes paiement';
            Description = 'WDC02  DELAI DE PAIEMENT';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(50009; "No. RC"; Code[20])
        {
            CaptionML = ENU = 'No. RC', FRA = 'No. RC';
            Description = 'WDC02  DELAI DE PAIEMENT';
            DataClassification = ToBeClassified;
        }
        field(50010; "Banque"; Code[20])
        {
            CaptionML = ENU = 'Default Bank', FRA = 'Banque par defaut';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Bank Account".Code WHERE("Vendor No." = FIELD("No."));

            trigger OnValidate()
            var
                RecLBanque: Record 288;
            begin

                IF Banque <> '' THEN BEGIN
                    RecLBanque.RESET;
                    RecLBanque.SETRANGE("Vendor No.", "No.");
                    RecLBanque.SETRANGE(Code, Banque);
                    IF RecLBanque.FINDSET THEN
                        RIB := RecLBanque."Bank Account No.";
                END;
            end;

        }
        field(50011; "Item Filter"; Code[20])
        {
            CaptionML = ENU = 'Item Filter', FRA = 'Filtre article';
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(50012; "Item Category Filter"; Code[20])
        {
            CaptionML = ENU = 'Item Category Filter', FRA = 'Filtre Categorie article';
            FieldClass = FlowFilter;
            TableRelation = "Item Category";
        }

    }

}
