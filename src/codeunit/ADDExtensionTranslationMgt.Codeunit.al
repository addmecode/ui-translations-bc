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

    procedure SetExtTransLineNewTarget(ExtTranslLine: Record ADD_ExtTranslLine; NewTarget: Text)
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

    procedure SetExtTransLineTarget(ExtTranslLine: Record ADD_ExtTranslLine; Target: Text)
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

    procedure SetExtTransLineSource(ExtTranslLine: Record ADD_ExtTranslLine; Source: Text)
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

    procedure ImportXlf(var CreatedExtTranslHead: Record ADD_ExtTranslHeader; ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; ImportTargetLang: Boolean; TargetLang: Text)
    var
        ElTranslHead: Record ADD_ExtTranslHeader;
        DelExtTranslQues: Label 'Extension Translations already exist for %1 Extension ID. Do you want to delete them and continue?';
        XmlDoc: XmlDocument;
        InStr: InStream;
        OutStr: OutStream;
        ImportedFileName: text;
        TransUnitNodeList: XmlNodeList;
        NoteNodeList: XmlNodeList;
        NsMgr: XmlNamespaceManager;
        TuId: Text;
        TransUnitNode: XmlNode;
        NoteNode: XmlNode;
        TransUnitAttributes: XmlAttributeCollection;
        NoteAttributes: XmlAttributeCollection;
        FileAttributes: XmlAttributeCollection;
        TransUnitAttr: XmlAttribute;
        NoteAttr: XmlAttribute;
        FileAttr: XmlAttribute;
        Root: XmlElement;
        NsUri: Text;
        NewElTransl: Record ADD_ExtTranslLine;
        SourceNode: XmlNode;
        TargetNode: XmlNode;
        SourceTxt: text;
        TargetTxt: text;
        DeveloperNote: Text;
        XliffNote: Text;
        TableFieldStartPos: Integer;
        FileNode: XmlNode;
        SourceLang: Text;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2';
        FirstProgrStepMsg: Label 'Importing File: %1';
        SecProgrStepMsg: Label 'Importing Lines: %1 of %2';
        TransUnitCounter: Integer;
        PROGR_UPD_PERC: Decimal;
        ProgrUpdBatch: Integer;
    begin
        PROGR_UPD_PERC := 0.1;
        if IsNullGuid(ExtID) then
            Error('Extension ID cannot be empty');
        if (not ImportTargetLang) and (TargetLang = '') then
            Error('Target Language must be specified when Import Target Language is set to false');

        ElTranslHead.SetRange("Extension ID", ExtID);
        if ElTranslHead.FindSet() then begin
            if not Confirm(DelExtTranslQues, false, ExtID) then
                exit;
            ElTranslHead.DeleteAll(true);
        end;

        UploadIntoStream('Select Xlf file', '', 'Xlf Files (*.xlf)|*.xlf', ImportedFileName, InStr);
        if GuiAllowed then begin
            Progress.Open(ProgressMsg);
            Progress.Update(1, StrSubstNo(FirstProgrStepMsg, ImportedFileName));
        end;
        XmlDocument.ReadFrom(InStr, XmlDoc);
        XmlDoc.GetRoot(Root);
        NsUri := Root.NamespaceUri();
        NsMgr.AddNamespace('x', NsUri);

        XmlDoc.SelectSingleNode('//x:file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        FileAttributes.Get('source-language', FileAttr);
        SourceLang := FileAttr.Value();

        if ImportTargetLang then begin
            FileAttributes := FileNode.AsXmlElement().Attributes();
            FileAttributes.Get('target-language', FileAttr);
            TargetLang := FileAttr.Value();
        end;

        CreatedExtTranslHead.init();
        CreatedExtTranslHead."Extension ID" := ExtID;
        CreatedExtTranslHead."Target Language" := TargetLang;
        CreatedExtTranslHead."Extension Name" := ExtName;
        CreatedExtTranslHead."Extension Publisher" := ExtPublisher;
        CreatedExtTranslHead."Extension Version" := ExtVersion;
        CreatedExtTranslHead."Imported Xlf".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        CreatedExtTranslHead."Imported FileName" := ImportedFileName;
        CreatedExtTranslHead."Source Language" := SourceLang;
        CreatedExtTranslHead.Insert(false);

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

            TransUnitNode.SelectSingleNode('x:source', NsMgr, SourceNode);
            SourceTxt := SourceNode.AsXmlElement().InnerText();

            TargetTxt := '';
            if TransUnitNode.SelectSingleNode('x:target', NsMgr, TargetNode) then
                TargetTxt := TargetNode.AsXmlElement().InnerText();

            TransUnitNode.SelectNodes('x:note', NsMgr, NoteNodeList);
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

            NewElTransl.Init();
            NewElTransl."Extension ID" := CreatedExtTranslHead."Extension ID";
            NewElTransl."Target Language" := CreatedExtTranslHead."Target Language";
            NewElTransl."Trans Unit ID" := TuId;
            NewElTransl.Translated := false;
            TableFieldStartPos := 1;
            NewElTransl."Developer Note 1" := CopyStr(DeveloperNote, TableFieldStartPos, MaxStrLen(NewElTransl."Developer Note 1"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Developer Note 1");
            NewElTransl."Developer Note 2" := CopyStr(DeveloperNote, TableFieldStartPos, MaxStrLen(NewElTransl."Developer Note 2"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Developer Note 2");
            NewElTransl."Developer Note 3" := CopyStr(DeveloperNote, TableFieldStartPos, MaxStrLen(NewElTransl."Developer Note 3"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Developer Note 3");
            NewElTransl."Developer Note 4" := CopyStr(DeveloperNote, TableFieldStartPos, MaxStrLen(NewElTransl."Developer Note 4"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Developer Note 4");
            NewElTransl."Developer Note 5" := CopyStr(DeveloperNote, TableFieldStartPos, MaxStrLen(NewElTransl."Developer Note 5"));

            TableFieldStartPos := 1;
            NewElTransl."Xliff Note 1" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Xliff Note 1"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Xliff Note 1");
            NewElTransl."Xliff Note 2" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Xliff Note 2"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Xliff Note 2");
            NewElTransl."Xliff Note 3" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Xliff Note 3"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Xliff Note 3");
            NewElTransl."Xliff Note 4" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Xliff Note 4"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Xliff Note 4");
            NewElTransl."Xliff Note 5" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Xliff Note 5"));
            ParseXliffNote(TuId, XliffNote, NewElTransl."Object Type", NewElTransl."Object Name",
                           NewElTransl."Element Type", NewElTransl."Element Name");

            NewElTransl.SetSource(SourceTxt);
            NewElTransl.SetTarget(TargetTxt);
            NewElTransl.SetNewTarget(TargetTxt);

            NewElTransl.Insert(false);
        end;
        if GuiAllowed then
            Progress.Close();
    end;

    local procedure ParseXliffNote(TransUnitId: Text; XliffNote: Text; var ObjType: Text; var ObjName: Text; var ElementType: Text; var ElementName: Text)
    var
        HyphenParts: List of [Text];
        TuHyphenParts: List of [Text];
        HyphenCounter: Integer;
        ElemTypeStartPart: Integer;
        ElemNameStartPart: Integer;
        ElemTypeFirstWord: Text;
        ElemNameFirstWord: Text;
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

        TuHyphenParts := TransUnitId.Split(' - ');
        ObjType := GetTextPartBeforeSpace(TuHyphenParts.Get(1));
        case TuHyphenParts.Count() of
            4:
                begin
                    ElemNameFirstWord := GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := GetTextPartBeforeSpace(TuHyphenParts.Get(4));
                end;
            3:
                begin
                    ElemNameFirstWord := GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                    ElemTypeFirstWord := GetTextPartBeforeSpace(TuHyphenParts.Get(3));
                end;
            2:
                begin
                    ElemNameFirstWord := '';
                    ElemTypeFirstWord := GetTextPartBeforeSpace(TuHyphenParts.Get(2));
                end;
            else
                Error('Found %1 parts in Trans unit id: %2', TuHyphenParts.Count(), TransUnitId);
        end;
        HyphenParts := XliffNote.Split(' - ');
        ElemTypeStartPart := XliffNote.LastIndexOf(' - ' + ElemTypeFirstWord);
        ElementType := XliffNote.Substring(ElemTypeStartPart + 3);
        XliffNote := XliffNote.Substring(1, ElemTypeStartPart - 1);
        if ElemNameFirstWord <> '' then begin
            ElemNameStartPart := XliffNote.LastIndexOf(' - ' + ElemNameFirstWord);
            ElementName := XliffNote.Substring(ElemNameStartPart + 3);
            XliffNote := XliffNote.Substring(1, ElemNameStartPart - 1);
        end;
        ObjName := XliffNote.Substring(StrLen(ObjType) + 1);

        // SetUniqElements(ElementName, ElementType); //TODO: delete
    end;

    local procedure SetUniqElements(ElemName: Text; ElemType: Text)
    var
        FirstWord: Text;
    begin
        if ElemName <> '' then begin
            FirstWord := ElemName.Substring(1, ElemName.IndexOf(' '));
            if FirstWord <> '' then begin
                if not UniqElemNames.Contains(FirstWord) then
                    UniqElemNames.Add(FirstWord);
            end;
        end;
        if ElemType <> '' then begin
            FirstWord := ElemType.Substring(1, ElemType.IndexOf(' '));
            if FirstWord <> '' then begin
                if not UniqElemTypes.Contains(FirstWord) then
                    UniqElemTypes.Add(FirstWord);
            end;
        end;
    end;

    local procedure GetTextPartAfterSpace(InputText: Text): Text
    begin
        exit(InputText.Substring(InputText.IndexOf(' ') + 1));
    end;

    local procedure GetTextPartBeforeSpace(InputText: Text): Text
    begin
        exit(InputText.Substring(1, InputText.IndexOf(' ') - 1));
    end;

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
            RunObject(AllObj."Object Type", AllObj."Object ID");
            Exit;
        end;

        AllObj.SetRange("Object Name", '');
        AllObj.SetRange("Object Caption", ElemTransl."Object Name");
        if AllObj.FindFirst() then begin
            RunObject(AllObj."Object Type", AllObj."Object ID");
            Exit;
        end;
    end;

    internal procedure CopyExtTranslToNewTargLang(CopyFromExtID: Guid; CopyFromTargetLang: Text[80]; CopyToTargetLang: Text[80])
    var
        ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader;
        ExtTranslHeadCopyTo: Record ADD_ExtTranslHeader;
        ExtTranslLineCopyFrom: Record ADD_ExtTranslLine;
        ExtTranslLineCopyTo: Record ADD_ExtTranslLine;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2';
        FirstProgrStepMsg: Label 'Copying Lines: %1 of %2';
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
        if ExtTranslLineCopyFrom.FindSet(true) then begin
            repeat
                LinesCounter += 1;
                if GuiAllowed and (LinesCounter mod ProgrUpdBatch = 0) then
                    Progress.Update(2, StrSubstNo(FirstProgrStepMsg, LinesCounter, LinesNumber));

                ExtTranslLineCopyTo.Init();
                ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
                ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
                ExtTranslLineCopyTo.Translated := false;
                ExtTranslLineCopyTo.Insert(True);
            until ExtTranslLineCopyFrom.Next() = 0;
        end;
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
        DownloadFromStream(InStr, '', '', '', ExtTranslHead."Imported FileName");
    end;

    internal procedure DownloadTranslated(ExtensionID: Guid; TargetLanguage: Text[80])
    var
        ExtTranslHead: Record ADD_ExtTranslHeader;
        ExtTranslLine: Record ADD_ExtTranslLine;
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
        TempBlob: Codeunit "Temp Blob";
        TranslatedFileName: Text;
        Ind: Integer;
        IndentBeforeTarget: XmlNode;
        IndentAfterTarget: XmlNode;
        CR: Char;
        LF: Char;
        NewLineText: Text;
        TargetNode: XmlNode;
        Progress: Dialog;
        ProgressMsg: Label '#1 \#2';
        FirstProgrStepMsg: Label 'Downloading File: %1';
        SecProgrStepMsg: Label 'Processing Lines: %1 of %2';
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
            if ExtTranslLine.Get(ExtTranslHead."Extension ID", TuId, ExtTranslHead."Target Language") then begin
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

    var
        UniqElemNames: List of [Text];
        UniqElemTypes: List of [Text];

}
