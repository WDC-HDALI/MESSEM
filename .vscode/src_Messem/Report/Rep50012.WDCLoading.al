report 50012 "WDC Loading"
{
    DefaultLayout = RDLC;
    RDLCLayout = './.vscode/src_Messem/Report/RDLC/Loading.rdlc';

    CaptionML = ENU = 'Loading', FRA = 'Chargement';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.", "Posting Date", "Ship-to Code";
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(InvoiceNo; "Sales Invoice Header"."No.")
            {
            }
            column(CustomerCode; "Sales Invoice Header"."Ship-to Code")
            {
            }
            column(CustomerName; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(Port; Harbor.Description)
            {
            }
            column(Container; "Sales Invoice Header"."Container No.")
            {
            }
            column(SO_No; "Sales Invoice Header"."Order No.")
            {
            }
            column(Transp; ShippingAgent.Name)
            {
            }
            column(INCOTERM; "Sales Invoice Header"."Shipment Method Code")
            {
            }
            column(LoadigDate; "Sales Invoice Header"."Document Date")
            {
            }
            column(TransitAgentName; ForwardingAgent."Agent Name")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item),
                                          Quantity = FILTER(<> 0));
                column(MaterialNbr; "Sales Invoice Line"."No.")
                {
                }
                column(QuantityKG1; "Sales Invoice Line".Quantity)
                {
                }
                column(TotalEur; "Sales Invoice Line"."Line Amount")
                {
                }
                column(PriceEur; "Sales Invoice Line"."Unit Price")
                {
                }
                column(TotalMAD; MontantMAD)
                {
                }
                column(MontantLoadingMAD; TotalMAD)
                {
                }
                column(MontantLoadingEUR; TotalEUR)
                {
                }
                column(QuantityKG; TempItemLedgEntry.Quantity)
                {
                }
                column(LotNo; TempItemLedgEntry."Lot No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Cal. Montant en DS
                    IF "Sales Invoice Header"."Currency Code" = '' THEN
                        MontantMAD := "Sales Invoice Line"."Line Amount"
                    ELSE
                        MontantMAD :=
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Line"."Line Amount", "Sales Invoice Header"."Currency Factor");

                    TotalMAD += MontantMAD;
                    TotalEUR += "Sales Invoice Line"."Line Amount";

                    //Récupération des lots
                    GetItemTrackingLines;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Harbor.RESET;
                IF Harbor.GET("Sales Invoice Header"."Destination Port") THEN;

                IF NOT ShippingAgent.GET("Sales Invoice Header"."Shipping Agent Code") THEN
                    CLEAR(ShippingAgent);

                IF NOT ForwardingAgent.GET("Sales Invoice Header"."Forwarding Agent") THEN
                    CLEAR(ForwardingAgent);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    trigger OnPreReport()
    begin
        TotalMAD := 0;
        TotalEUR := 0;
        MontantMAD := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        Harbor: Record "WDC Harbor";
        CurrExchRate: Record "Currency Exchange Rate";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        ShippingAgent: Record "Shipping Agent";
        TotalMAD: Decimal;
        TotalEUR: Decimal;
        MontantMAD: Decimal;
        ForwardingAgent: Record "WDC Forwarding Agent";

    procedure GetItemTrackingLines()
    var
        ItemTrackingMgt: Codeunit "Item Tracking Doc. Management";
    begin
        TempItemLedgEntry.RESET;
        TempItemLedgEntry.DELETEALL;
        ItemTrackingMgt.RetrieveEntriesFromPostedInvoice(TempItemLedgEntry, RowID1)
    end;

    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        EXIT(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line",
            0, "Sales Invoice Line"."Document No.", '', 0, "Sales Invoice Line"."Line No."));
    end;
}

