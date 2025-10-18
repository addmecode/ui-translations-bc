table 50102 "ADD_ExtensionTranslation"
{
    Caption = 'Extension Translation';
    DataClassification = ToBeClassified;
    DrillDownPageID = ADD_ExtensionTranslationCard;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            Editable = true;
        }
        field(2; "Extension Version"; Text[250])
        {
            Caption = 'Extension Version';
            Editable = true;
        }
        field(3; "Extension Name"; Text[250])
        {
            Caption = 'Extension Name';
            Editable = true;
        }
        field(4; "Extension Publisher"; Text[250])
        {
            Caption = 'Extension Publisher';
            Editable = true;
        }
        field(5; "Imported Xlf"; Blob)
        {
            Caption = 'Imported Xlf';
        }
    }
    keys
    {
        key(PK; "Extension ID", "Extension Version")
        {
            Clustered = true;
        }
    }
}
