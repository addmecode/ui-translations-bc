page 50101 "ADD_ExtTranslSetupCard"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Card';
    PageType = Card;
    SourceTable = ADD_ExtTranslSetupHeader;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.TranslationElements.Page.SetElemTargetCaptEditable(Rec."Source Language" <> Rec."Target Language");
    end;
}
