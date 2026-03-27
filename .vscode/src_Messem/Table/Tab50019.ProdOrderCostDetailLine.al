table 50019 "Prod. Order Cost Detail Line"
{
    Caption = 'Prod. Order Cost Detail Line';
    DataClassification = ToBeClassified;
    LookupPageId = "Prod. Order Cost Detail Lines";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        field(2; "Prod Order No."; CODE[20])
        {
            CaptionML = ENU = 'Prod Order No.', FRA = 'N° OF ';
        }
        field(3; "Item No."; CODE[20])
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        field(4; "Lot No."; CODE[20])
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }
        field(5; "No."; CODE[20])
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        field(6; "Source"; enum "WDC ProdOrderDetailLineSource")
        {
        }
        field(7; "Description "; Text[50])
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }

        field(8; "Unit of Measure Code "; Text[10])
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code d''unité de mesure';
        }

        field(9; "Status"; Enum "Production Order Status")
        {
            CaptionML = ENU = 'Status', FRA = 'Status';
        }

        field(10; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }

        field(11; "Standard Quantity"; Decimal)
        {
            CaptionML = ENU = 'Standard Quantity', FRA = 'Quantité standard';
        }

        field(12; "Expected Quantity"; Decimal)
        {
            CaptionML = ENU = 'Expected Quantity', FRA = 'Quantité prévu';
        }

        field(13; "Actual Quantity"; Decimal)
        {
            CaptionML = ENU = 'Actual Quantity', FRA = 'Quantité réelle';
        }

        field(14; "Standard Cost"; Decimal)
        {
            CaptionML = ENU = 'Standard Cost', FRA = 'Coût standard';
        }

        field(15; "Expected Cost"; Decimal)
        {
            CaptionML = ENU = 'Expected Cost', FRA = 'Coût prévu';
        }

        field(16; "Actual Cost "; Decimal)
        {
            CaptionML = ENU = 'Actual Cost', FRA = 'Coût réel';
        }
        field(17; "Variance Expected Cost "; Decimal)
        {
            CaptionML = ENU = 'Variance Expected Cost', FRA = 'Écart coût prévu';
        }
        field(18; "Variance Standard Cost"; Decimal)
        {
            CaptionML = ENU = 'Variance Standard Cost', FRA = 'Écart coût Standard';
            BlankZero = true;
        }

        field(19; "Deviation"; Boolean)
        {
            CaptionML = ENU = 'Deviation', FRA = 'Déviation';
            BlankZero = true;
        }


    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
