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
        field(8; "Developer Note"; Text[250])
        {
            Caption = 'Developer Note';
        }
        field(9; "Xliff Note"; Text[250])
        {
            Caption = 'Xliff Note';
        }
        field(10; "Element Source Caption"; Text[250])
        {
            Caption = 'Element Source Caption';
        }
    }
    keys
    {
        key(PK; "Extension ID", "Extension Version", "Trans Unit ID")
        {
            Clustered = true;
        }
    }
}
