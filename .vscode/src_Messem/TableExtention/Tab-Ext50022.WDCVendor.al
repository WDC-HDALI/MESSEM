namespace MESSEM.MESSEM;

using Microsoft.Purchases.Vendor;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Inventory.Ledger;

tableextension 50022 "WDC Vendor " extends Vendor
{
    fields
    {
        field(50000; Transporter; Boolean)
        {
            CaptionML = ENU = 'Transporter', FRA = 'Fournisseur transport';
            DataClassification = ToBeClassified;
        }

        field(50001; "Transport Tariff Code"; code[20])
        {
            CaptionML = ENU = 'Transport Tariff Code', FRA = 'Code tarif transport';
            DataClassification = ToBeClassified;
            TableRelation = "WDC Transport Tariff Code";
        }
        field(50002; "Packaging Price"; Boolean)
        {
            CaptionML = ENU = 'Packaging Price', FRA = 'Facturer emballage';
            DataClassification = ToBeClassified;
        }
        // field(50003; "Purchases (Qty.)"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Entry Type" = filter(Purchase),
        //                                                           "Posting Date" = FIELD("Date Filter"),
        //                                                           "Source No." = FIELD("No."),
        //                                                           "Source Type" = filter(Vendor)));
        //     CaptionML = ENU = 'Purchases (Qty.)', FRA = 'Qty achat';
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }


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
            CalcFormula = Sum("WDC Rebate Entry"."Accrual Amount (LCY)" WHERE("Posting Type" = CONST(Purchase),
                                                                       "Sell-to/Buy-from No." = FIELD("No."),
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

    }

}
