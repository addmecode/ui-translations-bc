table 50101 "ADD_Translated Elements"
{
    Caption = 'Translated Elements';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Target Language"; Code[10])
        {
            Caption = 'Target Language';
        }
        field(2; "Trans Unit ID"; Text[250]) //TODO: encrypt
        {
            Caption = 'Trans Unit ID';
        }
        field(3; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID';
        }
        field(5; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
        }
        field(6; "Element Name"; Text[30])
        {
            Caption = 'Element Name';
        }
        field(7; "Element Source Caption"; Text[30])
        {
            Caption = 'Element Source Caption';
        }
        field(8; "Element Translated Caption"; Text[30])
        {
            Caption = 'Element Translated Caption';
        }
    }
    keys
    {
        key(PK; "Target Language", "Trans Unit ID")
        {
            Clustered = true;
        }
    }
}
