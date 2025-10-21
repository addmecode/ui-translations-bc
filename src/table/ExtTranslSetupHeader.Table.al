table 50102 "ADD_ExtTranslSetupHeader"
{
    Caption = 'Extension Translation Setup Header';
    DataClassification = ToBeClassified;
    DrillDownPageID = ADD_ExtTranslSetupCard;
    LookupPageId = ADD_ExtTranslSetupCard;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            Editable = false;
            TableRelation = "NAV App Installed App"."App ID";
            ValidateTableRelation = false;
        }
        field(2; "Target Language"; Text[30])
        {
            Caption = 'Target Language';
            Editable = false;
        }
        field(3; "Source Language"; Text[250])
        {
            Caption = 'Source Language';
            Editable = false;
        }
        field(4; "Extension Version"; Text[250])
        {
            Caption = 'Extension Version';
            Editable = false;
        }
        field(5; "Extension Name"; Text[250])
        {
            Caption = 'Extension Name';
            Editable = false;
        }
        field(6; "Extension Publisher"; Text[250])
        {
            Caption = 'Extension Publisher';
            Editable = false;
        }
        field(7; "Imported Xlf"; Blob)
        {
            Caption = 'Imported Xlf';
        }
    }
    keys
    {
        key(PK; "Extension ID", "Target Language")
        {
            Clustered = true;
        }
    }
}
