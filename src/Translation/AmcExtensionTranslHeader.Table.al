table 50101 "AMC Extension Transl Header"
{
    Caption = 'Extension Translation Header';
    DataClassification = CustomerContent;
    DrillDownPageId = "AMC Extension Transl Card";
    LookupPageId = "AMC Extension Transl Card";

    fields
    {
        field(1; "Extension ID"; Guid)
        {
            Caption = 'Extension ID';
            Editable = false;
            TableRelation = "NAV App Installed App"."App ID";
            ValidateTableRelation = false;
        }
        field(2; "Target Language"; Text[80])
        {
            Caption = 'Target Language';
            Editable = false;
            TableRelation = "Windows Language"."Language Tag";
        }
        field(3; "Source Language"; Text[80])
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
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.DeleteAllExtTranslHeadLines(Rec);
    end;

    procedure GetTranslatedFileName(): Text
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        exit(ExtTranslMgt.GetTranslatedFileName(Rec));
    end;

    procedure ValidateExtTranslLinesExist()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.ValidateExtTranslLinesExist(Rec);
    end;

    procedure AreAllLinesTranslated(): Boolean
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        exit(ExtTranslMgt.AreAllLinesTranslated(Rec));
    end;

    procedure DownloadImported()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.DownloadImported(Rec);
    end;

    procedure DownloadTranslated()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.DownloadTranslated(Rec);
    end;

    procedure CopyExtTranslHeadAndLinesToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CopyExtTranslHeadAndLinesToNewTargetLang(Rec, CopyToTargetLang);
    end;

    procedure CopyExtTranslHeadToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CopyExtTranslHeadToNewTargetLang(Rec, CopyToTargetLang);
    end;

    procedure FilterExtTranslLines(var ExtTranslLineCopyFrom: Record "AMC Extension Transl Line")
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.FilterExtTranslLines(ExtTranslLineCopyFrom, Rec);
    end;

    procedure CreateExtTranslHead(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; TargetLang: Text;
                                  ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CreateExtTranslHead(Rec, ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang,
                                         ImportedXlfInStr, ImportedFileName, SourceLang)
    end;
}
