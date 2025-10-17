table 50100 "ADD_Translation Elements"
{
    Caption = 'Translation Elements';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Trans Unit ID"; Text[250]) //TODO: encrypt
        {
            Caption = 'Trans Unit ID';
        }
        field(2; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(3; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        field(4; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
        }
        field(5; "Element Name"; Text[30])
        {
            Caption = 'Element Name';
        }
        field(6; "Element Source Caption"; Text[30])
        {
            Caption = 'Element Source Caption';
        }
    }
    keys
    {
        key(PK; "Trans Unit ID")
        {
            Clustered = true;
        }
    }
}
