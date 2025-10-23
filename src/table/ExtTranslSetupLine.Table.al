table 50100 "ADD_ExtTranslSetupLine"
{
    Caption = 'Element Translation Setup Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            TableRelation = ADD_ExtTranslSetupHeader."Extension ID";
            ValidateTableRelation = true;
            Editable = false;
        }
        field(2; "Trans Unit ID"; Text[250]) //TODO: encrypt
        {
            Caption = 'Trans Unit ID';
            Editable = false;
        }
        field(3; "Target Language"; Text[30])
        {
            Caption = 'Target Language';
            TableRelation = ADD_ExtTranslSetupHeader."Target Language";
            ValidateTableRelation = true;
            Editable = false;
        }
        field(4; "Object Type"; Text[30])
        {
            Caption = 'Object Type';
            Editable = false;
        }
        field(5; "Object Name"; Text[250])
        {
            Caption = 'Object Name';
            Editable = false;
        }
        field(6; "Element Type"; Text[250])
        {
            Caption = 'Element Type';
            Editable = false;
        }
        field(7; "Element Name"; Text[250])
        {
            Caption = 'Element Name';
            Editable = false;
        }
        field(10; "Developer Note 1"; Text[250])
        {
            Caption = 'Developer Note 1';
            Editable = false;
        }
        field(11; "Developer Note 2"; Text[250])
        {
            Caption = 'Developer Note 2';
            Editable = false;
        }
        field(12; "Developer Note 3"; Text[250])
        {
            Caption = 'Developer Note 3';
            Editable = false;
        }
        field(13; "Developer Note 4"; Text[250])
        {
            Caption = 'Developer Note 4';
            Editable = false;
        }
        field(14; "Developer Note 5"; Text[250])
        {
            Caption = 'Developer Note 5';
            Editable = false;
        }
        field(20; "Xliff Note 1"; Text[250])
        {
            Caption = 'Xliff Note 1';
            Editable = false;
        }
        field(21; "Xliff Note 2"; Text[250])
        {
            Caption = 'Xliff Note 2';
            Editable = false;
        }
        field(22; "Xliff Note 3"; Text[250])
        {
            Caption = 'Xliff Note 3';
            Editable = false;
        }
        field(23; "Xliff Note 4"; Text[250])
        {
            Caption = 'Xliff Note 4';
            Editable = false;
        }
        field(24; "Xliff Note 5"; Text[250])
        {
            Caption = 'Xliff Note 5';
            Editable = false;
        }
        field(30; "Element Source Caption 1"; Text[250])
        {
            Caption = 'Element Source Caption 1';
            Editable = false;
        }
        field(31; "Element Source Caption 2"; Text[250])
        {
            Caption = 'Element Source Caption 2';
            Editable = false;
        }
        field(32; "Element Source Caption 3"; Text[250])
        {
            Caption = 'Element Source Caption 3';
            Editable = false;
        }
        field(33; "Element Source Caption 4"; Text[250])
        {
            Caption = 'Element Source Caption 4';
            Editable = false;
        }
        field(34; "Element Source Caption 5"; Text[250])
        {
            Caption = 'Element Source Caption 5';
            Editable = false;
        }
        field(40; "Element Target Caption 1"; Text[250])
        {
            Caption = 'Element Target Caption 1';
            Editable = true;
        }
        field(41; "Element Target Caption 2"; Text[250])
        {
            Caption = 'Element Target Caption 2';
            Editable = true;
        }
        field(42; "Element Target Caption 3"; Text[250])
        {
            Caption = 'Element Target Caption 3';
            Editable = true;
        }
        field(43; "Element Target Caption 4"; Text[250])
        {
            Caption = 'Element Target Caption 4';
            Editable = true;
        }
        field(44; "Element Target Caption 5"; Text[250])
        {
            Caption = 'Element Target Caption 5';
            Editable = true;
        }
    }
    keys
    {
        key(PK; "Extension ID", "Trans Unit ID", "Target Language")
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

    procedure GetElementTargetCaptions(): Text
    begin
        exit(Rec."Element Target Caption 1" + Rec."Element Target Caption 2" + Rec."Element Target Caption 3" + Rec."Element Target Caption 4" + Rec."Element Target Caption 5");
    end;

    procedure SetElementTargetCaptions(ElemTargetCapt: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        Rec."Element Target Caption 1" := CopyStr(ElemTargetCapt, TableFieldStartPos, MaxStrLen(Rec."Element Target Caption 1"));
        TableFieldStartPos += MaxStrLen(Rec."Element Target Caption 1");
        Rec."Element Target Caption 2" := CopyStr(ElemTargetCapt, TableFieldStartPos, MaxStrLen(Rec."Element Target Caption 2"));
        TableFieldStartPos += MaxStrLen(Rec."Element Target Caption 2");
        Rec."Element Target Caption 3" := CopyStr(ElemTargetCapt, TableFieldStartPos, MaxStrLen(Rec."Element Target Caption 3"));
        TableFieldStartPos += MaxStrLen(Rec."Element Target Caption 3");
        Rec."Element Target Caption 4" := CopyStr(ElemTargetCapt, TableFieldStartPos, MaxStrLen(Rec."Element Target Caption 4"));
        TableFieldStartPos += MaxStrLen(Rec."Element Target Caption 4");
        Rec."Element Target Caption 5" := CopyStr(ElemTargetCapt, TableFieldStartPos, MaxStrLen(Rec."Element Target Caption 5"));
    end;
}
