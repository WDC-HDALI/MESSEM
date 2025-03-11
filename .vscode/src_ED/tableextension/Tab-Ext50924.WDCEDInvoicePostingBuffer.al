namespace MESSEM.MESSEM;

using Microsoft.Finance.ReceivablesPayables;

tableextension 50924 "WDC-ED Invoice Posting Buffer" extends "Invoice Posting Buffer"
{
    fields
    {

    }
    keys
    {
        key(Key2; Type, "G/L Account", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Area Code", "Tax Group Code", "Tax Liable", "Use Tax", "Dimension Set ID", "Job No.", "Fixed Asset Line No.")
        { }
    }
}
