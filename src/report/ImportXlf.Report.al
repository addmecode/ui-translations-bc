report 50100 "ADD_ImportXlf"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Import Xlf';

    requestpage
    {
        AboutTitle = 'Teaching tip title'; //todo
        AboutText = 'Teaching tip content';
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
                        TableRelation = "NAV App Installed App"."App ID";
                        trigger OnValidate()
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
                    field("Extension Name"; ExtName)
                    {
                        Caption = 'Extension Name';
                    }
                    field("Extension Publisher"; ExtPublisher)
                    {
                        Caption = 'Extension Publisher';
                    }
                    field("Extension Version"; ExtVersion)
                    {
                        Caption = 'Extension Version';
                    }
                    field("Import Target Language"; ImportTargetLang)
                    {
                        Caption = 'Import Target Language';
                        trigger OnValidate()
                        begin
                            if ImportTargetLang then
                                TargetLang := '';
                        end;
                    }
                    field("Target Language"; TargetLang)
                    {
                        Caption = 'Target Language';
                        Enabled = not ImportTargetLang;
                        Editable = false;

                        trigger OnAssistEdit()
                        var
                            WindLang: Record "Windows Language";
                        begin
                            if Page.RunModal(Page::"Windows Languages", WindLang) = Action::LookupOK then
                                TargetLang := WindLang."Language Tag"
                            else
                                TargetLang := '';
                        end;
                    }
                }
            }
        }
    }

    var
        ExtID: Guid;
        ExtName: Text;
        ExtPublisher: Text;
        ExtVersion: Text;
        TargetLang: Text;
        ImportTargetLang: Boolean;
        CreatedExtTranslHead: Record ADD_ExtTranslHeader;

    trigger OnInitReport()
    begin
        ImportTargetLang := true;
    end;

    trigger OnPreReport()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        ExtTranslMgt.ImportXlf(CreatedExtTranslHead, ExtID, ExtName, ExtPublisher, ExtVersion, ImportTargetLang, TargetLang);
        commit();
    end;

    trigger OnPostReport()
    begin
        Page.RunModal(Page::ADD_ExtTranslCard, CreatedExtTranslHead);
    end;
}