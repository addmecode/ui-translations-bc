table 50100 "ADD_ExtTranslLine"
{
    Caption = 'Element Translation Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            TableRelation = ADD_ExtTranslHeader."Extension ID";
            ValidateTableRelation = true;
            Editable = false;
        }
        field(2; "Trans Unit ID"; Text[250])
        {
            Caption = 'Trans Unit ID';
            Editable = false;
        }
        field(3; "Target Language"; Text[30])
        {
            Caption = 'Target Language';
            TableRelation = ADD_ExtTranslHeader."Target Language";
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
        field(8; Translated; Boolean)
        {
            Caption = 'Translated';
            Editable = true;
        }
        field(10; "Source 1"; Text[250])
        {
            Caption = 'Source 1';
            Editable = false;
        }
        field(11; "Source 2"; Text[250])
        {
            Caption = 'Source 2';
            Editable = false;
        }
        field(12; "Source 3"; Text[250])
        {
            Caption = 'Source 3';
            Editable = false;
        }
        field(13; "Source 4"; Text[250])
        {
            Caption = 'Source 4';
            Editable = false;
        }
        field(14; "Source 5"; Text[250])
        {
            Caption = 'Source 5';
            Editable = false;
        }
        field(20; "Target 1"; Text[250])
        {
            Caption = 'Target 1';
            Editable = false;
        }
        field(21; "Target 2"; Text[250])
        {
            Caption = 'Target 2';
            Editable = false;
        }
        field(22; "Target 3"; Text[250])
        {
            Caption = 'Target 3';
            Editable = false;
        }
        field(23; "Target 4"; Text[250])
        {
            Caption = 'Target 4';
            Editable = false;
        }
        field(24; "Target 5"; Text[250])
        {
            Caption = 'Target 5';
            Editable = false;
        }
        field(30; "New Target 1"; Text[250])
        {
            Caption = 'New Target 1';
            Editable = false;
        }
        field(31; "New Target 2"; Text[250])
        {
            Caption = 'New Target 2';
            Editable = false;
        }
        field(32; "New Target 3"; Text[250])
        {
            Caption = 'New Target 3';
            Editable = false;
        }
        field(33; "New Target 4"; Text[250])
        {
            Caption = 'New Target 4';
            Editable = false;
        }
        field(34; "New Target 5"; Text[250])
        {
            Caption = 'New Target 5';
            Editable = false;
        }
        field(40; "Developer Note 1"; Text[250])
        {
            Caption = 'Developer Note 1';
            Editable = false;
        }
        field(41; "Developer Note 2"; Text[250])
        {
            Caption = 'Developer Note 2';
            Editable = false;
        }
        field(42; "Developer Note 3"; Text[250])
        {
            Caption = 'Developer Note 3';
            Editable = false;
        }
        field(43; "Developer Note 4"; Text[250])
        {
            Caption = 'Developer Note 4';
            Editable = false;
        }
        field(44; "Developer Note 5"; Text[250])
        {
            Caption = 'Developer Note 5';
            Editable = false;
        }
        field(50; "Xliff Note 1"; Text[250])
        {
            Caption = 'Xliff Note 1';
            Editable = false;
        }
        field(51; "Xliff Note 2"; Text[250])
        {
            Caption = 'Xliff Note 2';
            Editable = false;
        }
        field(52; "Xliff Note 3"; Text[250])
        {
            Caption = 'Xliff Note 3';
            Editable = false;
        }
        field(53; "Xliff Note 4"; Text[250])
        {
            Caption = 'Xliff Note 4';
            Editable = false;
        }
        field(54; "Xliff Note 5"; Text[250])
        {
            Caption = 'Xliff Note 5';
            Editable = false;
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

    procedure GetSource(): Text
    begin
        exit(Rec."Source 1" + Rec."Source 2" + Rec."Source 3" + Rec."Source 4" + Rec."Source 5");
    end;

    procedure GetTarget(): Text
    begin
        exit(Rec."Target 1" + Rec."Target 2" + Rec."Target 3" + Rec."Target 4" + Rec."Target 5");
    end;

    procedure GetNewTarget(): Text
    begin
        exit(Rec."New Target 1" + Rec."New Target 2" + Rec."New Target 3" + Rec."New Target 4" + Rec."New Target 5");
    end;

    procedure SetNewTarget(NewTarget: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        Rec."New Target 1" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(Rec."New Target 1"));
        TableFieldStartPos += MaxStrLen(Rec."New Target 1");
        Rec."New Target 2" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(Rec."New Target 2"));
        TableFieldStartPos += MaxStrLen(Rec."New Target 2");
        Rec."New Target 3" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(Rec."New Target 3"));
        TableFieldStartPos += MaxStrLen(Rec."New Target 3");
        Rec."New Target 4" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(Rec."New Target 4"));
        TableFieldStartPos += MaxStrLen(Rec."New Target 4");
        Rec."New Target 5" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(Rec."New Target 5"));
    end;

    procedure SetTarget(Target: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        Rec."Target 1" := CopyStr(Target, TableFieldStartPos, MaxStrLen(Rec."Target 1"));
        TableFieldStartPos += MaxStrLen(Rec."Target 1");
        Rec."Target 2" := CopyStr(Target, TableFieldStartPos, MaxStrLen(Rec."Target 2"));
        TableFieldStartPos += MaxStrLen(Rec."Target 2");
        Rec."Target 3" := CopyStr(Target, TableFieldStartPos, MaxStrLen(Rec."Target 3"));
        TableFieldStartPos += MaxStrLen(Rec."Target 3");
        Rec."Target 4" := CopyStr(Target, TableFieldStartPos, MaxStrLen(Rec."Target 4"));
        TableFieldStartPos += MaxStrLen(Rec."Target 4");
        Rec."Target 5" := CopyStr(Target, TableFieldStartPos, MaxStrLen(Rec."Target 5"));
    end;

    procedure SetSource(Source: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        Rec."Source 1" := CopyStr(Source, TableFieldStartPos, MaxStrLen(Rec."Source 1"));
        TableFieldStartPos += MaxStrLen(Rec."Source 1");
        Rec."Source 2" := CopyStr(Source, TableFieldStartPos, MaxStrLen(Rec."Source 2"));
        TableFieldStartPos += MaxStrLen(Rec."Source 2");
        Rec."Source 3" := CopyStr(Source, TableFieldStartPos, MaxStrLen(Rec."Source 3"));
        TableFieldStartPos += MaxStrLen(Rec."Source 3");
        Rec."Source 4" := CopyStr(Source, TableFieldStartPos, MaxStrLen(Rec."Source 4"));
        TableFieldStartPos += MaxStrLen(Rec."Source 4");
        Rec."Source 5" := CopyStr(Source, TableFieldStartPos, MaxStrLen(Rec."Source 5"));
    end;
}
