codeunit 50100 "AMC Extension Transl Mgt"
{
    /// <summary>
    /// Deletes all translation lines that belong to the specified header.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    internal procedure DeleteAllExtTranslHeadLines(ExtTranslHead: Record "AMC Extension Transl Header")
    var
        ExtTransLine: Record "AMC Extension Transl Line";
    begin
        ExtTransLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTransLine.SetRange("Target Language", ExtTranslHead."Target Language");
        ExtTransLine.DeleteAll(true);
    end;

    /// <summary>
    /// Returns concatenated developer notes for the specified line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <returns>Concatenated developer notes.</returns>
    internal procedure GetExtTransLineDeveloperNotes(ExtTranslLine: Record "AMC Extension Transl Line"): Text
    begin
        exit(this.GetConcatenatedFields(ExtTranslLine, 'Developer Note', 5));
    end;

    /// <summary>
    /// Returns concatenated source text for the specified line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <returns>Concatenated source text.</returns>
    internal procedure GetExtTransLineSource(ExtTranslLine: Record "AMC Extension Transl Line"): Text
    begin
        exit(this.GetConcatenatedFields(ExtTranslLine, 'Source', 5));
    end;

    /// <summary>
    /// Returns concatenated target text for the specified line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <returns>Concatenated target text.</returns>
    internal procedure GetExtTransLineTarget(ExtTranslLine: Record "AMC Extension Transl Line"): Text
    begin
        exit(this.GetConcatenatedFields(ExtTranslLine, 'Target', 5));
    end;

    /// <summary>
    /// Returns concatenated new target text for the specified line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <returns>Concatenated new target text.</returns>
    internal procedure GetExtTransLineNewTarget(ExtTranslLine: Record "AMC Extension Transl Line"): Text
    begin
        exit(this.GetConcatenatedFields(ExtTranslLine, 'New Target', 5));
    end;

    /// <summary>
    /// Returns concatenated Xliff notes for the specified line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <returns>Concatenated Xliff notes.</returns>
    internal procedure GetExtTransLineXliffNote(ExtTranslLine: Record "AMC Extension Transl Line"): Text
    begin
        exit(this.GetConcatenatedFields(ExtTranslLine, 'Xliff Note', 5));
    end;

    local procedure GetConcatenatedFields(ExtTranslLine: Record "AMC Extension Transl Line"; FieldPrefix: Text; NumberOfFields: Integer): Text
    var
        i: Integer;
        FieldValue: Text;
        Result: Text;
    begin
        for i := 1 to NumberOfFields do begin
            FieldValue := this.GetFieldValue(ExtTranslLine, FieldPrefix, i);
            Result += FieldValue;
        end;
        exit(Result);
    end;

    local procedure GetFieldValue(ExtTranslLine: Record "AMC Extension Transl Line"; FieldPrefix: Text; Index: Integer): Text
    begin
        case UpperCase(FieldPrefix) of
            'DEVELOPER NOTE':
                case Index of
                    1:
                        exit(ExtTranslLine."Developer Note 1");
                    2:
                        exit(ExtTranslLine."Developer Note 2");
                    3:
                        exit(ExtTranslLine."Developer Note 3");
                    4:
                        exit(ExtTranslLine."Developer Note 4");
                    5:
                        exit(ExtTranslLine."Developer Note 5");
                end;
            'SOURCE':
                case Index of
                    1:
                        exit(ExtTranslLine."Source 1");
                    2:
                        exit(ExtTranslLine."Source 2");
                    3:
                        exit(ExtTranslLine."Source 3");
                    4:
                        exit(ExtTranslLine."Source 4");
                    5:
                        exit(ExtTranslLine."Source 5");
                end;
            'TARGET':
                case Index of
                    1:
                        exit(ExtTranslLine."Target 1");
                    2:
                        exit(ExtTranslLine."Target 2");
                    3:
                        exit(ExtTranslLine."Target 3");
                    4:
                        exit(ExtTranslLine."Target 4");
                    5:
                        exit(ExtTranslLine."Target 5");
                end;
            'NEW TARGET':
                case Index of
                    1:
                        exit(ExtTranslLine."New Target 1");
                    2:
                        exit(ExtTranslLine."New Target 2");
                    3:
                        exit(ExtTranslLine."New Target 3");
                    4:
                        exit(ExtTranslLine."New Target 4");
                    5:
                        exit(ExtTranslLine."New Target 5");
                end;
            'XLIFF NOTE':
                case Index of
                    1:
                        exit(ExtTranslLine."Xliff Note 1");
                    2:
                        exit(ExtTranslLine."Xliff Note 2");
                    3:
                        exit(ExtTranslLine."Xliff Note 3");
                    4:
                        exit(ExtTranslLine."Xliff Note 4");
                    5:
                        exit(ExtTranslLine."Xliff Note 5");
                end;
        end;
        exit('');
    end;

    /// <summary>
    /// Sets the new target fields on a translation line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <param name="NewTarget">New target text.</param>
    internal procedure SetExtTransLineNewTarget(var ExtTranslLine: Record "AMC Extension Transl Line"; NewTarget: Text)
    begin
        this.SetConcatenatedFields(ExtTranslLine, 'New Target', NewTarget, 5);
    end;

    /// <summary>
    /// Sets the target fields on a translation line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <param name="Target">Target text.</param>
    internal procedure SetExtTransLineTarget(var ExtTranslLine: Record "AMC Extension Transl Line"; Target: Text)
    begin
        this.SetConcatenatedFields(ExtTranslLine, 'Target', Target, 5);
    end;

    /// <summary>
    /// Sets the source fields on a translation line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <param name="Source">Source text.</param>
    internal procedure SetExtTransLineSource(var ExtTranslLine: Record "AMC Extension Transl Line"; Source: Text)
    begin
        this.SetConcatenatedFields(ExtTranslLine, 'Source', Source, 5);
    end;

    /// <summary>
    /// Sets the developer note fields on a translation line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <param name="DevNote">Developer note text.</param>
    internal procedure SetExtTransLineDevNote(var ExtTranslLine: Record "AMC Extension Transl Line"; DevNote: Text)
    begin
        this.SetConcatenatedFields(ExtTranslLine, 'Developer Note', DevNote, 5);
    end;

    /// <summary>
    /// Sets the Xliff note fields on a translation line.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    /// <param name="XliffNote">Xliff note text.</param>
    internal procedure SetExtTransLineXliffNote(var ExtTranslLine: Record "AMC Extension Transl Line"; XliffNote: Text)
    begin
        this.SetConcatenatedFields(ExtTranslLine, 'Xliff Note', XliffNote, 5);
    end;

    local procedure SetConcatenatedFields(var ExtTranslLine: Record "AMC Extension Transl Line"; FieldPrefix: Text; Value: Text; NumberOfFields: Integer)
    var
        FieldLength: Integer;
        i: Integer;
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        for i := 1 to NumberOfFields do begin
            FieldLength := this.GetFieldMaxLength(FieldPrefix, i);
            this.SetFieldValue(ExtTranslLine, FieldPrefix, i, CopyStr(Value, TableFieldStartPos, FieldLength));
            TableFieldStartPos += FieldLength;
        end;
    end;

    local procedure GetFieldMaxLength(FieldPrefix: Text; Index: Integer): Integer
    var
        ExtTranslLine: Record "AMC Extension Transl Line";
    begin
        case UpperCase(FieldPrefix) of
            'DEVELOPER NOTE':
                case Index of
                    1:
                        exit(MaxStrLen(ExtTranslLine."Developer Note 1"));
                    2:
                        exit(MaxStrLen(ExtTranslLine."Developer Note 2"));
                    3:
                        exit(MaxStrLen(ExtTranslLine."Developer Note 3"));
                    4:
                        exit(MaxStrLen(ExtTranslLine."Developer Note 4"));
                    5:
                        exit(MaxStrLen(ExtTranslLine."Developer Note 5"));
                end;
            'SOURCE':
                case Index of
                    1:
                        exit(MaxStrLen(ExtTranslLine."Source 1"));
                    2:
                        exit(MaxStrLen(ExtTranslLine."Source 2"));
                    3:
                        exit(MaxStrLen(ExtTranslLine."Source 3"));
                    4:
                        exit(MaxStrLen(ExtTranslLine."Source 4"));
                    5:
                        exit(MaxStrLen(ExtTranslLine."Source 5"));
                end;
            'TARGET':
                case Index of
                    1:
                        exit(MaxStrLen(ExtTranslLine."Target 1"));
                    2:
                        exit(MaxStrLen(ExtTranslLine."Target 2"));
                    3:
                        exit(MaxStrLen(ExtTranslLine."Target 3"));
                    4:
                        exit(MaxStrLen(ExtTranslLine."Target 4"));
                    5:
                        exit(MaxStrLen(ExtTranslLine."Target 5"));
                end;
            'NEW TARGET':
                case Index of
                    1:
                        exit(MaxStrLen(ExtTranslLine."New Target 1"));
                    2:
                        exit(MaxStrLen(ExtTranslLine."New Target 2"));
                    3:
                        exit(MaxStrLen(ExtTranslLine."New Target 3"));
                    4:
                        exit(MaxStrLen(ExtTranslLine."New Target 4"));
                    5:
                        exit(MaxStrLen(ExtTranslLine."New Target 5"));
                end;
            'XLIFF NOTE':
                case Index of
                    1:
                        exit(MaxStrLen(ExtTranslLine."Xliff Note 1"));
                    2:
                        exit(MaxStrLen(ExtTranslLine."Xliff Note 2"));
                    3:
                        exit(MaxStrLen(ExtTranslLine."Xliff Note 3"));
                    4:
                        exit(MaxStrLen(ExtTranslLine."Xliff Note 4"));
                    5:
                        exit(MaxStrLen(ExtTranslLine."Xliff Note 5"));
                end;
        end;
        exit(0);
    end;

    local procedure SetFieldValue(var ExtTranslLine: Record "AMC Extension Transl Line"; FieldPrefix: Text; Index: Integer; Value: Text)
    begin
        case UpperCase(FieldPrefix) of
            'DEVELOPER NOTE':
                case Index of
                    1:
                        ExtTranslLine."Developer Note 1" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Developer Note 1"));
                    2:
                        ExtTranslLine."Developer Note 2" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Developer Note 2"));
                    3:
                        ExtTranslLine."Developer Note 3" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Developer Note 3"));
                    4:
                        ExtTranslLine."Developer Note 4" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Developer Note 4"));
                    5:
                        ExtTranslLine."Developer Note 5" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Developer Note 5"));
                end;
            'SOURCE':
                case Index of
                    1:
                        ExtTranslLine."Source 1" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Source 1"));
                    2:
                        ExtTranslLine."Source 2" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Source 2"));
                    3:
                        ExtTranslLine."Source 3" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Source 3"));
                    4:
                        ExtTranslLine."Source 4" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Source 4"));
                    5:
                        ExtTranslLine."Source 5" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Source 5"));
                end;
            'TARGET':
                case Index of
                    1:
                        ExtTranslLine."Target 1" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Target 1"));
                    2:
                        ExtTranslLine."Target 2" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Target 2"));
                    3:
                        ExtTranslLine."Target 3" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Target 3"));
                    4:
                        ExtTranslLine."Target 4" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Target 4"));
                    5:
                        ExtTranslLine."Target 5" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Target 5"));
                end;
            'NEW TARGET':
                case Index of
                    1:
                        ExtTranslLine."New Target 1" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."New Target 1"));
                    2:
                        ExtTranslLine."New Target 2" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."New Target 2"));
                    3:
                        ExtTranslLine."New Target 3" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."New Target 3"));
                    4:
                        ExtTranslLine."New Target 4" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."New Target 4"));
                    5:
                        ExtTranslLine."New Target 5" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."New Target 5"));
                end;
            'XLIFF NOTE':
                case Index of
                    1:
                        ExtTranslLine."Xliff Note 1" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Xliff Note 1"));
                    2:
                        ExtTranslLine."Xliff Note 2" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Xliff Note 2"));
                    3:
                        ExtTranslLine."Xliff Note 3" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Xliff Note 3"));
                    4:
                        ExtTranslLine."Xliff Note 4" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Xliff Note 4"));
                    5:
                        ExtTranslLine."Xliff Note 5" := CopyStr(Value, 1, MaxStrLen(ExtTranslLine."Xliff Note 5"));
                end;
        end;
    end;

    /// <summary>
    /// Runs the object referenced by the translation line.
    /// </summary>
    /// <param name="ElemTransl">Translation line that references an object.</param>
    internal procedure RunObject(ElemTransl: Record "AMC Extension Transl Line")
    var
        AllObj: Record AllObjWithCaption;
        Utilities: Codeunit "AMC Utilities";
        ObjNotFoundErr: Label 'Object %1 %2 not found', Comment = '%1 is object type, %2 is object name';
        ObjTypeNotSuppErr: Label 'Object Type %1 is not supported', Comment = '%1 is object type';
    begin
        case UpperCase(ElemTransl."Object Type") of
            'TABLE':
                AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
            'PAGE':
                AllObj.SetRange("Object Type", AllObj."Object Type"::Page);
            else
                Error(ObjTypeNotSuppErr, ElemTransl."Object Type");
        end;
        AllObj.SetRange("Object Name", ElemTransl."Object Name");
        if not AllObj.FindFirst() then
            Error(ObjNotFoundErr, ElemTransl."Object Type", ElemTransl."Object Name");
        Utilities.RunObject(AllObj, false);
    end;

    /// <summary>
    /// Prompts the user to select a language tag.
    /// </summary>
    /// <returns>Selected language tag, or empty if canceled.</returns>
    internal procedure SelectLangTag(): Text[80]
    var
        WindLang: Record "Windows Language";
    begin
        if Page.RunModal(Page::"Windows Languages", WindLang) = Action::LookupOK then
            exit(WindLang."Language Tag");
        exit('');
    end;

    /// <summary>
    /// Imports an XLF file and creates translation headers and lines.
    /// </summary>
    /// <param name="CreatedExtTranslHead">Header record to receive the created entry.</param>
    /// <param name="ExtID">Extension ID.</param>
    /// <param name="ExtName">Extension name.</param>
    /// <param name="ExtPublisher">Extension publisher.</param>
    /// <param name="ExtVersion">Extension version.</param>
    /// <param name="ImportTargetLang">Whether to take the target language from the file.</param>
    /// <param name="TargetLang">Target language tag.</param>
    internal procedure ImportXlf(var CreatedExtTranslHead: Record "AMC Extension Transl Header"; ExtID: Guid; ExtName: Text[250]; ExtPublisher: Text[250]; ExtVersion: Text[250]; ImportTargetLang: Boolean; TargetLang: Text)
    var
        CreatedExtTranslLine: Record "AMC Extension Transl Line";
        Utilities: Codeunit "AMC Utilities";
        XmlUtilities: Codeunit "AMC Xml Utilities";
        TempBlob: Codeunit "Temp Blob";
        PROGRESS_UPDATE_PERCENT: Decimal;
        Progress: Dialog;
        ImportedXlfInStr: InStream;
        XlfHeadInStr: InStream;
        XlfXmlInStr: InStream;
        ProgrUpdBatch: Integer;
        TransUnitCounter: Integer;
        FirstProgrStepMsg: Label 'Importing File: %1', Comment = '%1 is file name';
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        SecProgrStepMsg: Label 'Importing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        SelectXlfFileLbl: Label 'Select Xlf file';
        XlfFileFilterLbl: Label 'Xlf Files (*.xlf)|*.xlf', Locked = true;
        TempOutStr: OutStream;
        DeveloperNote: Text;
        ImportedFileName: Text;
        NS_PREFIX: Text;
        SourceLang: Text;
        SourceTxt: Text;
        TargetLangFromXlf: Text;
        TargetTxt: Text;
        TuId: Text;
        XliffNote: Text;
        XmlDoc: XmlDocument;
        NsMgr: XmlNamespaceManager;
        TransUnitNode: XmlNode;
        TransUnitNodeList: XmlNodeList;
    begin
        PROGRESS_UPDATE_PERCENT := 0.1;
        NS_PREFIX := 'x';
        TransUnitCounter := 0;
        this.ImportXlfValidateParams(ExtID, ImportTargetLang, TargetLang);
        this.DeleteAllExtTranslHeadWithExtIdIfConf(ExtID);
        if not UploadIntoStream(SelectXlfFileLbl, '', XlfFileFilterLbl, ImportedFileName, ImportedXlfInStr) then
            exit;
        TempBlob.CreateOutStream(TempOutStr);
        CopyStream(TempOutStr, ImportedXlfInStr);
        TempBlob.CreateInStream(XlfXmlInStr);
        if GuiAllowed then begin
            Progress.Open(ProgressMsg);
            Progress.Update(1, StrSubstNo(FirstProgrStepMsg, ImportedFileName));
        end;
        XmlUtilities.GetXmlDocumentAndNamespaceManagerFromInStream(XlfXmlInStr, NS_PREFIX, XmlDoc, NsMgr);
        this.GetTargetAndSourceLangFromXlf(XmlDoc, NsMgr, NS_PREFIX, SourceLang, TargetLangFromXlf);
        if ImportTargetLang then
            TargetLang := TargetLangFromXlf;
        TempBlob.CreateInStream(XlfHeadInStr);
        CreatedExtTranslHead.CreateExtTranslHead(ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang, XlfHeadInStr, ImportedFileName, SourceLang);

        this.GetAllTransUnitIds(XmlDoc, NsMgr, NS_PREFIX, TransUnitNodeList);
        ProgrUpdBatch := Utilities.GetUpdateProgressBatch(TransUnitNodeList.Count(), PROGRESS_UPDATE_PERCENT);
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if GuiAllowed and (TransUnitCounter mod ProgrUpdBatch = 0) then
                Progress.Update(2, StrSubstNo(SecProgrStepMsg, TransUnitCounter, TransUnitNodeList.Count()));
            this.ParseTransUnitIdNode(TransUnitNode, NsMgr, NS_PREFIX, TuId, SourceTxt, TargetTxt, DeveloperNote, XliffNote);
            CreatedExtTranslLine.CreateExtTranslLine(ExtID, TargetLang, TuId, SourceTxt, TargetTxt, DeveloperNote, XliffNote);
        end;
        if GuiAllowed then
            Progress.Close();
    end;

    local procedure ImportXlfValidateParams(ExtID: Guid; ImportTargetLang: Boolean; TargetLang: Text)
    var
        EmptyExtIdErr: Label 'Extension ID cannot be empty';
        EmptyTargetLangErr: Label 'Target Language must be specified when Import Target Language is set to false';
    begin
        if IsNullGuid(ExtID) then
            Error(EmptyExtIdErr);
        if (not ImportTargetLang) and (TargetLang = '') then
            Error(EmptyTargetLangErr);
    end;

    local procedure DeleteAllExtTranslHeadWithExtIdIfConf(var ExtID: Guid)
    var
        ElTranslHead: Record "AMC Extension Transl Header";
        DelExtTranslQst: Label 'Extension Translations already exist for %1 Extension ID. Do you want to delete them and continue?', Comment = '%1 is Extension ID value';
    begin
        ElTranslHead.SetRange("Extension ID", ExtID);
        if ElTranslHead.FindSet() then begin
            if not Confirm(DelExtTranslQst, false, ExtID) then
                exit;
            ElTranslHead.DeleteAll(true);
        end;
    end;

    local procedure GetTargetAndSourceLangFromXlf(XmlDoc: XmlDocument; NsMgr: XmlNamespaceManager; NsPrefix: Text; var SourceLang: Text; var TargetLang: Text)
    var
        XmlUtilities: Codeunit "AMC Xml Utilities";
        FileAttributes: XmlAttributeCollection;
        FileNode: XmlNode;
    begin
        XmlDoc.SelectSingleNode('//' + NsPrefix + ':file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        SourceLang := XmlUtilities.GetAttributeValueFromCollection(FileAttributes, 'source-language');
        TargetLang := XmlUtilities.GetAttributeValueFromCollection(FileAttributes, 'target-language');
    end;

    /// <summary>
    /// Creates and inserts a translation header from imported metadata.
    /// </summary>
    /// <param name="NewExtTranslHead">Header record to initialize.</param>
    /// <param name="ExtID">Extension ID.</param>
    /// <param name="ExtName">Extension name.</param>
    /// <param name="ExtPublisher">Extension publisher.</param>
    /// <param name="ExtVersion">Extension version.</param>
    /// <param name="TargetLang">Target language tag.</param>
    /// <param name="ImportedXlfInStr">Input stream with the imported XLF.</param>
    /// <param name="ImportedFileName">Imported file name.</param>
    /// <param name="SourceLang">Source language tag.</param>
    internal procedure CreateExtTranslHead(var NewExtTranslHead: Record "AMC Extension Transl Header"; ExtID: Guid; ExtName: Text; ExtPublisher: Text;
                                           ExtVersion: Text; TargetLang: Text; ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
        OutStr: OutStream;
    begin
#pragma warning disable AA0139
        NewExtTranslHead.Init();
        NewExtTranslHead."Extension ID" := ExtID;
        NewExtTranslHead."Target Language" := TargetLang;
        NewExtTranslHead."Extension Name" := ExtName;
        NewExtTranslHead."Extension Publisher" := ExtPublisher;
        NewExtTranslHead."Extension Version" := ExtVersion;
        NewExtTranslHead."Imported FileName" := ImportedFileName;
        NewExtTranslHead."Source Language" := SourceLang;
        NewExtTranslHead."Imported Xlf".CreateOutStream(OutStr);
        CopyStream(OutStr, ImportedXlfInStr);
        NewExtTranslHead.Insert(false);
#pragma warning restore AA0139
    end;

    local procedure GetAllTransUnitIds(XmlDoc: XmlDocument; NsMgr: XmlNamespaceManager; NsPrefix: Text; var TransUnitNodeList: XmlNodeList)
    begin
        XmlDoc.SelectNodes('//' + NsPrefix + ':file/' +
                            NsPrefix + ':body/' +
                            NsPrefix + ':group/' +
                            NsPrefix + ':trans-unit',
                            NsMgr, TransUnitNodeList);
    end;

    local procedure ParseTransUnitIdNode(TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text; var TuId: Text; var SourceTxt: Text; var TargetTxt: Text; var DeveloperNote: Text; var XliffNote: Text)
    var
        NoteNode: XmlNode;
        SourceNode: XmlNode;
        TargetNode: XmlNode;
        NoteNodeList: XmlNodeList;
    begin
        TuId := this.GetTransUnitIdFromTransUnitNode(TransUnitNode);
        this.GetSourceFromTransUnit(SourceNode, TransUnitNode, NsMgr, NsPrefix);
        SourceTxt := SourceNode.AsXmlElement().InnerText();
        TargetTxt := '';
        if this.GetTargetFromTransUnit(TargetNode, TransUnitNode, NsMgr, NsPrefix) then
            TargetTxt := TargetNode.AsXmlElement().InnerText();

        TransUnitNode.SelectNodes(NsPrefix + ':note', NsMgr, NoteNodeList);
        foreach NoteNode in NoteNodeList do
            case (true) of
                this.IsDeveloperNoteNode(NoteNode):
                    DeveloperNote := NoteNode.AsXmlElement().InnerText();
                this.IsXliffGeneratorNoteNode(NoteNode):
                    XliffNote := NoteNode.AsXmlElement().InnerText();
            end;
    end;

    local procedure GetTransUnitIdFromTransUnitNode(var TransUnitNode: XmlNode): Text
    var
        TransUnitAttr: XmlAttribute;
        TransUnitAttributes: XmlAttributeCollection;
    begin
        TransUnitAttributes := TransUnitNode.AsXmlElement().Attributes();
        TransUnitAttributes.Get('id', TransUnitAttr);
        exit(TransUnitAttr.Value());
    end;

    local procedure GetSourceFromTransUnit(var SourceNode: XmlNode; TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text): Boolean
    begin
        exit(TransUnitNode.SelectSingleNode(NsPrefix + ':source', NsMgr, SourceNode));
    end;

    local procedure GetTargetFromTransUnit(var TargetNode: XmlNode; TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text): Boolean
    begin
        exit(TransUnitNode.SelectSingleNode(NsPrefix + ':target', NsMgr, TargetNode));
    end;

    local procedure IsDeveloperNoteNode(NoteNode: XmlNode): Boolean
    var
        XmlUtilities: Codeunit "AMC Xml Utilities";
        NoteAttr: XmlAttribute;
    begin
        XmlUtilities.GetElementAttribute(NoteAttr, 'from', NoteNode);
        exit(NoteAttr.Value() = 'Developer');
    end;

    local procedure IsXliffGeneratorNoteNode(NoteNode: XmlNode): Boolean
    var
        XmlUtilities: Codeunit "AMC Xml Utilities";
        NoteAttr: XmlAttribute;
    begin
        XmlUtilities.GetElementAttribute(NoteAttr, 'from', NoteNode);
        exit(NoteAttr.Value() = 'Xliff Generator');
    end;

    /// <summary>
    /// Creates and inserts a translation line from XLF data.
    /// </summary>
    /// <param name="NewElTransl">Line record to initialize.</param>
    /// <param name="ExtId">Extension ID.</param>
    /// <param name="TargetLang">Target language tag.</param>
    /// <param name="TuId">Translation unit ID.</param>
    /// <param name="SourceTxt">Source text.</param>
    /// <param name="TargetTxt">Target text.</param>
    /// <param name="DeveloperNote">Developer note text.</param>
    /// <param name="XliffNote">Xliff note text.</param>
    internal procedure CreateExtTranslLine(var NewElTransl: Record "AMC Extension Transl Line"; ExtId: Guid; TargetLang: Text; TuId: Text;
                                           SourceTxt: Text; TargetTxt: Text; DeveloperNote: Text; XliffNote: Text)
    begin
        NewElTransl.Init();
        NewElTransl."Extension ID" := ExtId;
        NewElTransl."Target Language" := CopyStr(TargetLang, 1, MaxStrLen(NewElTransl."Target Language"));
        NewElTransl."Trans Unit ID" := CopyStr(TuId, 1, MaxStrLen(NewElTransl."Trans Unit ID"));
        NewElTransl.Translated := false;
        NewElTransl.SetXliffNote(XliffNote);
        NewElTransl.SetSource(SourceTxt);
        NewElTransl.SetTarget(TargetTxt);
        NewElTransl.SetNewTarget(TargetTxt);
        NewElTransl.SetDevNote(DeveloperNote);
        NewElTransl.ParseXliffNote();
        NewElTransl.Insert(false);
    end;

    /// <summary>
    /// Parses the Xliff note and updates object and element fields.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    internal procedure ParseXliffNote(var ExtTranslLine: Record "AMC Extension Transl Line")
    var
        ElemNameStartPart: Integer;
        ElemTypeStartPart: Integer;
        FoundUnhandledTransUnitPartErr: Label 'Found %1 parts in Trans unit id: %2', Comment = '%1 is " - " parts number, %2 is trans unit id value';
        TuHyphenParts: List of [Text];
        ElemNameFirstWord: Text;
        ElemTypeFirstWord: Text;
        SPLIT_BY: Text;
        XliffNote: Text;
    begin
        // e.g 1
        // <trans-unit id="Page 1023993454 - Action 1376376002 - Property 1295455071"
        // <note from="Xliff Generator" annotates="general" priority="3">Page Contact List - Action NewSalesQuote - Property ToolTip</note>
        // ObjType = Page, ObjName = Contact List, ElementName = Action NewSalesQuote, ElementType = Property ToolTip
        // e.g 2
        // <trans-unit id="Codeunit 1151451258 - NamedType 2419749672"
        // <note from="Xliff Generator" annotates="general" priority="3">Codeunit Cash Flow Wksh. - Register - NamedType RegisterWorksheetLinesQst</note>
        // ObjType = Codeunit, ObjName = Cash Flow Wksh. - Register, ElementName = , ElementType = NamedType RegisterWorksheetLinesQst
        // e.g 3
        // <trans-unit id="Page 1007051012 - Control 4154341761 - Property 1295455071"
        // <note from="Xliff Generator" annotates="general" priority="3">Page Report Selection - VAT Stmt. - Control Sequence - Property ToolTip</note>
        // ObjType = Page, ObjName = Report Selection - VAT Stmt., ElementName = Control Sequence, ElementType = Property ToolTip
        // e.g 4
        // <trans-unit id="Page 3259548000 - Control 2961552353 - Method 2126772001 - NamedType 1758523981"
        // <note from="Xliff Generator" annotates="general" priority="3">Page CDS New Man. Int. Table Wizard - Control Name - Method OnValidate - NamedType IntegrationMappingNameExistErr</note>
        // ObjType = Page, ObjName =  CDS New Man. Int. Table Wizard, ElementName = Control Name - Method OnValidate, ElementType = NamedType IntegrationMappingNameExistErr

#pragma warning disable AA0139
        SPLIT_BY := ' - ';
        TuHyphenParts := ExtTranslLine."Trans Unit ID".Split(SPLIT_BY);
        ExtTranslLine."Object Type" := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(1));
        case TuHyphenParts.Count() of
            4:
                begin
                    ElemNameFirstWord := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(4));
                end;
            3:
                begin
                    ElemNameFirstWord := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(3));
                end;
            2:
                begin
                    ElemNameFirstWord := '';
                    ElemTypeFirstWord := this.GetTextPartBeforeFirstSpace(TuHyphenParts.Get(2));
                end;
            else
                Error(FoundUnhandledTransUnitPartErr, TuHyphenParts.Count(), ExtTranslLine."Trans Unit ID");
        end;
        XliffNote := ExtTranslLine.GetXliffNote();
        ElemTypeStartPart := XliffNote.LastIndexOf(' - ' + ElemTypeFirstWord);
        ExtTranslLine."Element Type" := XliffNote.Substring(ElemTypeStartPart + StrLen(SPLIT_BY));
        XliffNote := XliffNote.Substring(1, ElemTypeStartPart - 1);
        if ElemNameFirstWord <> '' then begin
            ElemNameStartPart := XliffNote.LastIndexOf(' - ' + ElemNameFirstWord);
            ExtTranslLine."Element Name" := XliffNote.Substring(ElemNameStartPart + StrLen(SPLIT_BY));
            XliffNote := XliffNote.Substring(1, ElemNameStartPart - 1);
        end;
        ExtTranslLine."Object Name" := XliffNote.Substring(StrLen(ExtTranslLine."Object Type") + 2);
#pragma warning restore AA0139
    end;

    local procedure GetTextPartBeforeFirstSpace(InputText: Text): Text
    var
        SpaceIndex: Integer;
    begin
        SpaceIndex := InputText.IndexOf(' ');
        if SpaceIndex = 0 then
            exit(InputText);
        exit(InputText.Substring(1, SpaceIndex - 1));
    end;

    /// <summary>
    /// Copies a header and its lines to a new target language.
    /// </summary>
    /// <param name="ExtTranslHeadCopyFrom">Header record to copy from.</param>
    /// <param name="CopyToTargetLang">Target language to copy to.</param>
    internal procedure CopyExtTranslHeadAndLinesToNewTargetLang(ExtTranslHeadCopyFrom: Record "AMC Extension Transl Header"; CopyToTargetLang: Text[80])
    var
        ExtTranslLineCopyFrom: Record "AMC Extension Transl Line";
        Utilities: Codeunit "AMC Utilities";
        PROGRESS_UPDATE_PERCENT: Decimal;
        Progress: Dialog;
        LinesCounter: Integer;
        LinesNumber: Integer;
        ProgrUpdBatch: Integer;
        FirstProgrStepMsg: Label 'Copying Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        ProgressMsg: Label '#1', Comment = '#1 is first step label';
    begin
        PROGRESS_UPDATE_PERCENT := 0.1;
        LinesCounter := 0;
        if GuiAllowed then
            Progress.Open(ProgressMsg);
        this.CopyExtTranslHeadAndLinesToNewTargLangValidateParams(ExtTranslHeadCopyFrom, CopyToTargetLang);
        ExtTranslHeadCopyFrom.CopyExtTranslHeadToNewTargetLang(CopyToTargetLang);
        ExtTranslHeadCopyFrom.FilterExtTranslLines(ExtTranslLineCopyFrom);
        LinesNumber := ExtTranslLineCopyFrom.Count();
        ProgrUpdBatch := Utilities.GetUpdateProgressBatch(LinesNumber, PROGRESS_UPDATE_PERCENT);
        if ExtTranslLineCopyFrom.FindSet() then
            repeat
                LinesCounter += 1;
                if GuiAllowed and (LinesCounter mod ProgrUpdBatch = 0) then
                    Progress.Update(1, StrSubstNo(FirstProgrStepMsg, LinesCounter, LinesNumber));
                ExtTranslLineCopyFrom.CopyToNewTargetLang(CopyToTargetLang);
            until ExtTranslLineCopyFrom.Next() = 0;
        if GuiAllowed then
            Progress.Close();
    end;

    local procedure CopyExtTranslHeadAndLinesToNewTargLangValidateParams(ExtTranslHeadCopyFrom: Record "AMC Extension Transl Header"; CopyToTargetLang: Text)
    var
        ExtTranslHead: Record "AMC Extension Transl Header";
        EmptyCopyToTargetLangErr: Label 'Target Language cannot be empty';
        ExtTranslHeadWithNewTargetLangExistsErr: Label '%1 with %2 = %3 and %4 = %5 already exists',
                                                 Comment = '%1 is Extension Translation Header caption, %2 is Extension ID field caption, %3 is Extension ID value, %4 is Target Language field caption, %5 is Target Language value';
        TheSameNewTargetLangErr: Label 'The target language to copy to must be different from the source language';
    begin
        if (CopyToTargetLang = '') then
            Error(EmptyCopyToTargetLangErr);
        if ExtTranslHeadCopyFrom."Target Language" = CopyToTargetLang then
            Error(TheSameNewTargetLangErr);
        if ExtTranslHead.Get(ExtTranslHeadCopyFrom."Extension ID", CopyToTargetLang) then
            Error(ExtTranslHeadWithNewTargetLangExistsErr, ExtTranslHead.TableCaption(),
                  ExtTranslHead.FieldCaption("Extension ID"), ExtTranslHead."Extension ID",
                  ExtTranslHead.FieldCaption("Target Language"), ExtTranslHead."Target Language");
    end;

    /// <summary>
    /// Copies only the header to a new target language.
    /// </summary>
    /// <param name="ExtTranslHeadCopyFrom">Header record to copy from.</param>
    /// <param name="CopyToTargetLang">Target language to copy to.</param>
    internal procedure CopyExtTranslHeadToNewTargetLang(ExtTranslHeadCopyFrom: Record "AMC Extension Transl Header"; CopyToTargetLang: Text[80])
    var
        ExtTranslHeadCopyTo: Record "AMC Extension Transl Header";
    begin
        ExtTranslHeadCopyTo.Init();
        ExtTranslHeadCopyFrom.CalcFields("Imported Xlf");
        ExtTranslHeadCopyTo.TransferFields(ExtTranslHeadCopyFrom);
        ExtTranslHeadCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslHeadCopyTo.Insert(true);
    end;

    /// <summary>
    /// Applies header filters to a translation line record.
    /// </summary>
    /// <param name="ExtTranslLineCopyFrom">Line record to filter or copy from.</param>
    /// <param name="ExtTranslHeadCopyFrom">Header record to copy from.</param>
    internal procedure FilterExtTranslLines(var ExtTranslLineCopyFrom: Record "AMC Extension Transl Line"; ExtTranslHeadCopyFrom: Record "AMC Extension Transl Header")
    begin
        ExtTranslLineCopyFrom.SetRange("Extension ID", ExtTranslHeadCopyFrom."Extension ID");
        ExtTranslLineCopyFrom.SetRange("Target Language", ExtTranslHeadCopyFrom."Target Language");
    end;

    /// <summary>
    /// Copies a translation line to a new target language.
    /// </summary>
    /// <param name="ExtTranslLineCopyFrom">Line record to filter or copy from.</param>
    /// <param name="CopyToTargetLang">Target language to copy to.</param>
    internal procedure CopyExtTranslLineToNewTargetLang(ExtTranslLineCopyFrom: Record "AMC Extension Transl Line"; CopyToTargetLang: Text[80])
    var
        ExtTranslLineCopyTo: Record "AMC Extension Transl Line";
    begin
        ExtTranslLineCopyTo.Init();
        ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
        ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslLineCopyTo.Translated := false;
        ExtTranslLineCopyTo.Insert(true);
    end;

    /// <summary>
    /// Builds and downloads a translated XLF file.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    internal procedure DownloadTranslated(ExtTranslHead: Record "AMC Extension Transl Header")
    var
        Utilities: Codeunit "AMC Utilities";
        XmlUtilities: Codeunit "AMC Xml Utilities";
        PROGRESS_UPDATE_PERCENT: Decimal;
        Progress: Dialog;
        InStr: InStream;
        ProgrUpdBatch: Integer;
        TransUnitCounter: Integer;
        FirstProgrStepMsg: Label 'Downloading File: %1', Comment = '%1 is file name';
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        SecProgrStepMsg: Label 'Processing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        NS_PREFIX: Text;
        TranslatedFileName: Text;
        TuId: Text;
        XmlDoc: XmlDocument;
        NsMgr: XmlNamespaceManager;
        TransUnitNode: XmlNode;
        TransUnitNodeList: XmlNodeList;
    begin
        PROGRESS_UPDATE_PERCENT := 0.1;
        NS_PREFIX := 'x';
        TransUnitCounter := 0;

        ExtTranslHead.ValidateExtTranslLinesExist();
        if not this.ShouldDownloadIfNotAllLinesAreTranslated(ExtTranslHead) then
            exit;
        TranslatedFileName := ExtTranslHead.GetTranslatedFileName();
        if GuiAllowed then begin
            Progress.Open(ProgressMsg);
            Progress.Update(1, StrSubstNo(FirstProgrStepMsg, TranslatedFileName));
        end;

        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
        XmlUtilities.GetXmlDocumentAndNamespaceManagerFromInStream(InStr, NS_PREFIX, XmlDoc, NsMgr);
        this.SetTargetLangInXlfDoc(XmlDoc, NsMgr, NS_PREFIX, ExtTranslHead."Target Language");
        this.GetAllTransUnitIds(XmlDoc, NsMgr, NS_PREFIX, TransUnitNodeList);
        ProgrUpdBatch := Utilities.GetUpdateProgressBatch(TransUnitNodeList.Count(), PROGRESS_UPDATE_PERCENT);
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if GuiAllowed and (TransUnitCounter mod ProgrUpdBatch = 0) then
                Progress.Update(2, StrSubstNo(SecProgrStepMsg, TransUnitCounter, TransUnitNodeList.Count()));
            TuId := this.GetTransUnitIdFromTransUnitNode(TransUnitNode);
            this.ReplaceOrAddTargetInTransUnitNode(TransUnitNode, TuId, ExtTranslHead, NsMgr, NS_PREFIX);
        end;

        XmlUtilities.DownloadXmlDocument(XmlDoc, TranslatedFileName);
        if GuiAllowed then
            Progress.Close();
    end;

    /// <summary>
    /// Validates that translation lines exist for the header.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    internal procedure ValidateExtTranslLinesExist(ExtTranslHead: Record "AMC Extension Transl Header")
    var
        ExtTransLinesDontExistErr: Label 'No lines exist for: %1 with filters: %2',
                                   Comment = '%1 is table caption, %2 is filters';
    begin
        if not this.AreExtTranslLinesExist(ExtTranslHead) then
            Error(ExtTransLinesDontExistErr, ExtTranslHead.TableCaption(), ExtTranslHead.GetView());
    end;

    local procedure AreExtTranslLinesExist(ExtTranslHead: Record "AMC Extension Transl Header"): Boolean
    var
        ExtTranslLine: Record "AMC Extension Transl Line";
    begin
        ExtTranslLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTranslLine.SetRange("Target Language", ExtTranslHead."Target Language");
        exit(not ExtTranslLine.IsEmpty());
    end;

    local procedure ShouldDownloadIfNotAllLinesAreTranslated(ExtTranslHead: Record "AMC Extension Transl Header"): Boolean
    var
        DownloadIfNotAllLinesAreTranslatedQst: Label 'No all lines are marked as translated. Do you want to download the file anyway?';
    begin
        if ExtTranslHead.AreAllLinesTranslated() then
            exit(true);
        exit(Confirm(DownloadIfNotAllLinesAreTranslatedQst, true));
    end;

    /// <summary>
    /// Checks whether all lines for the header are translated.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    /// <returns>True if all lines are translated.</returns>
    internal procedure AreAllLinesTranslated(ExtTranslHead: Record "AMC Extension Transl Header"): Boolean
    var
        ExtTranslLine: Record "AMC Extension Transl Line";
    begin
        ExtTranslLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTranslLine.SetRange("Target Language", ExtTranslHead."Target Language");
        ExtTranslLine.SetRange(Translated, false);
        exit(ExtTranslLine.IsEmpty());
    end;

    /// <summary>
    /// Downloads the originally imported XLF file.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    internal procedure DownloadImported(ExtTranslHead: Record "AMC Extension Transl Header")
    var
        InStr: InStream;
    begin
#pragma warning disable AA0139
        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', ExtTranslHead."Imported FileName");
#pragma warning restore AA0139
    end;

    /// <summary>
    /// Returns the translated XLF file name for the header.
    /// </summary>
    /// <param name="ExtTranslHead">Translation header record.</param>
    /// <returns>Translated XLF file name.</returns>
    internal procedure GetTranslatedFileName(ExtTranslHead: Record "AMC Extension Transl Header"): Text
    var
        DotIndex: Integer;
    begin
        DotIndex := ExtTranslHead."Imported FileName".LastIndexOf('.');
        if DotIndex = 0 then
            exit(ExtTranslHead."Imported FileName" + ExtTranslHead."Target Language" + '.xlf');
        exit(ExtTranslHead."Imported FileName".Substring(1, DotIndex) + ExtTranslHead."Target Language" + '.xlf');
    end;

    /// <summary>
    /// Translates source text using DeepL and stores it as new target.
    /// </summary>
    /// <param name="ExtTranslLine">Translation line record.</param>
    internal procedure TranslateElemSrcsUsingDeepL(var ExtTranslLine: Record "AMC Extension Transl Line")
    var
        DeepLMgt: Codeunit "AMC DeepL Mgt";
        TranslatedText: Text;
    begin
        if ExtTranslLine.FindSet(true) then
            repeat
                TranslatedText := DeepLMgt.Translate(ExtTranslLine.GetSource(), DeepLMgt.GetDeepLLangFromLangTag(ExtTranslLine."Target Language"));
                ExtTranslLine.SetNewTarget(TranslatedText);
                ExtTranslLine.Modify(false);
            until ExtTranslLine.Next() = 0;
    end;

    local procedure SetTargetLangInXlfDoc(XmlDoc: XmlDocument; NsMgr: XmlNamespaceManager; NsPrefix: Text; TargetLang: Text)
    var
        FileAttributes: XmlAttributeCollection;
        FileNode: XmlNode;
    begin
        XmlDoc.SelectSingleNode('//' + NsPrefix + ':file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        FileAttributes.Set('target-language', TargetLang);
    end;

    local procedure ReplaceOrAddTargetInTransUnitNode(var TransUnitNode: XmlNode; TuId: Text; ExtTranslHead: Record "AMC Extension Transl Header"; NsMgr: XmlNamespaceManager; NsPrefix: Text)
    var
        ExtTranslLine: Record "AMC Extension Transl Line";
        TargetElement: XmlElement;
        TargetNode: XmlNode;
    begin
        if not this.GetTranslatedExtTranslLine(ExtTranslLine, ExtTranslHead, TuId) then
            exit;
        this.CreateTargetForTransUnit(TargetElement, NsMgr, NsPrefix, ExtTranslLine.GetNewTarget());
        if this.GetTargetFromTransUnit(TargetNode, TransUnitNode, NsMgr, NsPrefix) then
            TargetNode.ReplaceWith(TargetElement)
        else
            this.AddTargetToTransUnit(TransUnitNode, NsMgr, NsPrefix, TargetElement);
    end;

    local procedure GetTranslatedExtTranslLine(var ExtTranslLine: Record "AMC Extension Transl Line"; ExtTranslHead: Record "AMC Extension Transl Header"; TuId: Text): Boolean
    begin
        if not ExtTranslLine.Get(ExtTranslHead."Extension ID", TuId, ExtTranslHead."Target Language") then
            exit(false);
        if not ExtTranslLine.Translated then
            exit(false);
        exit(true);
    end;

    local procedure CreateTargetForTransUnit(var TargetElement: XmlElement; NsMgr: XmlNamespaceManager; NsPrefix: Text; TargetContent: Text)
    var
        NsUri: Text;
    begin
        NsMgr.LookupNamespace(NsPrefix, NsUri);
        TargetElement := XmlElement.Create('target', NsUri, TargetContent);
    end;

    local procedure AddTargetToTransUnit(var TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text; TargetElement: XmlElement)
    var
        XmlUtilities: Codeunit "AMC Xml Utilities";
        NewLineNode: XmlNode;
        SourceNode: XmlNode;
    begin
        this.GetSourceFromTransUnit(SourceNode, TransUnitNode, NsMgr, NsPrefix);
        XmlUtilities.CreateNewLineNode(NewLineNode);
        SourceNode.AddAfterSelf(NewLineNode);
        NewLineNode.AddAfterSelf(TargetElement);
    end;
}
