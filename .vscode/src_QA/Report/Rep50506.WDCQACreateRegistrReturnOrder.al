report 50506 "WDC-QACreateRegistrReturnOrder"
{
    CaptionML = ENU = 'Create Registr. Return Order', FRA = 'Créer retour enregistré';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Registration Header"; "WDC-QA Registration Header")
        {

            trigger OnAfterGetRecord()
            begin
                IF "Registration Header"."Lot No." <> '' THEN
                    IF RegQty = 0 THEN
                        ERROR(Text0001);

                CASE CustVendType OF
                    CustVendType::Customer:
                        QualityControlMgt.CreateSalesReturnOrder("Registration Header", CustVendNo, RegQty, RegUOM, ShowReturnOrder);
                    CustVendType::Vendor:
                        QualityControlMgt.CreatePurchaseReturnOrder("Registration Header", CustVendNo, RegQty, RegUOM, ShowReturnOrder);
                END;
            end;

            trigger OnPreDataItem()
            begin
                ShowReturnOrder := ("Registration Header".COUNT = 1);
                IF NOT ShowReturnOrder THEN
                    IF NOT CONFIRM(Text0002, FALSE) THEN
                        ERROR('');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', FRA = 'Options';
                    field(RegQty; RegQty)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Quantity', FRA = 'Quantité';
                        DecimalPlaces = 0 : 2;
                        trigger OnValidate()
                        begin
                            RegQtyOnAfterValidate;
                        end;
                    }
                    field(RegUOM; RegUOM)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
                        TableRelation = "Unit of Measure";

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemUnitofMeasure: Record "Item Unit of Measure";
                        begin
                            ItemUnitofMeasure.SETRANGE("Item No.", ItemNo);
                            IF PAGE.RUNMODAL(PAGE::"Item Units of Measure", ItemUnitofMeasure) = ACTION::LookupOK THEN
                                RegUOM := ItemUnitofMeasure.Code;
                        end;

                        trigger OnValidate()
                        var
                            ItemUnitofMeasure: Record "Item Unit of Measure";
                        begin
                            ItemUnitofMeasure.GET(ItemNo, RegUOM);
                        end;
                    }
                    field(CustVendType; CustVendType)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Type', FRA = 'Type';
                        OptionCaptionML = ENU = ' ,Customer,Vendor', FRA = ' ,Client,Fournisseur';
                        trigger OnValidate()
                        begin
                            CustVendTypeOnAfterValidate;
                        end;
                    }
                    field(CustVendNo; CustVendNo)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'No.', FRA = 'N°';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CASE CustVendType OF
                                CustVendType::Customer:
                                    BEGIN
                                        IF PAGE.RUNMODAL(0, Customer) = ACTION::LookupOK THEN
                                            CustVendNo := Customer."No.";
                                    END;
                                CustVendType::Vendor:
                                    BEGIN
                                        IF PAGE.RUNMODAL(0, Vendor) = ACTION::LookupOK THEN
                                            CustVendNo := Vendor."No.";
                                    END;
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            CustVendNoOnAfterValidate;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF CustVendType = CustVendType::" " THEN
            ERROR(Text0003);

        IF CustVendNo = '' THEN
            ERROR(Text0004);
    end;

    procedure SetItemNo(ItemNo2: Code[20])
    begin
        ItemNo := ItemNo2
    end;

    local procedure CustVendTypeOnAfterValidate()
    begin
        CustVendNo := '';
    end;

    local procedure CustVendNoOnAfterValidate()
    begin
        CASE CustVendType OF
            CustVendType::Customer:
                Customer.GET(CustVendNo);
            CustVendType::Vendor:
                Vendor.GET(CustVendNo);
        END;
    end;

    local procedure RegQtyOnAfterValidate()
    begin
        RegUOM := '';
    end;

    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        RegQty: Decimal;
        CustVendNo: Code[20];
        RegUOM: Code[20];
        Text0001: TextConst ENU = 'The quantity for the return order is required.', FRA = 'la quantité pour la commande de retour est requise';
        Text0002: TextConst ENU = 'Do you want to create a return order for the selected registrations?', FRA = 'Voulez-vous créer un retour pour les enregistrements sélectionnés ?';
        Text0003: TextConst ENU = 'Select a type.', FRA = 'Sélectionner un type.';
        Text0004: TextConst ENU = 'The customer- or vendor number is required.', FRA = 'Le numéro client ou fournisseur est requis';
        ItemNo: Code[20];
        CustVendType: Option " ",Customer,Vendor;
        ShowReturnOrder: Boolean;
        QualityControlMgt: Codeunit "WDC-QC Quality Control Mgt.";
}

