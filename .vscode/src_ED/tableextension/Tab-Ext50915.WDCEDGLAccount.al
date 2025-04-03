tableextension 50915 "WDC-ED G/L Account" extends "G/L Account"
{
    fields
    {
        // field(10810; "G/L Entry Type Filter"; option)
        // {
        //     Caption = 'G/L Entry Type Filter';
        //     FieldClass = FlowFilter;
        //     ObsoleteReason = 'Discontinued feature';
        //     ObsoleteState = Removed;
        //     OptionCaption = 'Definitive,Simulation';
        //     OptionMembers = Definitive,Simulation;
        //     ObsoleteTag = '15.0';
        // }
        field(50811; "Detailed Balance"; Boolean)
        {
            CaptionML = ENU = 'Detailed Balance', FRA = 'Solde détaillé';
        }
    }

}