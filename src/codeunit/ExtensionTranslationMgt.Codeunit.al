codeunit 50100 "ADD_ExtensionTranslationMgt"
{
    procedure ImportXlf(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; ImportTargetLang: Boolean; TargetLang: Text)
    var
        ElTranslHead: Record ADD_ExtTranslHeader;
        DelExtTranslQues: Label 'Extension Translations already exist for %1 Extension ID. Do you want to delete them and continue?';
        XmlDoc: XmlDocument;
        InStr: InStream;
        OutStr: OutStream;
        ImportedFileName: text;
        ExtTranslNew: Record ADD_ExtTranslHeader;
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
        //TODO: validate Target Lang

        ElTranslHead.SetRange("Extension ID", ExtID);
        if ElTranslHead.FindSet() then begin
            if not Confirm(DelExtTranslQues, false, ExtID) then
                exit;
            ElTranslHead.DeleteAll(true);
        end;
        // CreateDemoElTransl(ExtTransl); // todo

        Progress.Open(ProgressMsg);
        UploadIntoStream('Select Xlf file', '', 'Xlf Files (*.xlf)|*.xlf', ImportedFileName, InStr);
        Progress.Update(1, StrSubstNo(FirstProgrStepMsg, ImportedFileName));

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

        ExtTranslNew.init();
        ExtTranslNew."Extension ID" := ExtID;
        ExtTranslNew."Target Language" := TargetLang;
        ExtTranslNew."Extension Name" := ExtName;
        ExtTranslNew."Extension Publisher" := ExtPublisher;
        ExtTranslNew."Extension Version" := ExtVersion;
        ExtTranslNew."Imported Xlf".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        ExtTranslNew."Imported FileName" := ImportedFileName;
        ExtTranslNew."Source Language" := SourceLang;
        ExtTranslNew.Insert(false);

        XmlDoc.SelectNodes('//x:file/x:body/x:group/x:trans-unit', NsMgr, TransUnitNodeList);
        TransUnitCounter := 0;
        ProgrUpdBatch := Round(TransUnitNodeList.Count() * PROGR_UPD_PERC, 1, '>');
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitCounter += 1;
            if TransUnitCounter mod ProgrUpdBatch = 0 then
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
            NewElTransl."Extension ID" := ExtTranslNew."Extension ID";
            NewElTransl."Target Language" := ExtTranslNew."Target Language";
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
            ParseXliffNote(NewElTransl.GetXliffNotes(), NewElTransl."Object Type", NewElTransl."Object Name",
                           NewElTransl."Element Type", NewElTransl."Element Name");

            NewElTransl.SetSource(SourceTxt);
            NewElTransl.SetTarget(TargetTxt);
            NewElTransl.SetNewTarget(TargetTxt);

            NewElTransl.Insert(false);
        end;
        Progress.Close();
    end;

    local procedure ParseXliffNote(XliffNote: Text; var ObjType: Text; var ObjName: Text; var ElementType: Text; var ElementName: Text)
    var
        HyphenParts: List of [Text];
        HyphenCounter: Integer;
        ElemTypeStartPart: Integer;
    begin
        // Page Contact List - Action NewSalesQuote - Property ToolTip
        // ObjType = Page, ObjName = Contact List, ElementName = Action NewSalesQuote, ElementType = Property ToolTip
        // Page ADD_ExtTranslSubform - Property Caption
        // ObjType = Page, ObjName = ADD_ExtTranslSubform, ElementName = , ElementType = Property Caption

        //TODO : find all possible starting words after object name
        //Codeunit Cash Flow Wksh. - Register - NamedType RegisterWorksheetLinesQst
        //Cash Flow Wksh. - Register is the cu name

        // Page Report Selection - VAT Stmt. - Control Sequence - Property ToolTip

        HyphenParts := XliffNote.Split(' - ');
        ObjType := GetTextPartBeforeSpace(HyphenParts.Get(1));
        ObjName := GetTextPartAfterSpace(HyphenParts.Get(1));
        ElementName := '';
        ElemTypeStartPart := 2;
        if HyphenParts.Count() > 2 then begin
            ElementName := HyphenParts.Get(2);
            ElemTypeStartPart := 3;
        end;
        ElementType := '';
        for HyphenCounter := ElemTypeStartPart to HyphenParts.Count() do begin
            if HyphenCounter > ElemTypeStartPart then
                ElementType += ' ';
            ElementType += HyphenParts.Get(HyphenCounter);
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

    internal procedure CopyExtTranslToNewTargLang(CopyFromExtID: Guid; CopyFromTargetLang: Text[30]; CopyToTargetLang: Text[30])
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
                if LinesCounter mod ProgrUpdBatch = 0 then
                    Progress.Update(2, StrSubstNo(FirstProgrStepMsg, LinesCounter, LinesNumber));

                ExtTranslLineCopyTo.Init();
                ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
                ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
                ExtTranslLineCopyTo.Translated := false;
                ExtTranslLineCopyTo.Insert(True);
            until ExtTranslLineCopyFrom.Next() = 0;
        end;
        Progress.Close();
    end;

    internal procedure DownloadImported(ExtensionID: Guid; TargetLanguage: Text[30])
    var
        ExtTranslHead: Record ADD_ExtTranslHeader;
        InStr: InStream;
    begin
        ExtTranslHead.Get(ExtensionID, TargetLanguage);
        ExtTranslHead.CalcFields("Imported Xlf");
        ExtTranslHead."Imported Xlf".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', '', ExtTranslHead."Imported FileName");
    end;

    internal procedure DownloadTranslated(ExtensionID: Guid; TargetLanguage: Text[30])
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
        Progress.Open(ProgressMsg);
        Progress.Update(1, StrSubstNo(FirstProgrStepMsg, TranslatedFileName));

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
            if TransUnitCounter mod ProgrUpdBatch = 0 then
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

    // local procedure CreateDemoElTransl(ExtTransl: Record ADD_ExtTranslHeader)
    // var
    //     ElTransl: Record ADD_ExtTranslLine;
    // begin
    //     ElTransl.Init();
    //     ElTransl."Extension ID" := ExtTransl."Extension ID";
    //     ElTransl."Trans Unit ID" := 'Table 1163407374 - Property 2879900210';
    //     ElTransl."Object Type" := 'Table';
    //     ElTransl."Object Name" := 'ADD_ElementTranslated';
    //     ElTransl."Element Type" := 'Field';
    //     ElTransl."Element Name" := 'Target Language';
    //     ElTransl."Element Source Caption 1" := 'Target Language';
    //     ElTransl.Insert(false);

    //     ElTransl.Init();
    //     ElTransl."Extension ID" := ExtTransl."Extension ID";
    //     ElTransl."Trans Unit ID" := 'Table 1163407375 - Property 2879900211';
    //     ElTransl."Object Type" := 'Table';
    //     ElTransl."Object Name" := 'ADD_ElementTranslation';
    //     ElTransl."Element Type" := 'Field';
    //     ElTransl."Element Name" := 'Object ID';
    //     ElTransl."Element Source Caption 1" := 'Object ID';
    //     ElTransl.Insert(false);

    //     ElTransl.Init();
    //     ElTransl."Extension ID" := ExtTransl."Extension ID";
    //     ElTransl."Trans Unit ID" := 'Table 1163407376 - Property 2879900212';
    //     ElTransl."Object Type" := 'Table';
    //     ElTransl."Object Name" := 'ADD_ExtensionTranslation';
    //     ElTransl."Element Type" := 'Field';
    //     ElTransl."Element Name" := 'Publisher';
    //     ElTransl."Element Source Caption 1" := 'Publisher';
    //     ElTransl.Insert(false);
    // end;
}
