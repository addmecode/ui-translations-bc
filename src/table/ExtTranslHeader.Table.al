table 50102 "ADD_ExtTranslHeader"
{
    Caption = 'Extension Translation  Header';
    DataClassification = ToBeClassified;
    DrillDownPageID = ADD_ExtTranslCard;
    LookupPageId = ADD_ExtTranslCard;

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
            TableRelation = "Windows Language"."Language Tag";
        }
        field(3; "Source Language"; Text[250])
        {
            Caption = 'Source Language';
            Editable = false;
            TableRelation = "Windows Language"."Language Tag";
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
        field(8; "Imported FileName"; Text[250])
        {
            Caption = 'Imported FileName';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Extension ID", "Target Language")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        ExtTransLine: Record ADD_ExtTranslLine;
    begin
        ExtTransLine.SetRange("Extension ID", Rec."Extension ID");
        ExtTransLine.SetRange("Target Language", Rec."Target Language");
        if ExtTransLine.FindSet() then
            ExtTransLine.DeleteAll(true);
    end;
}
