page 50101 "ADD_ExtTranslCard"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Card';
    PageType = Card;
    SourceTable = ADD_ExtTranslHeader;
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
            part(TranslationElements; ADD_ExtTranslSubform)
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
        area(Promoted)
        {
            actionref(CopyPromoted; CopyAction)
            { }
            actionref(DownloadImportedPromoted; DownloadImportedAction)
            { }
            actionref(DownloadTranslatedPromoted; DownloadTranslatedAction)
            { }
        }
        area(Processing)
        {
            group(Process)
            {
                Caption = 'Process';
                Image = Action;
                action(CopyAction)
                {
                    ApplicationArea = All;
                    Caption = 'Copy';
                    ToolTip = 'Copy';
                    Ellipsis = true;
                    Image = Copy;

                    trigger OnAction()
                    var
                        CopyExtTranslToNewTargLang: Report ADD_CopyExtTranslToNewTargLang;
                    begin
                        CopyExtTranslToNewTargLang.SetReqPageParams(Rec."Extension ID", Rec."Target Language");
                        CopyExtTranslToNewTargLang.Run();
                    end;
                }
                action(DownloadImportedAction)
                {
                    ApplicationArea = All;
                    Caption = 'Download Imported';
                    ToolTip = 'Download Imported';
                    Image = Download;

                    trigger OnAction()
                    begin
                        Rec.DownloadImported();
                    end;
                }
                action(DownloadTranslatedAction)
                {
                    ApplicationArea = All;
                    Caption = 'Download Translated';
                    ToolTip = 'Download Translated';
                    Image = Download;

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
