page 50100 "ADD_ExtensionTranslationList"
{
    ApplicationArea = All;
    Caption = 'Extension Translations';
    CardPageID = ADD_ExtensionTranslationCard;
    Editable = false;
    PageType = List;
    SourceTable = ADD_ExtensionTranslation;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
            }
        }
    }
    var
        c: Record Customer;
        a: record "NAV App Installed App";
        s: page "Sales Invoice";
}
