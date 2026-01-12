page 50101 "AMC Extension Transl Card"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Card';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "AMC Extension Transl Header";

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
            part(TranslationElements; "AMC Extension Transl Subform")
            {
                Enabled = true;
                SubPageLink = "Extension ID" = field("Extension ID"),
                              "Target Language" = field("Target Language");
                UpdatePropagation = SubPart;
            }
        }
    }
    actions
    {
        area(Promoted)
        {
            actionref(CopyPromoted; CopyAction) { }
            actionref(DownloadImportedPromoted; DownloadImportedAction) { }
            actionref(DownloadTranslatedPromoted; DownloadTranslatedAction) { }
        }
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                Image = Action;
                action(CopyAction)
                {
                    Caption = 'Copy';
                    Ellipsis = true;
                    Image = Copy;
                    ToolTip = 'Copy';

                    trigger OnAction()
                    var
                        CopyExtTranslToNewTargLang: Report "AMC Copy Ext Transl To Lang";
                    begin
                        CopyExtTranslToNewTargLang.SetReqPageParams(Rec."Extension ID", Rec."Target Language");
                        CopyExtTranslToNewTargLang.Run();
                    end;
                }
                action(DownloadImportedAction)
                {
                    Caption = 'Download Imported';
                    Image = Download;
                    ToolTip = 'Download Imported';

                    trigger OnAction()
                    begin
                        Rec.DownloadImported();
                    end;
                }
                action(DownloadTranslatedAction)
                {
                    Caption = 'Download Translated';
                    Image = Download;
                    ToolTip = 'Download Translated';

                    trigger OnAction()
                    begin
                        Rec.DownloadTranslated();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.TranslationElements.Page.SetNewTargetEditable(Rec."Source Language" <> Rec."Target Language");
    end;
}
