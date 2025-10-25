page 50101 "ADD_ExtTranslSetupCard"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Card';
    PageType = Card;
    SourceTable = ADD_ExtTranslSetupHeader;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("Extension ID"; Rec."Extension ID")
                {
                    ToolTip = 'Specifies the value of the Extension ID field.', Comment = '%';
                }
                field("Extension Version"; Rec."Extension Version")
                {
                    ToolTip = 'Specifies the value of the Extension Version field.', Comment = '%';
                }
                field("Extension Name"; Rec."Extension Name")
                {
                    ToolTip = 'Specifies the value of the Extension Name field.', Comment = '%';
                }
                field("Extension Publisher"; Rec."Extension Publisher")
                {
                    ToolTip = 'Specifies the value of the Extension Publisher field.', Comment = '%';
                }
                field("Source Language"; Rec."Source Language")
                {
                    ToolTip = 'Specifies the value of the Source Language field.', Comment = '%';
                }
                field("Target Language"; Rec."Target Language")
                {
                    ToolTip = 'Specifies the value of the Target Language field.', Comment = '%';
                }
            }
            part(TranslationElements; ADD_ExtTranslSetupSubform)
            {
                ApplicationArea = All;
                Enabled = true;
                SubPageLink = "Extension ID" = field("Extension ID"),
                              "Target Language" = field("Target Language");
                UpdatePropagation = SubPart;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                Image = Action;
                action("Copy to new target lang")
                {
                    ApplicationArea = All;
                    Caption = 'Copy to new target lang';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CopyExtTranslToNewTargLang: Report ADD_CopyExtTranslToNewTargLang;
                    begin
                        CopyExtTranslToNewTargLang.SetReqPageParams(Rec."Extension ID", Rec."Target Language");
                        CopyExtTranslToNewTargLang.Run();
                    end;
                }
                action("Download Imported")
                {
                    ApplicationArea = All;
                    Caption = 'Download Imported';
                    Image = Download;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                    begin
                        ExtTranslMgt.DownloadImported(Rec."Extension ID", Rec."Target Language");
                    end;
                }
                action("Download Translated")
                {
                    ApplicationArea = All;
                    Caption = 'Download Translated';
                    Image = Download;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                    begin
                        ExtTranslMgt.DownloadTranslated(Rec."Extension ID", Rec."Target Language");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.TranslationElements.Page.SetElemTargetCaptEditable(Rec."Source Language" <> Rec."Target Language");
    end;
}
