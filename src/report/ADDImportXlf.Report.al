report 50100 "ADD_ImportXlf"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Import Xlf';

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
                        Caption = 'Extension ID';
                        ToolTip = 'Extension ID';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            NavAppInstalledApp: Record "NAV App Installed App";
                        begin
                            if Page.RunModal(Page::"ADD_NavAppInstalledApp", NavAppInstalledApp) = Action::LookupOK then begin
                                ExtID := NavAppInstalledApp."App ID";
                                ValidateExtID();
                            end;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateExtID();
                        end;
                    }
                    field("Extension Name"; ExtName)
                    {
                        Caption = 'Extension Name';
                        ToolTip = 'Extension Name';
                    }
                    field("Extension Publisher"; ExtPublisher)
                    {
                        Caption = 'Extension Publisher';
                        ToolTip = 'Extension Publisher';
                    }
                    field("Extension Version"; ExtVersion)
                    {
                        Caption = 'Extension Version';
                        ToolTip = 'Extension Version';
                    }
                    field("Import Target Language"; ImportTargetLang)
                    {
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
                        Caption = 'Target Language';
                        ToolTip = 'Target Language';
                        Enabled = not ImportTargetLang;
                        Editable = false;

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

    var
        CreatedExtTranslHead: Record ADD_ExtTranslHeader;
        ExtID: Guid;
        ExtName: Text[250];
        ExtPublisher: Text[250];
        ExtVersion: Text[250];
        TargetLang: Text[80];
        ImportTargetLang: Boolean;

    trigger OnInitReport()
    begin
        this.ImportTargetLang := true;
    end;

    trigger OnPreReport()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.ImportXlf(this.CreatedExtTranslHead, this.ExtID, this.ExtName, this.ExtPublisher, this.ExtVersion, this.ImportTargetLang, this.TargetLang);
        commit();
    end;

    trigger OnPostReport()
    begin
        Page.RunModal(Page::ADD_ExtTranslCard, this.CreatedExtTranslHead);
    end;

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