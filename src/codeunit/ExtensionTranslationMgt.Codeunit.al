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

    local procedure ParseXliffNote(XliffNote: Text; var ObjType: Text; var ObjName: Text; var ElementType: Text; var ElementName: Text)
    var
        HyphenParts: List of [Text];
        HyphenCounter: Integer;
        ElemTypeStartPart: Integer;
    begin
        // Page Contact List - Action NewSalesQuote - Property ToolTip
        // ObjType = Page, ObjName = Contact List, ElementName = Action NewSalesQuote, ElementType = Property ToolTip
        // Page ADD_ExtTranslSetupSubform - Property Caption
        // ObjType = Page, ObjName = ADD_ExtTranslSetupSubform, ElementName = , ElementType = Property Caption

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

    internal procedure CopyExtTranslToNewTargLang(CopyFromExtID: Guid; CopyFromTargetLang: Text[30]; CopyToTargetLang: Text[30])
    var
        ExtTranslHeadCopyFrom: Record ADD_ExtTranslSetupHeader;
        ExtTranslHeadCopyTo: Record ADD_ExtTranslSetupHeader;
        ExtTranslLineCopyFrom: Record ADD_ExtTranslSetupLine;
        ExtTranslLineCopyTo: Record ADD_ExtTranslSetupLine;
    begin
        if (IsNullGuid(CopyFromExtID)) or (CopyFromTargetLang = '') or (CopyToTargetLang = '') then
            Error('Extension ID, Target Language and Source Language cannot be empty');
        if CopyFromTargetLang = CopyToTargetLang then
            Error('The target language to copy to must be different from the source language');

        ExtTranslHeadCopyFrom.Get(CopyFromExtID, CopyFromTargetLang);
        ExtTranslHeadCopyTo.Init();
        ExtTranslHeadCopyTo.TransferFields(ExtTranslHeadCopyFrom);
        ExtTranslHeadCopyTo."Target Language" := CopyToTargetLang;
        ExtTranslHeadCopyTo.Insert(True);

        ExtTranslLineCopyFrom.SetRange("Extension ID", ExtTranslHeadCopyFrom."Extension ID");
        ExtTranslLineCopyFrom.SetRange("Target Language", ExtTranslHeadCopyFrom."Target Language");
        if ExtTranslLineCopyFrom.FindSet(true) then begin
            repeat
                ExtTranslLineCopyTo.Init();
                ExtTranslLineCopyTo.TransferFields(ExtTranslLineCopyFrom);
                ExtTranslLineCopyTo."Target Language" := CopyToTargetLang;
                ExtTranslLineCopyTo."Element Target Caption 1" := '';
                ExtTranslLineCopyTo."Element Target Caption 2" := '';
                ExtTranslLineCopyTo."Element Target Caption 3" := '';
                ExtTranslLineCopyTo."Element Target Caption 4" := '';
                ExtTranslLineCopyTo."Element Target Caption 5" := '';
                ExtTranslLineCopyTo.Translated := false;
                ExtTranslLineCopyTo.Insert(True);
            until ExtTranslLineCopyFrom.Next() = 0;
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
