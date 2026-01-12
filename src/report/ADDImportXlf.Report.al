report 50100 "ADD_ImportXlf"
{
    ApplicationArea = All;
    Caption = 'Import Xlf';
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
                    field("Extension ID"; ExtID)
                    {
                        ApplicationArea = All;
                        Caption = 'Extension ID';
                        ToolTip = 'Extension ID';

                        trigger OnValidate()
                        begin
                            ValidateExtID();
                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            NavAppInstalledApp: Record "NAV App Installed App";
                        begin
                            if Page.RunModal(Page::ADD_NavAppInstalledApp, NavAppInstalledApp) = Action::LookupOK then begin
                                ExtID := NavAppInstalledApp."App ID";
                                ValidateExtID();
                                exit(true);
                            end;
                            exit(false);
                        end;
                    }
                    field("Extension Name"; ExtName)
                    {
                        ApplicationArea = All;
                        Caption = 'Extension Name';
                        ToolTip = 'Extension Name';
                    }
                    field("Extension Publisher"; ExtPublisher)
                    {
                        ApplicationArea = All;
                        Caption = 'Extension Publisher';
                        ToolTip = 'Extension Publisher';
                    }
                    field("Extension Version"; ExtVersion)
                    {
                        ApplicationArea = All;
                        Caption = 'Extension Version';
                        ToolTip = 'Extension Version';
                    }
                    field("Import Target Language"; ImportTargetLang)
                    {
                        ApplicationArea = All;
                        Caption = 'Import Target Language';
                        ToolTip = 'Import Target Language';

                        trigger OnValidate()
                        begin
                            if ImportTargetLang then
                                TargetLang := '';
                        end;
                    }
                    field("Target Language"; TargetLang)
                    {
                        ApplicationArea = All;
                        Caption = 'Target Language';
                        Editable = false;
                        Enabled = not ImportTargetLang;
                        ToolTip = 'Target Language';

                        trigger OnAssistEdit()
                        var
                            ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                        begin
                            TargetLang := ExtTranslMgt.SelectLangTag();
                        end;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        this.ImportTargetLang := true;
    end;

    trigger OnPreReport()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.ImportXlf(this.CreatedExtTranslHead, this.ExtID, this.ExtName, this.ExtPublisher, this.ExtVersion, this.ImportTargetLang, this.TargetLang);
        Commit();
    end;

    trigger OnPostReport()
    begin
        Page.RunModal(Page::ADD_ExtTranslCard, this.CreatedExtTranslHead);
    end;

    var
        CreatedExtTranslHead: Record ADD_ExtTranslHeader;
        ImportTargetLang: Boolean;
        ExtID: Guid;
        TargetLang: Text[80];
        ExtName: Text[250];
        ExtPublisher: Text[250];
        ExtVersion: Text[250];

    local procedure ValidateExtID()
    var
        NavAppInstalledApp: Record "NAV App Installed App";
    begin
        if IsNullGuid(ExtID) then
            exit;
        if not NavAppInstalledApp.Get(ExtID) then
            exit;
        ExtName := NavAppInstalledApp.Name;
        ExtPublisher := NavAppInstalledApp.Publisher;
        ExtVersion := Format(NavAppInstalledApp."Version Major") + '.' +
                                   Format(NavAppInstalledApp."Version Minor") + '.' +
                                   Format(NavAppInstalledApp."Version Build") + '.' +
                                   Format(NavAppInstalledApp."Version Revision");
    end;
}
