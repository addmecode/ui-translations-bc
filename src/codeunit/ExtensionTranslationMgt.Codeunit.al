codeunit 50100 "ADD_ExtensionTranslationMgt"
{
    procedure ImportXlf(ExtTransl: Record ADD_ExtensionTranslation)
    var
        ElTransl: Record ADD_ElementTranslation;
        DelElTranslQues: Label 'Translation elements already exist for %1 Extension ID. Do you want to delete them and continue?';
        XmlDoc: XmlDocument;
        InStr: InStream;
        OutStr: OutStream;
        ImportedFileName: text;
        ExtTranslMod: Record ADD_ExtensionTranslation;
        TransUnitNodeList: XmlNodeList;
        NoteNodeList: XmlNodeList;
        NsMgr: XmlNamespaceManager;
        TuId: Text;
        TransUnitNode: XmlNode;
        NoteNode: XmlNode;
        TransUnitAttributes: XmlAttributeCollection;
        NoteAttributes: XmlAttributeCollection;
        TransUnitAttr: XmlAttribute;
        NoteAttr: XmlAttribute;
        Root: XmlElement;
        NsUri: Text;
        NewElTransl: Record ADD_ElementTranslation;
        SourceNode: XmlNode;
        SourceTxt: text;
        DeveloperNote: Text;
        XliffNote: Text;
        TableFieldStartPos: Integer;
    begin
        ElTransl.SetRange("Extension ID", ExtTransl."Extension ID");
        if ElTransl.FindSet() then begin
            if not Confirm(DelElTranslQues, false, ExtTransl."Extension ID") then
                exit;
            ElTransl.DeleteAll(false);
        end;
        // CreateDemoElTransl(ExtTransl); // todo

        UploadIntoStream('Select Xlf file', '', 'Xlf Files (*.xlf)|*.xlf', ImportedFileName, InStr);
        ExtTranslMod.Get(ExtTransl."Extension ID", ExtTransl."Extension Version");
        ExtTransl."Imported Xlf".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        ExtTransl.Modify(false);

        ExtTransl.CalcFields("Imported Xlf");
        ExtTransl."Imported Xlf".CreateInStream(InStr);

        XmlDocument.ReadFrom(InStr, XmlDoc);
        XmlDoc.GetRoot(Root);
        NsUri := Root.NamespaceUri();
        NsMgr.AddNamespace('x', NsUri);
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
            NewElTransl."Extension ID" := ExtTransl."Extension ID";
            NewElTransl."Extension Version" := ExtTransl."Extension Version";
            NewElTransl."Trans Unit ID" := TuId;
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

            TableFieldStartPos := 1;
            NewElTransl."Element Source Caption 1" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 1"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 1");
            NewElTransl."Element Source Caption 2" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 2"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 2");
            NewElTransl."Element Source Caption 3" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 3"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 3");
            NewElTransl."Element Source Caption 4" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 4"));
            TableFieldStartPos += MaxStrLen(NewElTransl."Element Source Caption 4");
            NewElTransl."Element Source Caption 5" := CopyStr(XliffNote, TableFieldStartPos, MaxStrLen(NewElTransl."Element Source Caption 5"));

            NewElTransl.Insert(false);
        end;
    end;

    local procedure CreateDemoElTransl(ExtTransl: Record ADD_ExtensionTranslation)
    var
        ElTransl: Record ADD_ElementTranslation;
    begin
        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Extension Version" := ExtTransl."Extension Version";
        ElTransl."Trans Unit ID" := 'Table 1163407374 - Property 2879900210';
        ElTransl."Object Type" := ElTransl."Object Type"::Table;
        ElTransl."Object Name" := 'ADD_ElementTranslated';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Target Language';
        ElTransl."Element Source Caption 1" := 'Target Language';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Extension Version" := ExtTransl."Extension Version";
        ElTransl."Trans Unit ID" := 'Table 1163407375 - Property 2879900211';
        ElTransl."Object Type" := ElTransl."Object Type"::Table;
        ElTransl."Object Name" := 'ADD_ElementTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Object ID';
        ElTransl."Element Source Caption 1" := 'Object ID';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Extension Version" := ExtTransl."Extension Version";
        ElTransl."Trans Unit ID" := 'Table 1163407376 - Property 2879900212';
        ElTransl."Object Type" := ElTransl."Object Type"::Table;
        ElTransl."Object Name" := 'ADD_ExtensionTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Publisher';
        ElTransl."Element Source Caption 1" := 'Publisher';
        ElTransl.Insert(false);
    end;
}
