report 50101 "ADD_CopyExtTranslToNewTargLang"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Copy Extension Translation To New Target Language';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Copy From Extension ID"; CopyFromExtID)
                    {
                        Caption = 'Copy From Extension ID';
                        TableRelation = ADD_ExtTranslHeader."Extension ID";
                        trigger OnValidate()
                        begin
                            CopyFromTargetLang := '';
                        end;
                    }
                    field("Copy From Target Language"; CopyFromTargetLang)
                    {
                        Caption = 'Copy From Target Language';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ExtTransHead: Record ADD_ExtTranslHeader;
                        begin
                            if IsNullGuid(CopyFromExtID) then
                                exit(false);
                            ExtTransHead.SetRange("Extension ID", CopyFromExtID);
                            CopyFromTargetLang := '';
                            if Page.RunModal(Page::"ADD_ExtTranslList", ExtTransHead) = Action::LookupOK then
                                CopyFromTargetLang := ExtTransHead."Target Language";
                        end;
                    }
                    field("Copy To Target Language"; CopyToTargetLang)
                    {
                        Caption = 'Copy To Target Language';
                        Editable = false;

                        trigger OnAssistEdit()
                        var
                            ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                        begin
                            CopyToTargetLang := ExtTranslMgt.SelectLangTag();
                        end;
                    }
                }
            }
        }
    }

    var
        CopyFromExtID: Guid;
        CopyFromTargetLang: Text[30];
        CopyToTargetLang: Text[30];


    trigger OnPreReport()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.CopyExtTranslToNewTargLang(CopyFromExtID, CopyFromTargetLang, CopyToTargetLang);
        commit();
    end;

    trigger OnPostReport()
    var
        ExtTranslNew: Record ADD_ExtTranslHeader;
    begin
        if ExtTranslNew.Get(CopyFromExtID, CopyToTargetLang) then
            Page.RunModal(Page::ADD_ExtTranslCard, ExtTranslNew);
    end;

    procedure SetReqPageParams(ExtID: Guid; TargetLang: Text[30])
    begin
        CopyFromExtID := ExtID;
        CopyFromTargetLang := TargetLang;
    end;
}