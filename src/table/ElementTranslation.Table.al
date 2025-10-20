table 50100 "ADD_ElementTranslation"
{
    Caption = 'Element Translation';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            TableRelation = ADD_ExtensionTranslation."Extension ID";
            ValidateTableRelation = false;
        }
        field(2; "Extension Version"; Text[250])
        {
            Caption = 'Extension Version';
            TableRelation = ADD_ExtensionTranslation."Extension Version";
            ValidateTableRelation = false;
        }
        field(3; "Trans Unit ID"; Text[250]) //TODO: encrypt
        {
            Caption = 'Trans Unit ID';
        }
        field(4; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(5; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
        }
        field(6; "Element Type"; Text[30])
        {
            Caption = 'Element Type';
        }
        field(7; "Element Name"; Text[250])
        {
            Caption = 'Element Name';
        }
        field(10; "Developer Note 1"; Text[250])
        {
            Caption = 'Developer Note 1';
        }
        field(11; "Developer Note 2"; Text[250])
        {
            Caption = 'Developer Note 2';
        }
        field(12; "Developer Note 3"; Text[250])
        {
            Caption = 'Developer Note 3';
        }
        field(13; "Developer Note 4"; Text[250])
        {
            Caption = 'Developer Note 4';
        }
        field(14; "Developer Note 5"; Text[250])
        {
            Caption = 'Developer Note 5';
        }
        field(20; "Xliff Note 1"; Text[250])
        {
            Caption = 'Xliff Note 1';
        }
        field(21; "Xliff Note 2"; Text[250])
        {
            Caption = 'Xliff Note 2';
        }
        field(22; "Xliff Note 3"; Text[250])
        {
            Caption = 'Xliff Note 3';
        }
        field(23; "Xliff Note 4"; Text[250])
        {
            Caption = 'Xliff Note 4';
        }
        field(24; "Xliff Note 5"; Text[250])
        {
            Caption = 'Xliff Note 5';
        }
        field(30; "Element Source Caption 1"; Text[250])
        {
            Caption = 'Element Source Caption 1';
        }
        field(31; "Element Source Caption 2"; Text[250])
        {
            Caption = 'Element Source Caption 2';
        }
        field(32; "Element Source Caption 3"; Text[250])
        {
            Caption = 'Element Source Caption 3';
        }
        field(33; "Element Source Caption 4"; Text[250])
        {
            Caption = 'Element Source Caption 4';
        }
        field(34; "Element Source Caption 5"; Text[250])
        {
            Caption = 'Element Source Caption 5';
        }
    }
    keys
    {
        key(PK; "Extension ID", "Extension Version", "Trans Unit ID")
        {
            Clustered = true;
        }
    }

    procedure GetDeveloperNotes(): Text
    begin
        exit(Rec."Developer Note 1" + Rec."Developer Note 2" + Rec."Developer Note 3" + Rec."Developer Note 4" + Rec."Developer Note 5");
    end;

    procedure GetXliffNotes(): Text
    begin
        exit(Rec."Xliff Note 1" + Rec."Xliff Note 2" + Rec."Xliff Note 3" + Rec."Xliff Note 4" + Rec."Xliff Note 5");
    end;

    procedure GetElementSourceCaptions(): Text
    begin
        exit(Rec."Element Source Caption 1" + Rec."Element Source Caption 2" + Rec."Element Source Caption 3" + Rec."Element Source Caption 4" + Rec."Element Source Caption 5");
    end;
}
