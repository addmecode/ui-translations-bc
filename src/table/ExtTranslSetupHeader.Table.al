table 50102 "ADD_ExtTranslSetupHeader"
{
    Caption = 'Extension Translation Setup Header';
    DataClassification = ToBeClassified;
    DrillDownPageID = ADD_ExtTranslSetupCard;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            Editable = true;
            TableRelation = "NAV App Installed App"."App ID";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                NavAppInstalledApp: Record "NAV App Installed App";
            begin
                if IsNullGuid(Rec."Extension ID") then
                    exit;
                if not NavAppInstalledApp.Get(Rec."Extension ID") then
                    exit;
                Rec."Extension Name" := NavAppInstalledApp.Name;
                Rec."Extension Publisher" := NavAppInstalledApp.Publisher;
                Rec."Extension Version" := Format(NavAppInstalledApp."Version Major") + '.' +
                                           Format(NavAppInstalledApp."Version Minor") + '.' +
                                           Format(NavAppInstalledApp."Version Build") + '.' +
                                           Format(NavAppInstalledApp."Version Revision");
            end;
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
        field(5; "Source Language"; Text[250])
        {
            Caption = 'Source Language';
            Editable = false;
        }
        field(6; "Target Language"; Text[250])
        {
            Caption = 'Target Language';
            Editable = true;
        }
        field(7; "Imported Xlf"; Blob)
        {
            Caption = 'Imported Xlf';
        }
    }
    keys
    {
        key(PK; "Extension ID")
        {
            Clustered = true;
        }
    }
}
