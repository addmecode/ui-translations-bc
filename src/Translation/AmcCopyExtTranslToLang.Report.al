report 50101 "AMC Copy Ext Transl To Lang"
{
    ApplicationArea = All;
    Caption = 'Copy Extension Translation To New Target Language';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

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
                        ApplicationArea = All;
                        Caption = 'Copy From Extension ID';
                        TableRelation = "AMC Extension Transl Header"."Extension ID";
                        ToolTip = 'Copy From Extension ID';
                        trigger OnValidate()
                        begin
                            CopyFromTargetLang := '';
                        end;
                    }
                    field("Copy From Target Language"; CopyFromTargetLang)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy From Target Language';
                        ToolTip = 'Copy From Target Language';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ExtTransHead: Record "AMC Extension Transl Header";
                        begin
                            if IsNullGuid(CopyFromExtID) then
                                exit(false);
                            ExtTransHead.SetRange("Extension ID", CopyFromExtID);
                            CopyFromTargetLang := '';
                            if Page.RunModal(Page::"AMC Extension Transl List", ExtTransHead) = Action::LookupOK then
                                CopyFromTargetLang := ExtTransHead."Target Language";
                            exit(CopyFromTargetLang <> '');
                        end;
                    }
                    field("Copy To Target Language"; CopyToTargetLang)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy To Target Language';
                        Editable = false;
                        ToolTip = 'Copy To Target Language';

                        trigger OnAssistEdit()
                        var
                            ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
                        begin
                            CopyToTargetLang := ExtTranslMgt.SelectLangTag();
                        end;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        ExtTranslHeadCopyFrom: Record "AMC Extension Transl Header";
    begin
        ExtTranslHeadCopyFrom.Get(this.CopyFromExtID, this.CopyFromTargetLang);
        ExtTranslHeadCopyFrom.CopyExtTranslHeadAndLinesToNewTargetLang(this.CopyToTargetLang);
        Commit();
    end;

    trigger OnPostReport()
    var
        ExtTranslNew: Record "AMC Extension Transl Header";
    begin
        if ExtTranslNew.Get(this.CopyFromExtID, this.CopyToTargetLang) then
            Page.RunModal(Page::"AMC Extension Transl Card", ExtTranslNew);
    end;

    var
        CopyFromExtID: Guid;
        CopyFromTargetLang: Text[80];
        CopyToTargetLang: Text[80];

    /// <summary>
    /// Sets request page parameters for the copy operation.
    /// </summary>
    /// <param name="ExtID">Extension ID.</param>
    /// <param name="TargetLang">Target language tag.</param>
    procedure SetReqPageParams(ExtID: Guid; TargetLang: Text[80])
    begin
        this.CopyFromExtID := ExtID;
        this.CopyFromTargetLang := TargetLang;
    end;
}
