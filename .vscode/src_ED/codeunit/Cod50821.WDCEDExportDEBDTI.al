codeunit 50821 "WDC-ED Export DE DTI"
{

    trigger OnRun()
    begin
    end;

    //     procedure ExportToXML(var IntrastatJnlLine: Record "Intrastat Jnl. Line"; ObligationLevel: Integer; FileName: Text): Boolean
    //     var
    //         OutputStream: OutStream;
    //         LastDeclarationId: Integer;
    //     begin
    //         CompanyInfo.Get();
    //         CheckMandatoryCompanyInfo;

    //         CheckJnlLines(IntrastatJnlLine);
    //         InsertTempJnlLines(IntrastatJnlLine);

    //         ClientFileName := FileName;
    //         CreateFile(OutputStream);

    //         LastDeclarationId := CompanyInfo."Last Intrastat Declaration ID";
    //         GenerateXML(OutputStream, LastDeclarationId, ObligationLevel);
    //         UpdateLastDeclarationId(LastDeclarationId);

    //         UpdateBatchReported(IntrastatJnlLine);

    //         CloseFile;

    //         exit(true);
    //     end;

    //     local procedure CreateFile(var OutputStream: OutStream)
    //     var
    //         TierAutoMgt: Codeunit "File Management";
    //     begin
    //         OutputFile.TextMode(true);
    //         OutputFile.WriteMode(true);
    //         TempFileName := TierAutoMgt.ServerTempFileName('.xml');
    //         OutputFile.Create(TempFileName);
    //         OutputFile.CreateOutStream(OutputStream);
    //     end;

    //     local procedure CloseFile()
    //     begin
    //         OutputFile.Close;
    //         FileMgt.DownloadToFile(TempFileName, ClientFileName);
    //     end;

    // local procedure CheckMandatoryCompanyInfo()
    // begin
    //     CompanyInfo.TestField(CISD);
    //     CompanyInfo.TestField("Registration No.");
    //     CompanyInfo.TestField("VAT Registration No.");
    //     CompanyInfo.TestField(Name);
    // end;

    //     local procedure UpdateLastDeclarationId(LastDeclarationId: Integer)
    //     begin
    //         CompanyInfo.Get();
    //         CompanyInfo."Last Intrastat Declaration ID" := LastDeclarationId;
    //         CompanyInfo.Modify();
    //     end;

    //     local procedure CheckJnlLines(var IntrastatJnlLine: Record "Intrastat Jnl. Line")
    //     begin
    //         if IntrastatJnlLine.IsEmpty then
    //             Error(Text001);

    //         IntrastatJnlLine.FindFirst;
    //         ValidateJnlBatch(IntrastatJnlLine);

    //         IntrastatJnlLine.SetCurrentKey(Type);
    //         if IntrastatJnlLine.FindSet then
    //             repeat
    //                 ValidateJnlLine(IntrastatJnlLine);
    //             until IntrastatJnlLine.Next = 0;
    //     end;

    //     local procedure ValidateJnlBatch(IntrastatJnlLine: Record "Intrastat Jnl. Line")
    //     var
    //         IntrastatJnlBatch: Record "Intrastat Jnl. Batch";
    //     begin
    //         IntrastatJnlBatch.Get(IntrastatJnlLine."Journal Template Name", IntrastatJnlLine."Journal Batch Name");
    //         IntrastatJnlBatch.TestField("Statistics Period");
    //         IntrastatJnlBatch.TestField(Reported, false);
    //     end;

    //     local procedure ValidateJnlLine(IntrastatJnlLine: Record "Intrastat Jnl. Line")
    //     begin
    //         IntrastatJnlLine.TestField("Journal Template Name");
    //         IntrastatJnlLine.TestField("Journal Batch Name");
    //         IntrastatJnlLine.TestField("Transaction Specification");
    //         if IntrastatJnlLine."Transaction Type" <> '' then
    //             if CopyStr(IntrastatJnlLine."Transaction Type", 1, 1) = '0' then
    //                 IntrastatJnlLine.FieldError("Transaction Type", Text003);

    //         if IntrastatJnlLine."Statistical Value" <= 0 then
    //             IntrastatJnlLine.FieldError("Statistical Value", Text002);
    //         if IntrastatJnlLine.Quantity <= 0 then
    //             IntrastatJnlLine.FieldError(Quantity, Text002);
    //     end;

    //     local procedure InsertTempJnlLines(var IntrastatJnlLine: Record "Intrastat Jnl. Line")
    //     var
    //         Type: Integer;
    //         FlowCode: Text[1];
    //     begin
    //         Type := -1;
    //         IntrastatJnlLine.SetCurrentKey(Type);
    //         if IntrastatJnlLine.FindSet then
    //             repeat
    //                 if Type <> IntrastatJnlLine.Type then begin
    //                     FlowCode := GetFlowCode(IntrastatJnlLine.Type);
    //                     InsertTempJnlBatch(IntrastatJnlLine, FlowCode);
    //                     Type := IntrastatJnlLine.Type;
    //                 end;
    //                 InsertTempJnlLine(IntrastatJnlLine, FlowCode);
    //             until IntrastatJnlLine.Next = 0;
    //     end;

    //     local procedure InsertTempJnlBatch(IntrastatJnlLine: Record "Intrastat Jnl. Line"; FlowCode: Text[1])
    //     var
    //         IntrastatJnlBatch: Record "Intrastat Jnl. Batch";
    //     begin
    //         IntrastatJnlBatch.Get(IntrastatJnlLine."Journal Template Name", IntrastatJnlLine."Journal Batch Name");
    //         TempIntrastatJnlBatch := IntrastatJnlBatch;
    //         TempIntrastatJnlBatch."Journal Template Name" := FlowCode;
    //         TempIntrastatJnlBatch.Insert();
    //     end;

    //     local procedure InsertTempJnlLine(IntrastatJnlLine: Record "Intrastat Jnl. Line"; FlowCode: Text[1])
    //     begin
    //         TempIntrastatJnlLine := IntrastatJnlLine;
    //         TempIntrastatJnlLine.Quantity := GetQtyInSU(IntrastatJnlLine);
    //         TempIntrastatJnlLine."Tariff No." := DelChr(IntrastatJnlLine."Tariff No.");
    //         TempIntrastatJnlLine."Total Weight" := RoundValue(IntrastatJnlLine."Total Weight");
    //         TempIntrastatJnlLine."Statistical Value" := RoundValue(IntrastatJnlLine."Statistical Value");
    //         TempIntrastatJnlLine."Journal Template Name" := FlowCode;
    //         TempIntrastatJnlLine.Insert();
    //     end;

    //     local procedure UpdateBatchReported(var IntrastatJnlLine: Record "Intrastat Jnl. Line")
    //     var
    //         IntrastatJnlBatch: Record "Intrastat Jnl. Batch";
    //     begin
    //         IntrastatJnlLine.FindFirst;
    //         IntrastatJnlBatch.Get(IntrastatJnlLine."Journal Template Name", IntrastatJnlLine."Journal Batch Name");
    //         IntrastatJnlBatch.Reported := true;
    //         IntrastatJnlBatch.Modify();
    //     end;

    //     local procedure GetReferencePeriod(StatisticsPeriod: Code[10]): Text[30]
    //     begin
    //         exit('20' + CopyStr(StatisticsPeriod, 1, 2) + '-' + CopyStr(StatisticsPeriod, 3, 2));
    //     end;

    //     local procedure GetFlowCode(IntrastatJnlLineType: Integer): Text[1]
    //     var
    //         IntrastatJnlLine: Record "Intrastat Jnl. Line";
    //     begin
    //         if IntrastatJnlLineType = IntrastatJnlLine.Type::Receipt then
    //             exit('A');
    //         exit('D');
    //     end;

    // local procedure RoundValue(Value: Decimal): Integer
    // var
    //     IntValue: Integer;
    // begin
    //     if Value >= 1 then
    //         IntValue := Round(Value, 1)
    //     else
    //         if Value = 0 then
    //             IntValue := 0
    //         else
    //             IntValue := 1;
    //     exit(IntValue);
    // end;

    // local procedure FormatToXML(Number: Decimal): Text[30]
    // begin
    //     exit(Format(Number, 0, 9));
    // end;

    //     local procedure GetQtyInSU(IntrastatJnlLine: Record "Intrastat Jnl. Line"): Integer
    //     var
    //         TariffNo: Record "Tariff Number";
    //     begin
    //         if TariffNo.Get(IntrastatJnlLine."Tariff No.") then begin
    //             if TariffNo."Supplementary Units" then
    //                 exit(Round(IntrastatJnlLine.Quantity, 1))
    //         end;
    //         exit(0);
    //     end;

    //     local procedure GenerateXML(OutputStream: OutStream; var DeclarationId: Integer; ObligationLevel: Integer)
    //     var
    //         XMLCurrNode: DotNet XmlNode;
    //         XMLDoc: DotNet XmlDocument;
    //     begin
    //         XMLDomMgt.LoadXMLDocumentFromText('<INSTAT/>', XMLDoc);
    //         XMLCurrNode := XMLDoc.DocumentElement;
    //         XMLDomMgt.AddDeclaration(XMLDoc, '1.0', 'UTF-8', '');

    //         AddHeader(XMLCurrNode);
    //         AddDeclarations(XMLCurrNode, DeclarationId, ObligationLevel);

    //         XMLDoc.Save(OutputStream);
    //     end;

    //     local procedure AddHeader(var XMLNode: DotNet XmlNode)
    //     begin
    //         XMLDomMgt.AddGroupNode(XMLNode, 'Envelope');
    //         XMLDomMgt.AddNode(XMLNode, 'envelopeId', CompanyInfo.CISD);

    //         XMLDomMgt.AddGroupNode(XMLNode, 'DateTime');
    //         XMLDomMgt.AddNode(XMLNode, 'date', Format(Today, 0, 9));
    //         XMLDomMgt.AddLastNode(XMLNode, 'time', CopyStr(Format(Time, 0, 9), 1, 8));

    //         XMLDomMgt.AddGroupNode(XMLNode, 'Party');
    //         XMLDomMgt.AddAttribute(XMLNode, 'partyType', 'PSI');
    //         XMLDomMgt.AddAttribute(XMLNode, 'partyRole', 'sender');
    //         XMLDomMgt.AddNode(XMLNode, 'partyId', CompanyInfo.GetPartyID);
    //         XMLDomMgt.AddLastNode(XMLNode, 'partyName', CompanyInfo.Name);

    //         XMLDomMgt.AddNode(XMLNode, 'softwareUsed', 'DynamicsNAV');
    //     end;

    //     local procedure AddDeclarations(var XMLNode: DotNet XmlNode; var DeclarationId: Integer; ObligationLevel: Integer)
    //     begin
    //         if TempIntrastatJnlBatch.FindSet then
    //             repeat
    //                 DeclarationId := DeclarationId + 1;
    //                 AddDeclaration(XMLNode, TempIntrastatJnlBatch, DeclarationId, ObligationLevel);
    //                 AddItems(XMLNode, TempIntrastatJnlBatch);
    //                 XMLNode := XMLNode.ParentNode;
    //             until TempIntrastatJnlBatch.Next = 0;
    //     end;

    //     local procedure AddDeclaration(var XMLNode: DotNet XmlNode; IntrastatJnlBatch: Record "Intrastat Jnl. Batch"; DeclarationId: Integer; ObligationLevel: Integer)
    //     begin
    //         XMLDomMgt.AddGroupNode(XMLNode, 'Declaration');
    //         XMLDomMgt.AddNode(XMLNode, 'declarationId', FormatExtendNumberToXML(DeclarationId, 6));
    //         XMLDomMgt.AddNode(XMLNode, 'referencePeriod', GetReferencePeriod(IntrastatJnlBatch."Statistics Period"));
    //         XMLDomMgt.AddNode(XMLNode, 'PSIId', CompanyInfo.GetPartyID);

    //         XMLDomMgt.AddGroupNode(XMLNode, 'Function');
    //         XMLDomMgt.AddLastNode(XMLNode, 'functionCode', 'O');

    //         XMLDomMgt.AddNode(XMLNode, 'declarationTypeCode', Format(ObligationLevel));
    //         XMLDomMgt.AddNode(XMLNode, 'flowCode', IntrastatJnlBatch."Journal Template Name");
    //         XMLDomMgt.AddNode(XMLNode, 'currencyCode', 'EUR');
    //     end;

    //     local procedure AddItems(var XMLNode: DotNet XmlNode; IntrastatJnlBatch: Record "Intrastat Jnl. Batch")
    //     var
    //         ItemNumberXML: Integer;
    //     begin
    //         TempIntrastatJnlLine.SetCurrentKey(Type);
    //         TempIntrastatJnlLine.SetRange("Journal Template Name", IntrastatJnlBatch."Journal Template Name");
    //         TempIntrastatJnlLine.SetRange("Journal Batch Name", IntrastatJnlBatch.Name);
    //         ItemNumberXML := 0;
    //         if TempIntrastatJnlLine.FindSet then
    //             repeat
    //                 ItemNumberXML += 1;
    //                 AddItem(XMLNode, TempIntrastatJnlLine, ItemNumberXML);
    //                 XMLNode := XMLNode.ParentNode;
    //             until TempIntrastatJnlLine.Next = 0;
    //     end;

    //     local procedure AddItem(var XMLNode: DotNet XmlNode; IntrastatJnlLine: Record "Intrastat Jnl. Line"; ItemNumberXML: Integer)
    //     begin
    //         XMLDomMgt.AddGroupNode(XMLNode, 'Item');
    //         XMLDomMgt.AddNode(XMLNode, 'itemNumber', FormatExtendNumberToXML(ItemNumberXML, 6));
    //         if IntrastatJnlLine."Tariff No." <> '' then begin
    //             XMLDomMgt.AddGroupNode(XMLNode, 'CN8');
    //             XMLDomMgt.AddLastNode(XMLNode, 'CN8Code', IntrastatJnlLine."Tariff No.");
    //         end;
    //         if IntrastatJnlLine."Country/Region of Origin Code" <> '' then
    //             XMLDomMgt.AddNode(XMLNode, 'countryOfOriginCode', IntrastatJnlLine."Country/Region of Origin Code");
    //         if IntrastatJnlLine."Entry/Exit Point" <> '' then
    //             XMLDomMgt.AddNode(XMLNode, 'paysProvenance', IntrastatJnlLine."Entry/Exit Point");
    //         if IntrastatJnlLine.Area <> '' then
    //             XMLDomMgt.AddNode(XMLNode, 'departement', IntrastatJnlLine.Area);
    //         if IntrastatJnlLine."Total Weight" <> 0 then
    //             XMLDomMgt.AddNode(XMLNode, 'netMass', FormatToXML(IntrastatJnlLine."Total Weight"));
    //         if IntrastatJnlLine.Quantity <> 0 then
    //             XMLDomMgt.AddNode(XMLNode, 'quantityInSU', FormatToXML(IntrastatJnlLine.Quantity));
    //         XMLDomMgt.AddNode(XMLNode, 'invoicedAmount', FormatToXML(IntrastatJnlLine."Statistical Value"));
    //         if IntrastatJnlLine."Cust. VAT Registration No." <> '' then
    //             XMLDomMgt.AddNode(XMLNode, 'partnerId', IntrastatJnlLine."Cust. VAT Registration No.");
    //         XMLDomMgt.AddNode(XMLNode, 'statisticalProcedureCode', IntrastatJnlLine."Transaction Specification");

    //         if TempIntrastatJnlLine."Transaction Type" <> '' then begin
    //             XMLDomMgt.AddGroupNode(XMLNode, 'NatureOfTransaction');
    //             XMLDomMgt.AddNode(XMLNode, 'natureOfTransactionACode', CopyStr(TempIntrastatJnlLine."Transaction Type", 1, 1));
    //             if CopyStr(TempIntrastatJnlLine."Transaction Type", 2, 1) <> '0' then
    //                 XMLDomMgt.AddNode(XMLNode, 'natureOfTransactionBCode', CopyStr(TempIntrastatJnlLine."Transaction Type", 2, 1));
    //             XMLNode := XMLNode.ParentNode;
    //         end;

    //         if IntrastatJnlLine."Transport Method" <> '' then
    //             XMLDomMgt.AddNode(XMLNode, 'modeOfTransportCode', IntrastatJnlLine."Transport Method");
    //     end;

    // local procedure FormatExtendNumberToXML(Value: Integer; Length: Integer): Text
    // begin
    //     exit(
    //       Format(
    //         Value, 0, StrSubstNo('<Integer,%1><Filler Character,0>', Length)));
    // end;

    // var
    //     CompanyInfo: Record "Company Information";
    //     //TempIntrastatJnlBatch: Record "Intrastat Jnl. Batch" temporary;
    //     //TempIntrastatJnlLine: Record "Intrastat Jnl. Line" temporary;
    //     FileMgt: Codeunit "File Management";
    //     XMLDomMgt: Codeunit "XML DOM Management";
    //     OutputFile: File;
    //     TempFileName: Text;
    //     ClientFileName: Text;
    //     Text001: TextConst ENU = 'There is nothing to export.', FRA = 'Il n''y a rien à exporter.';
    //     Text002: TextConst ENU = 'must be positive', FRA = 'doit être de signe positif';
    //     Text003: TextConst ENU = 'must not start with zero', FRA = 'ne doit pas commencer par zéro';
}

