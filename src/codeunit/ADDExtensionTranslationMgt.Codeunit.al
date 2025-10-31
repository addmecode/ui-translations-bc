codeunit 50100 "ADD_ExtensionTranslationMgt"
{

    procedure DeleteAllExtTranslHeadLines(ExtTranslHead: Record ADD_ExtTranslHeader)
    var
        ExtTransLine: Record ADD_ExtTranslLine;
    begin
        ExtTransLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTransLine.SetRange("Target Language", ExtTranslHead."Target Language");
        ExtTransLine.DeleteAll(true);
    end;

    procedure GetExtTransLineDeveloperNotes(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Developer Note 1" +
            ExtTranslLine."Developer Note 2" +
            ExtTranslLine."Developer Note 3" +
            ExtTranslLine."Developer Note 4" +
            ExtTranslLine."Developer Note 5");
    end;

    procedure GetExtTransLineSource(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Source 1" +
            ExtTranslLine."Source 2" +
            ExtTranslLine."Source 3" +
            ExtTranslLine."Source 4" +
            ExtTranslLine."Source 5");
    end;

    procedure GetExtTransLineTarget(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Target 1" +
            ExtTranslLine."Target 2" +
            ExtTranslLine."Target 3" +
            ExtTranslLine."Target 4" +
            ExtTranslLine."Target 5");
    end;

    procedure GetExtTransLineNewTarget(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."New Target 1" +
            ExtTranslLine."New Target 2" +
            ExtTranslLine."New Target 3" +
            ExtTranslLine."New Target 4" +
            ExtTranslLine."New Target 5");
    end;

    procedure SetExtTransLineNewTarget(var ExtTranslLine: Record ADD_ExtTranslLine; NewTarget: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        ExtTranslLine."New Target 1" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(ExtTranslLine."New Target 1"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."New Target 1");
        ExtTranslLine."New Target 2" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(ExtTranslLine."New Target 2"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."New Target 2");
        ExtTranslLine."New Target 3" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(ExtTranslLine."New Target 3"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."New Target 3");
        ExtTranslLine."New Target 4" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(ExtTranslLine."New Target 4"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."New Target 4");
        ExtTranslLine."New Target 5" := CopyStr(NewTarget, TableFieldStartPos, MaxStrLen(ExtTranslLine."New Target 5"));
    end;

    procedure SetExtTransLineTarget(var ExtTranslLine: Record ADD_ExtTranslLine; Target: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        ExtTranslLine."Target 1" := CopyStr(Target, TableFieldStartPos, MaxStrLen(ExtTranslLine."Target 1"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Target 1");
        ExtTranslLine."Target 2" := CopyStr(Target, TableFieldStartPos, MaxStrLen(ExtTranslLine."Target 2"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Target 2");
        ExtTranslLine."Target 3" := CopyStr(Target, TableFieldStartPos, MaxStrLen(ExtTranslLine."Target 3"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Target 3");
        ExtTranslLine."Target 4" := CopyStr(Target, TableFieldStartPos, MaxStrLen(ExtTranslLine."Target 4"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Target 4");
        ExtTranslLine."Target 5" := CopyStr(Target, TableFieldStartPos, MaxStrLen(ExtTranslLine."Target 5"));
    end;

    procedure SetExtTransLineSource(var ExtTranslLine: Record ADD_ExtTranslLine; Source: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        ExtTranslLine."Source 1" := CopyStr(Source, TableFieldStartPos, MaxStrLen(ExtTranslLine."Source 1"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Source 1");
        ExtTranslLine."Source 2" := CopyStr(Source, TableFieldStartPos, MaxStrLen(ExtTranslLine."Source 2"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Source 2");
        ExtTranslLine."Source 3" := CopyStr(Source, TableFieldStartPos, MaxStrLen(ExtTranslLine."Source 3"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Source 3");
        ExtTranslLine."Source 4" := CopyStr(Source, TableFieldStartPos, MaxStrLen(ExtTranslLine."Source 4"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Source 4");
        ExtTranslLine."Source 5" := CopyStr(Source, TableFieldStartPos, MaxStrLen(ExtTranslLine."Source 5"));
    end;

    procedure SelectLangTag(): Text[80]
    var
        WindLang: Record "Windows Language";
    begin
        if Page.RunModal(Page::"Windows Languages", WindLang) = Action::LookupOK then
            exit(WindLang."Language Tag");
        exit('');
    end;

    procedure ImportXlf(var CreatedExtTranslHead: Record ADD_ExtTranslHeader; ExtID: Guid; ExtName: Text[250]; ExtPublisher: Text[250]; ExtVersion: Text[250]; ImportTargetLang: Boolean; TargetLang: Text)
    var
        XmlDoc: XmlDocument;
        ImportedXlfInStr: InStream;
        ImportedFileName: Text;
        TransUnitNodeList: XmlNodeList;
        NsMgr: XmlNamespaceManager;
        TuId: Text;
        TransUnitNode: XmlNode;
        SourceTxt: text;
        TargetTxt: text;
        DeveloperNote: Text;
        XliffNote: Text;
        SourceLang: Text;
        TransUnitCounter: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
        TargetLangFromXlf: Text;
        NS_PREFIX: Text;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        FirstProgrStepMsg: Label 'Importing File: %1', Comment = '%1 is file name';
        SecProgrStepMsg: Label 'Importing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        EmptyExtIdErr: Label 'Extension ID cannot be empty';
        EmptyTargetLangErr: Label 'Target Language must be specified when Import Target Language is set to false';
    begin
        PROGR_UPD_PERC := 0.1;
        NS_PREFIX := 'x';
        if IsNullGuid(ExtID) then
            Error(EmptyExtIdErr);
        if (not ImportTargetLang) and (TargetLang = '') then
            Error(EmptyTargetLangErr);
        this.DeleteAllExtTranslHeadWithExtIdIfConf(ExtID);

        UploadIntoStream('Select Xlf file', '', 'Xlf Files (*.xlf)|*.xlf', ImportedFileName, ImportedXlfInStr);
        if GuiAllowed then begin
            Progress.Open(ProgressMsg);
            Progress.Update(1, StrSubstNo(FirstProgrStepMsg, ImportedFileName));
        end;
        this.GetXmlDocAndNsMgrFromInStr(ImportedXlfInStr, NS_PREFIX, XmlDoc, NsMgr);
        this.GetTargetAndSourceLangFromXlf(XmlDoc, NsMgr, NS_PREFIX, SourceLang, TargetLangFromXlf);
        if ImportTargetLang then
            TargetLang := TargetLangFromXlf;
        this.CreateExtTranslHead(ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang, ImportedXlfInStr, ImportedFileName, SourceLang);

        this.GetAllTransUnitIds(XmlDoc, NsMgr, NS_PREFIX, TransUnitNodeList);
        TransUnitCounter := 0;
        ProgrUpdBatch := Round(TransUnitNodeList.Count() * PROGR_UPD_PERC, 1, '>');
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if GuiAllowed and (TransUnitCounter mod ProgrUpdBatch = 0) then
                Progress.Update(2, StrSubstNo(SecProgrStepMsg, TransUnitCounter, TransUnitNodeList.Count()));
            this.ParseTransUnitIdNode(TransUnitNode, NsMgr, NS_PREFIX, TuId, SourceTxt, TargetTxt, DeveloperNote, XliffNote);
            this.CreateExtTranslLine(ExtID, TargetLang, TuId, SourceTxt, TargetTxt, DeveloperNote, XliffNote);
        end;

        if GuiAllowed then
            Progress.Close();
    end;

    local procedure DeleteAllExtTranslHeadWithExtIdIfConf(var ExtID: Guid)
    var
        ElTranslHead: Record ADD_ExtTranslHeader;
        DelExtTranslQst: Label 'Extension Translations already exist for %1 Extension ID. Do you want to delete them and continue?', Comment = '%1 is Extension ID value';
    begin
        ElTranslHead.SetRange("Extension ID", ExtID);
        if ElTranslHead.FindSet() then begin
            if not Confirm(DelExtTranslQst, false, ExtID) then
                exit;
            ElTranslHead.DeleteAll(true);
        end;
    end;

    local procedure GetXmlDocAndNsMgrFromInStr(ImportedXlfInStr: InStream; NsPrefix: Text; var XmlDoc: XmlDocument; var NsMgr: XmlNamespaceManager)
    var
        Root: XmlElement;
        NsUri: Text;
    begin
        XmlDocument.ReadFrom(ImportedXlfInStr, XmlDoc);
        XmlDoc.GetRoot(Root);
        NsUri := Root.NamespaceUri();
        NsMgr.AddNamespace(NsPrefix, NsUri);
    end;

    local procedure GetTargetAndSourceLangFromXlf(XmlDoc: XmlDocument; NsMgr: XmlNamespaceManager; NsPrefix: Text; var SourceLang: Text; var TargetLang: Text)
    var
        FileAttributes: XmlAttributeCollection;
        FileNode: XmlNode;
    begin
        XmlDoc.SelectSingleNode('//' + NsPrefix + ':file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        SourceLang := this.GetAttrValue(FileAttributes, 'source-language');
        TargetLang := this.GetAttrValue(FileAttributes, 'target-language');
    end;

    local procedure GetAttrValue(FileAttributes: XmlAttributeCollection; AttrName: Text): Text
    var
        Attr: XmlAttribute;
    begin
        FileAttributes.Get(AttrName, Attr);
        exit(Attr.Value());
    end;

    local procedure CreateExtTranslHead(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text;
                                        TargetLang: Text; ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
        NewExtTranslHead: Record ADD_ExtTranslHeader;
        OutStr: OutStream;
    begin
#pragma warning disable AA0139
        NewExtTranslHead.init();
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

    local procedure ParseTransUnitIdNode(TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text; var TuId: Text; var SourceTxt: text; var TargetTxt: text; var DeveloperNote: Text; var XliffNote: Text)
    var
        NoteNodeList: XmlNodeList;
        NoteNode: XmlNode;
        TransUnitAttributes: XmlAttributeCollection;
        NoteAttributes: XmlAttributeCollection;
        TransUnitAttr: XmlAttribute;
        NoteAttr: XmlAttribute;
        SourceNode: XmlNode;
        TargetNode: XmlNode;
    begin
        TransUnitAttributes := TransUnitNode.AsXmlElement().Attributes();
        TransUnitAttributes.Get('id', TransUnitAttr);
        TuId := TransUnitAttr.Value();

        TransUnitNode.SelectSingleNode(NsPrefix + ':source', NsMgr, SourceNode);
        SourceTxt := SourceNode.AsXmlElement().InnerText();

        TargetTxt := '';
        if TransUnitNode.SelectSingleNode(NsPrefix + ':target', NsMgr, TargetNode) then
            TargetTxt := TargetNode.AsXmlElement().InnerText();

        TransUnitNode.SelectNodes(NsPrefix + ':note', NsMgr, NoteNodeList);
        foreach NoteNode in NoteNodeList do begin
            NoteAttributes := NoteNode.AsXmlElement().Attributes();
            NoteAttributes.Get('from', NoteAttr);
            case NoteAttr.Value() of
                'Developer':
                    DeveloperNote := NoteNode.AsXmlElement().InnerText();
                'Xliff Generator':
                    XliffNote := NoteNode.AsXmlElement().InnerText();
            end;
        end;
    end;

    local procedure CreateExtTranslLine(ExtId: Text; TargetLang: Text; TuId: Text; SourceTxt: text;
                                        TargetTxt: text; DeveloperNote: Text; XliffNote: Text)
    var
        NewElTransl: Record ADD_ExtTranslLine;
    begin
#pragma warning disable AA0139
        NewElTransl.Init();
        NewElTransl."Extension ID" := ExtId;
        NewElTransl."Target Language" := TargetLang;
        NewElTransl."Trans Unit ID" := TuId;
        NewElTransl.Translated := false;
        this.ParseXliffNote(TuId, XliffNote, NewElTransl."Object Type", NewElTransl."Object Name",
                       NewElTransl."Element Type", NewElTransl."Element Name");
        NewElTransl.SetSource(SourceTxt);
        NewElTransl.SetTarget(TargetTxt);
        NewElTransl.SetNewTarget(TargetTxt);
        NewElTransl.SetDevNote(DeveloperNote);
        NewElTransl.SetXliffNote(XliffNote);
        NewElTransl.Insert(false);
#pragma warning restore AA0139
    end;

    local procedure ParseXliffNote(TransUnitId: Text; XliffNote: Text; var ObjType: Text[30]; var ObjName: Text[250]; var ElementType: Text[250]; var ElementName: Text[250])
    var
        FoundUnhandledTransUnitPartErr: Label 'Found %1 parts in Trans unit id: %2', Comment = '%1 is " - " parts number, %2 is trans unit id value';
        HyphenParts: List of [Text];
        TuHyphenParts: List of [Text];
        ElemTypeStartPart: Integer;
        ElemNameStartPart: Integer;
        ElemTypeFirstWord: Text;
        ElemNameFirstWord: Text;
        SPLIT_BY: Text;
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
        TuHyphenParts := TransUnitId.Split(SPLIT_BY);
        ObjType := this.GetTextPartBeforeSpace(TuHyphenParts.Get(1));
        case TuHyphenParts.Count() of
            4:
                begin
                    ElemNameFirstWord := this.GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := this.GetTextPartBeforeSpace(TuHyphenParts.Get(4));
                end;
            3:
                begin
                    ElemNameFirstWord := this.GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := this.GetTextPartBeforeSpace(TuHyphenParts.Get(3));
                end;
            2:
                begin
                    ElemNameFirstWord := '';
                    ElemTypeFirstWord := this.GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                end;
            else
                Error(FoundUnhandledTransUnitPartErr, TuHyphenParts.Count(), TransUnitId);
        end;
        HyphenParts := XliffNote.Split(' - ');
        ElemTypeStartPart := XliffNote.LastIndexOf(' - ' + ElemTypeFirstWord);
        ElementType := XliffNote.Substring(ElemTypeStartPart + StrLen(SPLIT_BY));
        XliffNote := XliffNote.Substring(1, ElemTypeStartPart - 1);
        if ElemNameFirstWord <> '' then begin
            ElemNameStartPart := XliffNote.LastIndexOf(' - ' + ElemNameFirstWord);
            ElementName := XliffNote.Substring(ElemNameStartPart + StrLen(SPLIT_BY));
            XliffNote := XliffNote.Substring(1, ElemNameStartPart - 1);
        end;
        ObjName := XliffNote.Substring(StrLen(ObjType) + 1);
#pragma warning restore AA0139
    end;

    procedure SetExtTransLineDevNote(var ExtTranslLine: Record ADD_ExtTranslLine; DevNote: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        ExtTranslLine."Developer Note 1" := CopyStr(DevNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Developer Note 1"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Developer Note 1");
        ExtTranslLine."Developer Note 2" := CopyStr(DevNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Developer Note 2"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Developer Note 2");
        ExtTranslLine."Developer Note 3" := CopyStr(DevNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Developer Note 3"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Developer Note 3");
        ExtTranslLine."Developer Note 4" := CopyStr(DevNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Developer Note 4"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Developer Note 4");
        ExtTranslLine."Developer Note 5" := CopyStr(DevNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Developer Note 5"));
    end;

    procedure SetExtTransLineXliffNote(var ExtTranslLine: Record ADD_ExtTranslLine; XliffNote: Text)
    var
        TableFieldStartPos: Integer;
    begin
        TableFieldStartPos := 1;
        ExtTranslLine."Xliff Note 1" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Xliff Note 1"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Xliff Note 1");
        ExtTranslLine."Xliff Note 2" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Xliff Note 2"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Xliff Note 2");
        ExtTranslLine."Xliff Note 3" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Xliff Note 3"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Xliff Note 3");
        ExtTranslLine."Xliff Note 4" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Xliff Note 4"));
        TableFieldStartPos += MaxStrLen(ExtTranslLine."Xliff Note 4");
        ExtTranslLine."Xliff Note 5" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(ExtTranslLine."Xliff Note 5"));
    end;

    local procedure GetTextPartBeforeSpace(InputText: Text): Text
    begin
        exit(InputText.Substring(1, InputText.IndexOf(' ') - 1));
    end;

    // TODO: ->

    procedure RunObject(ElemTransl: Record ADD_ExtTranslLine)
    var
        AllObj: Record AllObjWithCaption;
    begin
        case UpperCase(ElemTransl."Object Type") of
            'TABLE':
                AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
            'PAGE':
                AllObj.SetRange("Object Type", AllObj."Object Type"::Page);
            else
                Error('Object Type %1 is not supported', ElemTransl."Object Type");
        end;
        AllObj.SetRange("Object Name", ElemTransl."Object Name");
        if AllObj.FindFirst() then begin
            this.RunObject(AllObj."Object Type", AllObj."Object ID");
            exit;
        end;

        AllObj.SetRange("Object Name", '');
        AllObj.SetRange("Object Caption", ElemTransl."Object Name");
        if AllObj.FindFirst() then begin
            this.RunObject(AllObj."Object Type", AllObj."Object ID");
            exit;
        end;
    end;

    internal procedure CopyExtTranslToNewTargLang(CopyFromExtID: Guid; CopyFromTargetLang: Text[80]; CopyToTargetLang: Text[80])
    var
        ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader;
        ExtTranslHeadCopyTo: Record ADD_ExtTranslHeader;
        ExtTranslLineCopyFrom: Record ADD_ExtTranslLine;
        ExtTranslLineCopyTo: Record ADD_ExtTranslLine;
        Progress: Dialog;
        ProgressMsg: Label '#1', Comment = '#1 is first step label';
        FirstProgrStepMsg: Label 'Copying Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        LinesCounter: Integer;
        LinesNumber: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
    begin
        if (IsNullGuid(CopyFromExtID)) or (CopyFromTargetLang = '') or (CopyToTargetLang = '') then
            Error('Extension ID, Target Language and Source Language cannot be empty');
        if CopyFromTargetLang = CopyToTargetLang then
            Error('The target language to copy to must be different from the source language');

        PROGR_UPD_PERC := 0.1;
        if GuiAllowed then
            Progress.Open(ProgressMsg);
        ExtTranslHeadCopyFrom.Get(CopyFromExtID, CopyFromTargetLang);
        ExtTranslHeadCopyTo.Init();
        ExtTranslHeadCopyFrom.CalcFields("Imported Xlf");
        ExtTranslHeadCopyTo.TransferFields(ExtTranslHeadCopyFrom);
        ExtTranslHeadCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslHeadCopyTo.Insert(True);

        ExtTranslLineCopyFrom.SetRange("Extension ID", ExtTranslHeadCopyFrom."Extension ID");
        ExtTranslLineCopyFrom.SetRange("Target Language", ExtTranslHeadCopyFrom."Target Language");
        LinesCounter := 0;
        LinesNumber := ExtTranslLineCopyFrom.Count();
        ProgrUpdBatch := Round(LinesNumber * PROGR_UPD_PERC, 1, '>');
        if ExtTranslLineCopyFrom.FindSet(false) then
            repeat
                LinesCounter += 1;
                if GuiAllowed and (LinesCounter mod ProgrUpdBatch = 0) then
                    Progress.Update(1, StrSubstNo(FirstProgrStepMsg, LinesCounter, LinesNumber));

                ExtTranslLineCopyTo.Init();
                ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
                ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
                ExtTranslLineCopyTo.Translated := false;
                ExtTranslLineCopyTo.Insert(True);
            until ExtTranslLineCopyFrom.Next() = 0;
        if GuiAllowed then
            Progress.Close();
    end;

    internal procedure DownloadImported(ExtensionID: Guid; TargetLanguage: Text[80])
    var
        ExtTranslHead: Record ADD_ExtTranslHeader;
        InStr: InStream;
    begin
        ExtTranslHead.Get(ExtensionID, TargetLanguage);
        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
#pragma warning disable AA0139
        DownloadFromStream(InStr, '', '', '', ExtTranslHead."Imported FileName");
#pragma warning restore AA0139
    end;

    internal procedure DownloadTranslated(ExtensionID: Guid; TargetLanguage: Text[80])
    var
        ExtTranslHead: Record ADD_ExtTranslHeader;
        ExtTranslLine: Record ADD_ExtTranslLine;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        XmlDoc: XmlDocument;
        Root: XmlElement;
        NsUri: Text;
        NsMgr: XmlNamespaceManager;
        FileNode: XmlNode;
        FileAttributes: XmlAttributeCollection;
        TransUnitNodeList: XmlNodeList;
        TransUnitNode: XmlNode;
        TransUnitAttributes: XmlAttributeCollection;
        TransUnitAttr: XmlAttribute;
        TuId: Text;
        SourceNode: XmlNode;
        TargetElement: XmlElement;
        TranslatedFileName: Text;
        IndentBeforeTarget: XmlNode;
        CR: Char;
        LF: Char;
        NewLineText: Text;
        TargetNode: XmlNode;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        FirstProgrStepMsg: Label 'Downloading File: %1', Comment = '%1 is file name';
        SecProgrStepMsg: Label 'Processing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        TransUnitCounter: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
    begin
        PROGR_UPD_PERC := 0.1;
        CR := 13; // \r
        LF := 10; // \n
        NewLineText := Format(CR) + Format(LF) + '          ';

        ExtTranslHead.Get(ExtensionID, TargetLanguage);
        ExtTranslLine.SetRange("Extension ID", ExtensionID);
        ExtTranslLine.SetRange("Target Language", TargetLanguage);
        if ExtTranslLine.IsEmpty() then
            Error('No lines exist');
        ExtTranslLine.SetRange(Translated, false);
        if not ExtTranslLine.IsEmpty() then
            if not Confirm('No all lines are marked as translated. Do you want to download the file anyway?', true) then
                exit;
        TranslatedFileName := ExtTranslHead."Imported FileName".Substring(1, ExtTranslHead."Imported FileName".IndexOf('.')) + ExtTranslHead."Target Language" + '.xlf';
        if GuiAllowed then begin
            Progress.Open(ProgressMsg); //TODO: add guiallowed
            Progress.Update(1, StrSubstNo(FirstProgrStepMsg, TranslatedFileName));
        end;

        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
        XmlDocument.ReadFrom(InStr, XmlDoc);
        XmlDoc.GetRoot(Root);
        NsUri := Root.NamespaceUri();
        NsMgr.AddNamespace('x', NsUri);

        XmlDoc.SelectSingleNode('//x:file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        FileAttributes.Set('target-language', ExtTranslHead."Target Language");

        XmlDoc.SelectNodes('//x:file/x:body/x:group/x:trans-unit', NsMgr, TransUnitNodeList);
        TransUnitCounter := 0;
        ProgrUpdBatch := Round(TransUnitNodeList.Count() * PROGR_UPD_PERC, 1, '>');
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if GuiAllowed and (TransUnitCounter mod ProgrUpdBatch = 0) then
                Progress.Update(2, StrSubstNo(SecProgrStepMsg, TransUnitCounter, TransUnitNodeList.Count()));

            TransUnitAttributes := TransUnitNode.AsXmlElement().Attributes();
            TransUnitAttributes.Get('id', TransUnitAttr);
            TuId := TransUnitAttr.Value();
            if ExtTranslLine.Get(ExtTranslHead."Extension ID", TuId, ExtTranslHead."Target Language") then
                if ExtTranslLine.Translated then begin
                    TargetElement := XmlElement.Create('target', NsUri, ExtTranslLine.GetNewTarget());
                    if TransUnitNode.SelectSingleNode('x:target', NsMgr, TargetNode) then
                        TargetNode.ReplaceWith(TargetElement)
                    else begin
                        TransUnitNode.SelectSingleNode('x:source', NsMgr, SourceNode);
                        IndentBeforeTarget := XmlText.Create(NewLineText).AsXmlNode();
                        SourceNode.AddAfterSelf(IndentBeforeTarget);
                        IndentBeforeTarget.AddAfterSelf(TargetElement);
                    end;
                end;
        end;

        TempBlob.CreateOutStream(OutStr);
        XmlDoc.WriteTo(OutStr);
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', TranslatedFileName);
        if GuiAllowed then
            Progress.Close();
    end;

    local procedure RunObject(ObjType: Integer; ObjectId: Integer)
    var
        AllObj: Record AllObjWithCaption;
    begin
        case ObjType of
            AllObj."Object Type"::Page:
                PAGE.Run(ObjectId);
            AllObj."Object Type"::Table:
                Hyperlink(GetUrl(ClientType::Current, CompanyName, ObjectType::Table, ObjectId));
        end;
    end;
}
