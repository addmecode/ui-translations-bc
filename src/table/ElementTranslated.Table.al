table 50101 "ADD_ElementTranslated"
{
    Caption = 'Element Translated';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            TableRelation = ADD_ElementTranslation."Extension ID";
        }
        field(2; "Extension Version"; Text[250])
        {
            Caption = 'Extension Version';
            TableRelation = ADD_ElementTranslation."Extension Version";
        }
        field(3; "Trans Unit ID"; Text[250]) //TODO: encrypt
        {
            Caption = 'Trans Unit ID';
            TableRelation = ADD_ElementTranslation."Trans Unit ID";
        }
        field(4; "Target Language"; Code[10])
        {
            Caption = 'Target Language';
            TableRelation = Language.Code;
        }
        field(5; "Element Translated Caption"; Text[250])
        {
            Caption = 'Element Translated Caption';
        }
        field(6; "Object Type"; option)
        {
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
            OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
            FieldClass = FlowField;
            CalcFormula = Lookup(ADD_ElementTranslation."Object Type" Where(
                "Extension ID" = field("Extension ID"),
                "Extension Version" = field("Extension Version"),
                "Trans Unit ID" = field("Trans Unit ID")));
        }
        field(7; "Object Name"; Text[30])
        {
            Caption = 'Object Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(ADD_ElementTranslation."Object Name" Where(
                "Extension ID" = field("Extension ID"),
                "Extension Version" = field("Extension Version"),
                "Trans Unit ID" = field("Trans Unit ID")));
        }
        field(8; "Element Type"; Text[30])
        {
            Caption = 'Element Type';
            FieldClass = FlowField;
            CalcFormula = Lookup(ADD_ElementTranslation."Element Type" Where(
                "Extension ID" = field("Extension ID"),
                "Extension Version" = field("Extension Version"),
                "Trans Unit ID" = field("Trans Unit ID")));
        }
        field(9; "Element Name"; Text[30])
        {
            Caption = 'Element Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(ADD_ElementTranslation."Element Name" Where(
                "Extension ID" = field("Extension ID"),
                "Extension Version" = field("Extension Version"),
                "Trans Unit ID" = field("Trans Unit ID")));
        }
        field(10; "Element Source Caption"; Text[30])
        {
            Caption = 'Element Source Caption';
            FieldClass = FlowField;
            CalcFormula = Lookup(ADD_ElementTranslation."Element Source Caption" Where(
                "Extension ID" = field("Extension ID"),
                "Extension Version" = field("Extension Version"),
                "Trans Unit ID" = field("Trans Unit ID")));
        }

    }
    keys
    {
        key(PK; "Extension ID", "Extension Version", "Trans Unit ID", "Target Language")
        {
            Clustered = true;
        }
    }
}
