namespace MESSEM.MESSEM;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Manufacturing.Routing;
using Microsoft.Inventory.Item;
using System.Utilities;
using Microsoft;
using System.IO;
using Microsoft.Inventory.Ledger;
using Microsoft.Manufacturing.Setup;
using System;

tableextension 50041 "WDC Production Order" extends "Production Order"
{
    fields
    {
        field(50000; Export; Boolean)
        {
            CaptionML = ENU = 'Export', FRA = 'Exporté vers Colos';
            DataClassification = ToBeClassified;
        }
        field(50001; "No. of  printed  labels"; Integer)
        {
            CaptionML = ENU = 'No. of  printed  labels', FRA = 'Nbre d''étiquette imprimée';
            DataClassification = ToBeClassified;
        }
        field(50002; "Total Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Total Net Weight', FRA = 'Total poids net';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50003; "Sous traitance"; Boolean)
        {
            CaptionML = ENU = 'Sous Traitance', FRA = 'Sous traitance';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify("Source No.")
        {
            trigger OnAfterValidate()
            var
                ManufacturingSetup: Record "Manufacturing Setup";
            begin
                ManufacturingSetup.Get();
                Rec."Sous traitance" := ExitSousTrait(Rec."Routing No.");
                if Rec."Sous traitance" then begin
                    Rec.Validate("Location Code", ManufacturingSetup."Location Code Sous taitance");
                    Rec.Validate("Bin Code", ManufacturingSetup."Bin Code Sous Traitance");
                end
                else begin
                    Rec.Validate("Location Code", ManufacturingSetup."Location Code");
                    Rec.Validate("Bin Code", ManufacturingSetup."Bin Code");
                end;
            end;
        }
    }
    procedure ExitSousTrait(GamNo: Code[20]) Return: Boolean
    var
        RecLLigneGamme: Record "Routing Line";
        RecLCentre: Record "Work Center";
    begin
        RecLLigneGamme.RESET;
        RecLLigneGamme.SETRANGE("Routing No.", GamNo);
        RecLLigneGamme.SETRANGE(Type, 0);
        IF RecLLigneGamme.FINDSET THEN BEGIN
            REPEAT
                RecLCentre.RESET;
                IF RecLCentre.GET(RecLLigneGamme."No.") THEN
                    IF RecLCentre."Subcontractor No." <> '' THEN BEGIN
                        Return := TRUE;
                    END;
            UNTIL RecLLigneGamme.NEXT = 0;
        END;
    end;

    procedure exportColos(pProductionOrder: Record "Production Order")
    var
        colos: Record "WDC Colos";
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        lProductionOrder: Record "Production Order";
        NewText: Text[250];
        Type: Text;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        lTxt001: TextConst ENU = 'Do you want to export the trigger file?', FRA = 'Souhaitez-vous exporter le fichier déclencheur?';
    begin
        lProductionOrder.RESET;
        lProductionOrder.SETRANGE(Status, pProductionOrder.Status);
        lProductionOrder.SETRANGE("No.", pProductionOrder."No.");
        IF lProductionOrder.FINDFIRST THEN;
        ManufacturingSetup.GET;
        ManufacturingSetup.TestField("Colos Link");
        IF NOT lProductionOrder.Export THEN BEGIN
            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETCURRENTKEY("Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
            ItemLedgerEntry.SETRANGE("Order Type", ItemLedgerEntry."Order Type"::Production);
            ItemLedgerEntry.SETRANGE("Order No.", lProductionOrder."No.");
            ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
            IF ItemLedgerEntry.FINDSET THEN;
            IF Item.GET(lProductionOrder."Source No.") THEN
                CASE Item."Label Type" OF
                    Item."Label Type"::Standard:
                        Type := '1';
                    Item."Label Type"::FDA:
                        Type := '2';
                    Item."Label Type"::EU:
                        Type := '3';
                    Item."Label Type"::"Standard + Special":
                        Type := '4';
                END;
            NewText := lProductionOrder."No." + ';' + CONVERTSTR(Item.Description, 'èéçùûüàâä', 'eecuuuaaa') + ';' + CONVERTSTR(Item."Description 2", 'èéçùûüàâä', 'eecuuuaaa') + ';' + lProductionOrder."Source No."
            + ';' + ItemLedgerEntry."Lot No." + ';' + FORMAT(Item."Qty. per Shipment Unit") + ';' + Type;
            colos.Init();
            colos."No." := GetColosNo();
            colos.Num_OF := lProductionOrder."No.";
            colos.Nom_Article_Anglais := CONVERTSTR(Item.Description, 'èéçùûüàâä', 'eecuuuaaa');
            colos."Nom_Article_Français" := CONVERTSTR(Item."Description 2", 'èéçùûüàâä', 'eecuuuaaa');
            colos.Num_Article := lProductionOrder."Source No.";
            colos.Num_Lot := ItemLedgerEntry."Lot No.";
            colos.Poids_Net := FORMAT(Item."Qty. per Shipment Unit");
            colos.Type_Etiq := Type;
            colos.Insert();

            FileName := ManufacturingSetup."Colos Link" + '.txt';
            TempBlob.CreateOutStream(OutStr);
            OutStr.WriteText('Num_OF;Nom_Article_Anglais;Nom_Article_Français;Num_Article;Num_Lot;Poids_Net;Type_Etiq');
            if colos.FindSet() then
                repeat
                    OutStr.WriteText();
                    NewText := Colos.Num_OF + ';' + colos.Nom_Article_Anglais + ';' + colos."Nom_Article_Français" + ';' + colos.Num_Article
                                + ';' + colos.Num_Lot + ';' + colos.Poids_Net + ';' + colos.Type_Etiq;
                    OutStr.WriteText(NewText);
                until (colos.Next() = 0);
            TempBlob.CreateInStream(InStr);
            TempBlob.CreateOutStream(OutStr, TextEncoding::UTF16);

            if DownloadFromStream(InStr, '', '', '', FileName) then begin
                if Confirm(lTxt001) then
                    ExportDeclencheur(lProductionOrder);
                pProductionOrder.Export := TRUE;
                pProductionOrder.MODIFY;
            end;

        end;
    end;

    procedure ExportDeclencheur(pProductionOrder: Record "Production Order")
    var
        FileName1: Text;
        InStr1: InStream;
        OutStr1: OutStream;
        TempBlob1: Codeunit "Temp Blob";
        NOF: Text[25];
        lTxt001: TextConst ENU = 'Exported successfully', FRA = 'Exporté avec succès';
    begin
        ManufacturingSetup.TestField("Trigger");
        NOF := pProductionOrder."No.";
        FileName1 := ManufacturingSetup."Trigger" + '.txt';
        TempBlob1.CreateOutStream(OutStr1);
        OutStr1.WriteText(NOF);
        TempBlob1.CreateInStream(InStr1);
        TempBlob1.CreateOutStream(OutStr1);
        if DownloadFromStream(InStr1, '', '', '', FileName1) then
            MESSAGE(lTxt001);
    end;

    procedure GetColosNo(): Integer
    var
        colos: Record "WDC Colos";
    begin
        if colos.FindLast() then
            exit(colos."No." + 1)
        else
            exit(1);
    end;

    var
        ManufacturingSetup: Record "Manufacturing Setup";
}
