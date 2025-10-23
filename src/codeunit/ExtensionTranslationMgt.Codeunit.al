codeunit 50100 "ADD_ExtensionTranslationMgt"
{
    procedure ImportXlf(ExtID: Guid; ExtName: Text; ExtPublisher: Text; ExtVersion: Text; TargetLang: Text)
    var
        ElTransl: Record ADD_ExtTranslSetupLine;
        DelElTranslQues: Label 'Translation elements already exist for %1 Extension ID. Do you want to delete them and continue?';
        XmlDoc: XmlDocument;
        InStr: InStream;
        OutStr: OutStream;
        ImportedFileName: text;
        ExtTranslNew: Record ADD_ExtTranslSetupHeader;
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
        NewElTransl: Record ADD_ExtTranslSetupLine;
        SourceNode: XmlNode;
        SourceTxt: text;
        DeveloperNote: Text;
        XliffNote: Text;
        TableFieldStartPos: Integer;
        FileNode: XmlNode;
        SourceLang: Text;
    begin
        ElTransl.SetRange("Extension ID", ExtID);
        if ElTransl.FindSet() then begin
            if not Confirm(DelElTranslQues, false, ExtID) then
                exit;
            ElTransl.DeleteAll(true);
        end;
        // CreateDemoElTransl(ExtTransl); // todo

        //TODO: add progress bar
        UploadIntoStream('Select Xlf file', '', 'Xlf Files (*.xlf)|*.xlf', ImportedFileName, InStr);
        XmlDocument.ReadFrom(InStr, XmlDoc);
        XmlDoc.GetRoot(Root);
        NsUri := Root.NamespaceUri();
        NsMgr.AddNamespace('x', NsUri);

        XmlDoc.SelectSingleNode('//x:file', NsMgr, FileNode);
        FileAttributes := FileNode.AsXmlElement().Attributes();
        FileAttributes.Get('source-language', FileAttr);
        SourceLang := FileAttr.Value();

        ExtTranslNew.init();
        ExtTranslNew."Extension ID" := ExtID;
        ExtTranslNew."Target Language" := TargetLang;
        ExtTranslNew."Extension Name" := ExtName;
        ExtTranslNew."Extension Publisher" := ExtPublisher;
        ExtTranslNew."Extension Version" := ExtVersion;
        ExtTranslNew."Imported Xlf".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        ExtTranslNew."Source Language" := SourceLang;
        ExtTranslNew.Insert(false);

        XmlDoc.SelectNodes('//x:file/x:body/x:group/x:trans-unit', NsMgr, TransUnitNodeList);
        foreach TransUnitNode in TransUnitNodeList do begin
            TransUnitAttributes := TransUnitNode.AsXmlElement().Attributes();
            TransUnitAttributes.Get('id', TransUnitAttr);
            TuId := TransUnitAttr.Value();

            TransUnitNode.SelectSingleNode('x:source', NsMgr, SourceNode);
            SourceTxt := SourceNode.AsXmlElement().InnerText();

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
            ParseTransUnitId(NewElTransl."Trans Unit ID", NewElTransl."Object Type", NewElTransl."Element Type");
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
            ParseXliffNote(NewElTransl.GetXliffNotes(), NewElTransl."Object Name", NewElTransl."Element Name");

            TableFieldStartPos := 1;
            NewElTransl."Element Source Caption 1" := CopyStr(SourceTxt, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 1"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 1");
            NewElTransl."Element Source Caption 2" := CopyStr(SourceTxt, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 2"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 2");
            NewElTransl."Element Source Caption 3" := CopyStr(SourceTxt, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 3"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 3");
            NewElTransl."Element Source Caption 4" := CopyStr(SourceTxt, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 4"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 4");
            NewElTransl."Element Source Caption 5" := CopyStr(SourceTxt, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 5"));

            NewElTransl.Insert(false);
        end;
    end;

    local procedure ParseTransUnitId(TransUnitId: Text; var ObjType: Text; var ElemType: Text)
    var
        HyphenParts: List of [Text];
        HyphenCounter: Integer;
    begin
        // Page 2164439538 - Control 2515772770 - Property 1295455071 -> ObjType = Report, Element type = Control property
        HyphenParts := TransUnitId.Split(' - ');
        ObjType := DecodeTransUnitIdHyphenPart(HyphenParts.Get(1));
        ElemType := '';
        for HyphenCounter := 2 to HyphenParts.Count() do begin
            if HyphenCounter > 2 then
                ElemType += ' ';
            ElemType += DecodeTransUnitIdHyphenPart(HyphenParts.Get(HyphenCounter));
        end;
    end;

    local procedure DecodeTransUnitIdHyphenPart(TransUnitIdHyphenPart: Text): Text
    begin
        exit(TransUnitIdHyphenPart.Substring(1, TransUnitIdHyphenPart.IndexOf(' ') - 1));
    end;

    local procedure ParseXliffNote(XliffNote: Text; var ObjectName: Text; var ElementName: Text)
    var
        HyphenParts: List of [Text];
        HyphenCounter: Integer;
    begin
        // Page Contact List - Action NewSalesQuote - Property ToolTip
        HyphenParts := XliffNote.Split(' - ');
        ObjectName := DecodeXliffNoteHyphenPart(HyphenParts.Get(1));
        ElementName := '';
        for HyphenCounter := 2 to HyphenParts.Count() do begin
            if HyphenCounter > 2 then
                ElementName += ' ';
            ElementName += DecodeXliffNoteHyphenPart(HyphenParts.Get(HyphenCounter));
        end;
    end;

    local procedure DecodeXliffNoteHyphenPart(XliffNoteHyphenPart: Text): Text
    begin
        exit(XliffNoteHyphenPart.Substring(XliffNoteHyphenPart.IndexOf(' ') + 1));
    end;

    procedure RunObject(ElemTransl: Record ADD_ExtTranslSetupLine)
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

    local procedure CreateDemoElTransl(ExtTransl: Record ADD_ExtTranslSetupHeader)
    var
        ElTransl: Record ADD_ExtTranslSetupLine;
    begin
        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Trans Unit ID" := 'Table 1163407374 - Property 2879900210';
        ElTransl."Object Type" := 'Table';
        ElTransl."Object Name" := 'ADD_ElementTranslated';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Target Language';
        ElTransl."Element Source Caption 1" := 'Target Language';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Trans Unit ID" := 'Table 1163407375 - Property 2879900211';
        ElTransl."Object Type" := 'Table';
        ElTransl."Object Name" := 'ADD_ElementTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Object ID';
        ElTransl."Element Source Caption 1" := 'Object ID';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Trans Unit ID" := 'Table 1163407376 - Property 2879900212';
        ElTransl."Object Type" := 'Table';
        ElTransl."Object Name" := 'ADD_ExtensionTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Publisher';
        ElTransl."Element Source Caption 1" := 'Publisher';
        ElTransl.Insert(false);
    end;
}
