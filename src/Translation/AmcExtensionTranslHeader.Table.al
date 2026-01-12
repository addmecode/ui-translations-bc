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

    /// <summary>
    /// Returns the translated XLF file name for the header.
    /// </summary>
    /// <returns>Translated XLF file name.</returns>
    procedure GetTranslatedFileName(): Text
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        exit(ExtTranslMgt.GetTranslatedFileName(Rec));
    end;

    /// <summary>
    /// Validates that translation lines exist for the header.
    /// </summary>
    procedure ValidateExtTranslLinesExist()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.ValidateExtTranslLinesExist(Rec);
    end;

    /// <summary>
    /// Checks whether all lines for the header are translated.
    /// </summary>
    /// <returns>True if all lines are translated.</returns>
    procedure AreAllLinesTranslated(): Boolean
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        exit(ExtTranslMgt.AreAllLinesTranslated(Rec));
    end;

    /// <summary>
    /// Downloads the originally imported XLF file.
    /// </summary>
    procedure DownloadImported()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.DownloadImported(Rec);
    end;

    /// <summary>
    /// Builds and downloads a translated XLF file.
    /// </summary>
    procedure DownloadTranslated()
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.DownloadTranslated(Rec);
    end;

    /// <summary>
    /// Copies a header and its lines to a new target language.
    /// </summary>
    /// <param name="CopyToTargetLang">Target language to copy to.</param>
    procedure CopyExtTranslHeadAndLinesToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CopyExtTranslHeadAndLinesToNewTargetLang(Rec, CopyToTargetLang);
    end;

    /// <summary>
    /// Copies only the header to a new target language.
    /// </summary>
    /// <param name="CopyToTargetLang">Target language to copy to.</param>
    procedure CopyExtTranslHeadToNewTargetLang(CopyToTargetLang: Text[80])
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CopyExtTranslHeadToNewTargetLang(Rec, CopyToTargetLang);
    end;

    /// <summary>
    /// Applies header filters to a translation line record.
    /// </summary>
    /// <param name="ExtTranslLineCopyFrom">Line record to filter or copy from.</param>
    procedure FilterExtTranslLines(var ExtTranslLineCopyFrom: Record "AMC Extension Transl Line")
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.FilterExtTranslLines(ExtTranslLineCopyFrom, Rec);
    end;

    /// <summary>
    /// Creates and inserts a translation header from imported metadata.
    /// </summary>
    /// <param name="ExtID">Extension ID.</param>
    /// <param name="ExtName">Extension name.</param>
    /// <param name="ExtPublisher">Extension publisher.</param>
    /// <param name="ExtVersion">Extension version.</param>
    /// <param name="TargetLang">Target language tag.</param>
    /// <param name="ImportedXlfInStr">Input stream with the imported XLF.</param>
    /// <param name="ImportedFileName">Imported file name.</param>
    /// <param name="SourceLang">Source language tag.</param>
    procedure CreateExtTranslHead(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; TargetLang: Text;
                                  ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
        ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
    begin
        ExtTranslMgt.CreateExtTranslHead(Rec, ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang,
                                         ImportedXlfInStr, ImportedFileName, SourceLang)
    end;
}
