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
                        ToolTip = 'Copy From Extension ID';
                        TableRelation = ADD_ExtTranslHeader."Extension ID";
                        trigger OnValidate()
                        begin
                            CopyFromTargetLang := '';
                        end;
                    }
                    field("Copy From Target Language"; CopyFromTargetLang)
                    {
                        Caption = 'Copy From Target Language';
                        ToolTip = 'Copy From Target Language';

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
                        ToolTip = 'Copy To Target Language';
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
        CopyFromTargetLang: Text[80];
        CopyToTargetLang: Text[80];


    trigger OnPreReport()
    var
        ExtTranslHeadCopyFrom: Record ADD_ExtTranslHeader;
    begin
        ExtTranslHeadCopyFrom.Get(this.CopyFromExtID, this.CopyFromTargetLang);
        ExtTranslHeadCopyFrom.CopyExtTranslHeadAndLinesToNewTargetLang(this.CopyToTargetLang);
        commit();
    end;

    trigger OnPostReport()
    var
        ExtTranslNew: Record ADD_ExtTranslHeader;
    begin
        if ExtTranslNew.Get(this.CopyFromExtID, this.CopyToTargetLang) then
            Page.RunModal(Page::ADD_ExtTranslCard, ExtTranslNew);
    end;

    procedure SetReqPageParams(ExtID: Guid; TargetLang: Text[80])
    begin
        this.CopyFromExtID := ExtID;
        this.CopyFromTargetLang := TargetLang;
    end;
}