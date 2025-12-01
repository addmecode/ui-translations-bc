table 50102 "ADD_ExtTranslHeader"
{
    Caption = 'Extension Translation Header';
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
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.DeleteAllExtTranslHeadLines(Rec);
    end;

    procedure GetTranslatedFileName(): Text
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        exit(ExtTranslMgt.GetTranslatedFileName(Rec));
    end;

    procedure ValidateExtTranslLinesExist()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.ValidateExtTranslLinesExist(Rec);
    end;

    procedure AreAllLinesTranslated(): Boolean
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        exit(ExtTranslMgt.AreAllLinesTranslated(Rec));
    end;

    procedure DownloadImported()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.DownloadImported(Rec);
    end;

    procedure DownloadTranslated()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.DownloadTranslated(Rec);
    end;

    procedure CopyExtTranslHeadAndLinesToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.CopyExtTranslHeadAndLinesToNewTargetLang(Rec, CopyToTargetLang);
    end;

    procedure CopyExtTranslHeadToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.CopyExtTranslHeadToNewTargetLang(Rec, CopyToTargetLang);
    end;

    procedure FilterExtTranslLines(var ExtTranslLineCopyFrom: Record ADD_ExtTranslLine)
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.FilterExtTranslLines(ExtTranslLineCopyFrom, Rec);
    end;

    procedure CreateExtTranslHead(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; TargetLang: Text;
                                  ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.CreateExtTranslHead(Rec, ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang,
                                         ImportedXlfInStr, ImportedFileName, SourceLang)
    end;

}
