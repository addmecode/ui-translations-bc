codeunit 50100 "ADD_ExtensionTranslationMgt"
{
    procedure ImportXlf(ExtTransl: Record ADD_ExtensionTranslation)
    var
        ElTransl: Record ADD_ElementTranslation;
        DelElTranslQues: Label 'Translation elements already exist for %1 Extension ID. Do you want to delete them and continue?';
    begin
        ElTransl.SetRange("Extension ID", ExtTransl."Extension ID");
        if ElTransl.FindSet() then begin
            if not Confirm(DelElTranslQues, false, ExtTransl."Extension ID") then
                exit;
            ElTransl.DeleteAll(false);
        end;
        CreateDemoElTransl(ExtTransl); // todo
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
        ElTransl."Element Source Caption" := 'Target Language';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Extension Version" := ExtTransl."Extension Version";
        ElTransl."Trans Unit ID" := 'Table 1163407375 - Property 2879900211';
        ElTransl."Object Type" := ElTransl."Object Type"::Table;
        ElTransl."Object Name" := 'ADD_ElementTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Object ID';
        ElTransl."Element Source Caption" := 'Object ID';
        ElTransl.Insert(false);

        ElTransl.Init();
        ElTransl."Extension ID" := ExtTransl."Extension ID";
        ElTransl."Extension Version" := ExtTransl."Extension Version";
        ElTransl."Trans Unit ID" := 'Table 1163407376 - Property 2879900212';
        ElTransl."Object Type" := ElTransl."Object Type"::Table;
        ElTransl."Object Name" := 'ADD_ExtensionTranslation';
        ElTransl."Element Type" := 'Field';
        ElTransl."Element Name" := 'Publisher';
        ElTransl."Element Source Caption" := 'Publisher';
        ElTransl.Insert(false);

    end;

}
