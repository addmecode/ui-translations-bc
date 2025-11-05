codeunit 50100 "ADD_ExtensionTranslationMgt"
{

    internal procedure DeleteAllExtTranslHeadLines(ExtTranslHead: Record ADD_ExtTranslHeader)
    var
        ExtTransLine: Record ADD_ExtTranslLine;
    begin
        ExtTransLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTransLine.SetRange("Target Language", ExtTranslHead."Target Language");
        ExtTransLine.DeleteAll(true);
    end;

    internal procedure GetExtTransLineDeveloperNotes(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Developer Note 1" +
            ExtTranslLine."Developer Note 2" +
            ExtTranslLine."Developer Note 3" +
            ExtTranslLine."Developer Note 4" +
            ExtTranslLine."Developer Note 5");
    end;

    internal procedure GetExtTransLineSource(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Source 1" +
            ExtTranslLine."Source 2" +
            ExtTranslLine."Source 3" +
            ExtTranslLine."Source 4" +
            ExtTranslLine."Source 5");
    end;

    internal procedure GetExtTransLineTarget(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Target 1" +
            ExtTranslLine."Target 2" +
            ExtTranslLine."Target 3" +
            ExtTranslLine."Target 4" +
            ExtTranslLine."Target 5");
    end;

    internal procedure GetExtTransLineNewTarget(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."New Target 1" +
            ExtTranslLine."New Target 2" +
            ExtTranslLine."New Target 3" +
            ExtTranslLine."New Target 4" +
            ExtTranslLine."New Target 5");
    end;

    internal procedure GetExtTransLineXliffNote(ExtTranslLine: Record ADD_ExtTranslLine): Text
    begin
        exit(ExtTranslLine."Xliff Note 1" +
            ExtTranslLine."Xliff Note 2" +
            ExtTranslLine."Xliff Note 3" +
            ExtTranslLine."Xliff Note 4" +
            ExtTranslLine."Xliff Note 5");
    end;

    internal procedure SetExtTransLineNewTarget(var ExtTranslLine: Record ADD_ExtTranslLine; NewTarget: Text)
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

    internal procedure SetExtTransLineTarget(var ExtTranslLine: Record ADD_ExtTranslLine; Target: Text)
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

    internal procedure SetExtTransLineSource(var ExtTranslLine: Record ADD_ExtTranslLine; Source: Text)
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

    internal procedure SetExtTransLineDevNote(var ExtTranslLine: Record ADD_ExtTranslLine; DevNote: Text)
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

    internal procedure SetExtTransLineXliffNote(var ExtTranslLine: Record ADD_ExtTranslLine; XliffNote: Text)
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

    internal procedure RunObject(ElemTransl: Record ADD_ExtTranslLine)
    var
        AllObj: Record AllObjWithCaption;
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
        AllObj.FindFirst();
        this.RunObject(AllObj."Object Type", AllObj."Object ID");
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

    internal procedure SelectLangTag(): Text[80]
    var
        WindLang: Record "Windows Language";
    begin
        if Page.RunModal(Page::"Windows Languages", WindLang) = Action::LookupOK then
            exit(WindLang."Language Tag");
        exit('');
    end;

    internal procedure ImportXlf(var CreatedExtTranslHead: Record ADD_ExtTranslHeader; ExtID: Guid; ExtName: Text[250]; ExtPublisher: Text[250]; ExtVersion: Text[250]; ImportTargetLang: Boolean; TargetLang: Text)
    var
        CreatedExtTranslLine: Record ADD_ExtTranslLine;
        XmlDoc: XmlDocument;
        NsMgr: XmlNamespaceManager;
        TransUnitNodeList: XmlNodeList;
        TransUnitNode: XmlNode;
        ImportedXlfInStr: InStream;
        ImportedFileName: Text;
        TuId: Text;
        SourceTxt: text;
        TargetTxt: text;
        DeveloperNote: Text;
        XliffNote: Text;
        SourceLang: Text;
        TargetLangFromXlf: Text;
        TransUnitCounter: Integer;
        ProgrUpdBatch: Integer;
        PROGR_UPD_PERC: Decimal;
        NS_PREFIX: Text;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        FirstProgrStepMsg: Label 'Importing File: %1', Comment = '%1 is file name';
        SecProgrStepMsg: Label 'Importing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
    begin
        PROGR_UPD_PERC := 0.1;
        NS_PREFIX := 'x';
        TransUnitCounter := 0;
        this.ImportXlfValidateParams(ExtID, ImportTargetLang, TargetLang);
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
        CreatedExtTranslHead.CreateExtTranslHead(ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang, ImportedXlfInStr, ImportedFileName, SourceLang);

        this.GetAllTransUnitIds(XmlDoc, NsMgr, NS_PREFIX, TransUnitNodeList);
        ProgrUpdBatch := this.GetUpdProgrBatch(TransUnitNodeList.Count(), PROGR_UPD_PERC);
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
        //todo utilities
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
        SourceLang := this.GetAttrValueFromCollection(FileAttributes, 'source-language');
        TargetLang := this.GetAttrValueFromCollection(FileAttributes, 'target-language');
    end;

    local procedure GetAttrValueFromCollection(AttrColl: XmlAttributeCollection; AttrName: Text): Text
    var
        Attr: XmlAttribute;
    begin
        //todo utilities
        AttrColl.Get(AttrName, Attr);
        exit(Attr.Value());
    end;

    internal procedure CreateExtTranslHead(var NewExtTranslHead: Record ADD_ExtTranslHeader; ExtID: Guid; ExtName: Text; ExtPublisher: Text;
                                           ExtVersion: Text; TargetLang: Text; ImportedXlfInStr: InStream; ImportedFileName: Text; SourceLang: Text)
    var
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

    local procedure GetUpdProgrBatch(TotalRowsNumber: Integer; ProgrUpdPerc: Decimal): Integer
    begin
        //todo utilities
        exit(Round(TotalRowsNumber * ProgrUpdPerc, 1, '>'));
    end;

    local procedure ParseTransUnitIdNode(TransUnitNode: XmlNode; NsMgr: XmlNamespaceManager; NsPrefix: Text; var TuId: Text; var SourceTxt: text; var TargetTxt: text; var DeveloperNote: Text; var XliffNote: Text)
    var
        NoteNodeList: XmlNodeList;
        NoteNode: XmlNode;
        SourceNode: XmlNode;
        TargetNode: XmlNode;
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
        TransUnitAttributes: XmlAttributeCollection;
        TransUnitAttr: XmlAttribute;
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
        NoteAttr: XmlAttribute;
    begin
        this.GetElementAttribute(NoteAttr, 'from', NoteNode);
        exit(NoteAttr.Value() = 'Developer');
    end;

    local procedure GetElementAttribute(var NoteAttr: XmlAttribute; AttributeName: Text; NoteNode: XmlNode)
    var
        NoteAttributes: XmlAttributeCollection;
    begin
        //TODO: utilities
        NoteAttributes := NoteNode.AsXmlElement().Attributes();
        NoteAttributes.Get(AttributeName, NoteAttr);
    end;

    local procedure IsXliffGeneratorNoteNode(NoteNode: XmlNode): Boolean
    var
        NoteAttr: XmlAttribute;
    begin
        this.GetElementAttribute(NoteAttr, 'from', NoteNode);
        exit(NoteAttr.Value() = 'Xliff Generator');
    end;

    internal procedure CreateExtTranslLine(var NewElTransl: Record ADD_ExtTranslLine; ExtId: Text; TargetLang: Text; TuId: Text;
                                           SourceTxt: text; TargetTxt: text; DeveloperNote: Text; XliffNote: Text)
    begin
#pragma warning disable AA0139
        NewElTransl.Init();
        NewElTransl."Extension ID" := ExtId;
        NewElTransl."Target Language" := TargetLang;
        NewElTransl."Trans Unit ID" := TuId;
        NewElTransl.Translated := false;
        NewElTransl.SetXliffNote(XliffNote);
        NewElTransl.SetSource(SourceTxt);
        NewElTransl.SetTarget(TargetTxt);
        NewElTransl.SetNewTarget(TargetTxt);
        NewElTransl.SetDevNote(DeveloperNote);
        NewElTransl.ParseXliffNote();
        NewElTransl.Insert(false);
#pragma warning restore AA0139
    end;

    internal procedure ParseXliffNote(var ExtTranslLine: Record ADD_ExtTranslLine)
    var
        FoundUnhandledTransUnitPartErr: Label 'Found %1 parts in Trans unit id: %2', Comment = '%1 is " - " parts number, %2 is trans unit id value';
        HyphenParts: List of [Text];
        TuHyphenParts: List of [Text];
        ElemTypeStartPart: Integer;
        ElemNameStartPart: Integer;
        ElemTypeFirstWord: Text;
        ElemNameFirstWord: Text;
        XliffNote: Text;
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
        HyphenParts := XliffNote.Split(' - ');
        ElemTypeStartPart := XliffNote.LastIndexOf(' - ' + ElemTypeFirstWord);
        ExtTranslLine."Element Type" := XliffNote.Substring(ElemTypeStartPart + StrLen(SPLIT_BY));
        XliffNote := XliffNote.Substring(1, ElemTypeStartPart - 1);
        if ElemNameFirstWord <> '' then begin
            ElemNameStartPart := XliffNote.LastIndexOf(' - ' + ElemNameFirstWord);
            ExtTranslLine."Element Name" := XliffNote.Substring(ElemNameStartPart + StrLen(SPLIT_BY));
            XliffNote := XliffNote.Substring(1, ElemNameStartPart - 1);
        end;
        ExtTranslLine."Object Name" := XliffNote.Substring(StrLen(ExtTranslLine."Object Type") + 1);
#pragma warning restore AA0139
    end;

    local procedure GetTextPartBeforeFirstSpace(InputText: Text): Text
    begin
        exit(InputText.Substring(1, InputText.IndexOf(' ') - 1));
    end;

    internal procedure CopyExtTranslHeadAndLinesToNewTargetLang(ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader; CopyToTargetLang: Text[80])
    var
        ExtTranslLineCopyFrom: Record ADD_ExtTranslLine;
        Progress: Dialog;
        LinesCounter: Integer;
        LinesNumber: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
        ProgressMsg: Label '#1', Comment = '#1 is first step label';
        FirstProgrStepMsg: Label 'Copying Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
    begin
        PROGR_UPD_PERC := 0.1;
        LinesCounter := 0;
        if GuiAllowed then
            Progress.Open(ProgressMsg);
        this.CopyExtTranslHeadAndLinesToNewTargLangValidateParams(ExtTranslHeadCopyFrom, CopyToTargetLang);
        ExtTranslHeadCopyFrom.CopyExtTranslHeadToNewTargetLang(CopyToTargetLang);
        ExtTranslHeadCopyFrom.FilterExtTranslLines(ExtTranslLineCopyFrom);
        LinesNumber := ExtTranslLineCopyFrom.Count();
        ProgrUpdBatch := this.GetUpdProgrBatch(LinesNumber, PROGR_UPD_PERC);
        if ExtTranslLineCopyFrom.FindSet() then
            repeat
                LinesCounter += 1;
                if GuiAllowed and (LinesCounter mod ProgrUpdBatch = 0) then
                    Progress.Update(1, StrSubstNo(FirstProgrStepMsg, LinesCounter, LinesNumber));
                ExtTranslLineCopyFrom.CopyToNewTargetLang(CopyToTargetLang);
            until ExtTranslLineCopyFrom.Next() = 0;
        if GuiAllowed then Progress.Close();
    end;

    local procedure CopyExtTranslHeadAndLinesToNewTargLangValidateParams(ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader; CopyToTargetLang: Text)
    var
        ExtTranslHead: Record ADD_ExtTranslHeader;
        EmptyCopyToTargetLangErr: Label 'Target Language cannot be empty';
        TheSameNewTargetLangErr: Label 'The target language to copy to must be different from the source language';
        ExtTranslHeadWithNewTargetLangExistsErr: Label '%1 with %2 = %3 and %4 = %5 already exists',
                                                 Comment = '%1 is Extension Translation Header caption, %2 is Extension ID field caption, %3 is Extension ID value, %4 is Target Language field caption, %5 is Target Language value';
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

    internal procedure CopyExtTranslHeadToNewTargetLang(ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader; CopyToTargetLang: Text[80])
    var
        ExtTranslHeadCopyTo: Record ADD_ExtTranslHeader;
    begin
        ExtTranslHeadCopyTo.Init();
        ExtTranslHeadCopyFrom.CalcFields("Imported Xlf");
        ExtTranslHeadCopyTo.TransferFields(ExtTranslHeadCopyFrom);
        ExtTranslHeadCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslHeadCopyTo.Insert(true);
    end;

    internal procedure FilterExtTranslLines(var ExtTranslLineCopyFrom: Record ADD_ExtTranslLine; ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader)
    begin
        ExtTranslLineCopyFrom.SetRange("Extension ID", ExtTranslHeadCopyFrom."Extension ID");
        ExtTranslLineCopyFrom.SetRange("Target Language", ExtTranslLineCopyFrom."Target Language");
    end;

    internal procedure CopyExtTranslLineToNewTargetLang(ExtTranslLineCopyFrom: Record ADD_ExtTranslLine; CopyToTargetLang: Text[80])
    var
        ExtTranslLineCopyTo: Record ADD_ExtTranslLine;
    begin
        ExtTranslLineCopyTo.Init();
        ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
        ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslLineCopyTo.Translated := false;
        ExtTranslLineCopyTo.Insert(true);
    end;

    internal procedure DownloadTranslated(ExtTranslHead: Record ADD_ExtTranslHeader)
    var
        InStr: InStream;
        XmlDoc: XmlDocument;
        NsMgr: XmlNamespaceManager;
        TransUnitNodeList: XmlNodeList;
        TransUnitNode: XmlNode;
        TuId: Text;
        TranslatedFileName: Text;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2', Comment = '#1 is first step label, #2 is second step label';
        FirstProgrStepMsg: Label 'Downloading File: %1', Comment = '%1 is file name';
        SecProgrStepMsg: Label 'Processing Lines: %1 of %2', Comment = '%1 is current line number, %2 is total lines number';
        TransUnitCounter: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
        NS_PREFIX: Text;
    begin
        PROGR_UPD_PERC := 0.1;
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
        ExtTranslHead.GetImportedXlfInStream(InStr);
        this.GetXmlDocAndNsMgrFromInStr(InStr, NS_PREFIX, XmlDoc, NsMgr);
        this.SetTargetLangInXlfDoc(XmlDoc, NsMgr, NS_PREFIX, ExtTranslHead."Target Language");
        this.GetAllTransUnitIds(XmlDoc, NsMgr, NS_PREFIX, TransUnitNodeList);
        ProgrUpdBatch := this.GetUpdProgrBatch(TransUnitNodeList.Count(), PROGR_UPD_PERC);
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if GuiAllowed and (TransUnitCounter mod ProgrUpdBatch = 0) then
                Progress.Update(2, StrSubstNo(SecProgrStepMsg, TransUnitCounter, TransUnitNodeList.Count()));
            TuId := this.GetTransUnitIdFromTransUnitNode(TransUnitNode);
            this.ReplaceOrAddTargetInTransUnitNode(TransUnitNode, TuId, ExtTranslHead, NsMgr, NS_PREFIX);
        end;

        this.DownloadXmlDoc(XmlDoc, TranslatedFileName);
        if GuiAllowed then
            Progress.Close();
    end;

    internal procedure ValidateExtTranslLinesExist(ExtTranslHead: Record ADD_ExtTranslHeader)
    var
        ExtTransLinesDontExistErr: Label 'No lines exist for: %1 with filters: %2',
                                   Comment = '%1 is table caption, %2 is filters';
    begin
        if not this.AreExtTranslLinesExist(ExtTranslHead) then
            Error(ExtTransLinesDontExistErr, ExtTranslHead.TableCaption(), ExtTranslHead.GetView());
    end;

    local procedure AreExtTranslLinesExist(ExtTranslHead: Record ADD_ExtTranslHeader): Boolean
    var
        ExtTranslLine: Record ADD_ExtTranslLine;
    begin
        ExtTranslLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTranslLine.SetRange("Target Language", ExtTranslHead."Target Language");
        exit(not ExtTranslLine.IsEmpty());
    end;

    local procedure ShouldDownloadIfNotAllLinesAreTranslated(ExtTranslHead: Record ADD_ExtTranslHeader): Boolean
    var
        DownloadIfNotAllLinesAreTranslatedQst: Label 'No all lines are marked as translated. Do you want to download the file anyway?';
    begin
        if ExtTranslHead.AreAllLinesTranslated() then
            exit(true);
        exit(Confirm(DownloadIfNotAllLinesAreTranslatedQst, true));
    end;

    internal procedure AreAllLinesTranslated(ExtTranslHead: Record ADD_ExtTranslHeader): Boolean
    var
        ExtTranslLine: Record ADD_ExtTranslLine;
    begin
        ExtTranslLine.SetRange("Extension ID", ExtTranslHead."Extension ID");
        ExtTranslLine.SetRange("Target Language", ExtTranslHead."Target Language");
        ExtTranslLine.SetRange(Translated, false);
        exit(ExtTranslLine.IsEmpty());
    end;


    internal procedure DownloadImported(ExtTranslHead: Record ADD_ExtTranslHeader)
    var
        InStr: InStream;
    begin
#pragma warning disable AA0139
        ExtTranslHead.GetImportedXlfInStream(InStr);
        DownloadFromStream(InStr, '', '', '', ExtTranslHead."Imported FileName");
#pragma warning restore AA0139
    end;

    internal procedure GetImportedXlfInStream(var InStr: InStream; ExtTranslHead: Record ADD_ExtTranslHeader)
    begin
        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
    end;

    internal procedure GetTranslatedFileName(ExtTranslHead: Record ADD_ExtTranslHeader): Text
    begin
        exit(ExtTranslHead."Imported FileName".Substring(1, ExtTranslHead."Imported FileName".IndexOf('.')) + ExtTranslHead."Target Language" + '.xlf');
    end;

    local procedure SetTargetLangInXlfDoc(XmlDoc: XmlDocument; NsMgr: XmlNamespaceManager; NsPrefix: Text; TargetLang: Text)
    var
        FileNode: XmlNode;
        FileAttributes: XmlAttributeCollection;
    begin
        XmlDoc.SelectSingleNode('//' + NsPrefix + ':file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        FileAttributes.Set('target-language', TargetLang);
    end;

    local procedure ReplaceOrAddTargetInTransUnitNode(var TransUnitNode: XmlNode; TuId: Text; ExtTranslHead: Record ADD_ExtTranslHeader; NsMgr: XmlNamespaceManager; NsPrefix: Text)
    var
        ExtTranslLine: Record ADD_ExtTranslLine;
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

    local procedure GetTranslatedExtTranslLine(var ExtTranslLine: Record ADD_ExtTranslLine; ExtTranslHead: Record ADD_ExtTranslHeader; TuId: Text): Boolean
    begin
        if not ExtTranslLine.Get(ExtTranslHead."Extension ID", TuId, ExtTranslHead."Target Language") then
            exit(false);
        if not ExtTranslLine.Translated then
            exit(false);
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
        SourceNode: XmlNode;
        NewLineNode: XmlNode;
    begin
        this.GetSourceFromTransUnit(SourceNode, TransUnitNode, NsMgr, NsPrefix);
        this.CreateNewLineNode(NewLineNode);
        SourceNode.AddAfterSelf(NewLineNode);
        NewLineNode.AddAfterSelf(TargetElement);
    end;

    local procedure CreateNewLineNode(var NewLineNode: XmlNode)
    var
        TypeHelper: Codeunit "Type Helper";
        NewLineText: text;
    begin
        //TODO: utilities
        NewLineText := TypeHelper.CRLFSeparator() + '          ';
        NewLineNode := XmlText.Create(NewLineText).AsXmlNode();
    end;

    local procedure DownloadXmlDoc(XmlDoc: XmlDocument; DownloadToFileName: Text)
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
    begin
        //TODO: utilities
        TempBlob.CreateOutStream(OutStr);
        XmlDoc.WriteTo(OutStr);
        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', DownloadToFileName);
    end;
}
