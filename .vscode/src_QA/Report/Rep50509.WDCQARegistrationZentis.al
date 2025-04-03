report 50509 "WDC-QA Registration Zentis"
{
    CaptionML = ENU = 'Registration Zentis', FRA = 'Enregistrement Zentis', NLD = 'Registration Zentis';
    RDLCLayout = './.vscode/src_QA/Report/RDLC/RegistrationZentis.rdlc';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    ApplicationArea = All;


    dataset
    {
        dataitem("Registration Header"; "WDC-QA Registration Header")
        {
            column(LotNo_RegistrationHeader; "Registration Header"."Lot No.")
            {
            }
            column(ItemNo_RegistrationHeader; "Registration Header"."Item No.")
            {
            }
            column(ItemDescription_RegistrationHeader; ItemDescr)
            {
            }
            column(ProductionDate_RegistrationHeader; "Registration Header"."Production Date")
            {
            }
            column(SourceNo_RegistrationHeader; "Registration Header"."Source No.")
            {
            }
            column(ItemNo_ItemCrossReference; ItemCrossReference."Item No.")
            {
            }
            column(VariantCode_ItemCrossReference; ItemCrossReference."Variant Code")
            {
            }
            column(UnitofMeasure_ItemCrossReference; ItemCrossReference."Unit of Measure")
            {
            }
            column(CrossReferenceType_ItemCrossReference; ItemCrossReference."Reference Type")
            {
            }
            column(CrossReferenceTypeNo_ItemCrossReference; ItemCrossReference."Reference Type No.")
            {
            }
            column(CrossReferenceNo_ItemCrossReference; ItemCrossReference."Reference No.")
            {
            }
            column(Description_ItemCrossReference; ItemCrossReference.Description)
            {
            }
            //column(DiscontinueBarCode_ItemCrossReference; ItemCrossReference."Discontinue Bar Code")
            //{
            //}
            column(Color_ItemCrossReference; ItemCrossReference.Color)
            {
            }
            column(OdorTaste_ItemCrossReference; ItemCrossReference."Odor / Taste")
            {
            }
            column(Brix_ItemCrossReference; ItemCrossReference.Brix)
            {
            }
            column(pH_ItemCrossReference; ItemCrossReference.pH)
            {
            }
            column(Caliber_ItemCrossReference; ItemCrossReference.Caliber)
            {
            }
            column(BloomsCaps_ItemCrossReference; ItemCrossReference."Blooms / Caps")
            {
            }
            column(StemsPartsofstams_ItemCrossReference; ItemCrossReference."Stems / Parts of stams")
            {
            }
            column(Leafmaterial_ItemCrossReference; ItemCrossReference.Leafmaterial)
            {
            }
            column(RottenMouldyfruit_ItemCrossReference; ItemCrossReference."Rotten / Mouldy fruit")
            {
            }
            column(UnripeFruit_ItemCrossReference; ItemCrossReference."Unripe Fruit")
            {
            }
            column(OverripeFruit_ItemCrossReference; ItemCrossReference."Overripe Fruit")
            {
            }
            column(Scap_ItemCrossReference; ItemCrossReference.Scap)
            {
            }
            column(Packing_ItemCrossReference; ItemCrossReference.Packing)
            {
            }
            column(Carton_ItemCrossReference; ItemCrossReference.Carton)
            {
            }
            column(ColorInliner_ItemCrossReference; ItemCrossReference."Color Inliner")
            {
            }
            column(TapeColor_ItemCrossReference; ItemCrossReference."Tape Color")
            {
            }
            column(ForeignBodiesfree_ItemCrossReference; ItemCrossReference."Foreign Bodies free")
            {
            }
            column(Min1ofweight_ItemCrossReference; ItemCrossReference."Min. 1% of weight")
            {
            }
            column(Consistency_ItemCrossReference; ItemCrossReference.Consistency)
            {
            }
            column(ItemCrossReference_Spec; ItemCrossReference.Spec)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(ItemDescr);
                ItemCrossReference.RESET;
                ItemCrossReference.SETRANGE("Item No.", "Registration Header"."Item No.");
                ItemCrossReference.SETRANGE("Reference Type", ItemCrossReference."Reference Type"::Customer);
                ItemCrossReference.SETRANGE("Reference Type No.", 'CL-0015');
                //ItemCrossReference.SETRANGE("Cross-Reference Type No.","Registration Header"."Customer No. Filter");
                IF ItemCrossReference.FINDFIRST THEN
                    ItemDescr := ItemCrossReference."Reference No." + ' ' + ItemCrossReference.Description;

                IF ItemDescr = '' THEN
                    ItemDescr := "Registration Header"."Item Description";
            end;
        }
    }
    var
        ItemCrossReference: Record "Item Reference";
        ItemDescr: Text;
}

