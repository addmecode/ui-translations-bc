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
                    field("Target Language"; TargetLang)
                    {
                        Caption = 'Target Language';
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

    trigger OnInitReport()
    begin
        TargetLang := 'en-US'; //TOOD: delete
    end;

    trigger OnPreReport()
    var
        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
    begin
        //TODO: validate Target Lang
        if (IsNullGuid(ExtID)) or (TargetLang = '') then
            Error('Extension ID and Target Language cannot be empty');
        ExtTranslMgt.ImportXlf(ExtID, ExtName, ExtPublisher, ExtVersion, TargetLang);
        commit();
    end;

    trigger OnPostReport()
    var
        ExtTranslNew: Record ADD_ExtTranslSetupHeader;
    begin
        if ExtTranslNew.Get(ExtID, TargetLang) then
            Page.RunModal(Page::ADD_ExtTranslSetupCard, ExtTranslNew);
    end;
}