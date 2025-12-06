page 50100 ADD_ExtTranslList
{
    ApplicationArea = All;
    Caption = 'Extension Translations';
    CardPageId = ADD_ExtTranslCard;
    Editable = false;
    PageType = List;
    SourceTable = ADD_ExtTranslHeader;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Extension ID"; Rec."Extension ID")
                {
                    ToolTip = 'Specifies the value of the Extension ID field.', Comment = '%';
                }
                field("Target Language"; Rec."Target Language")
                {
                    ToolTip = 'Specifies the value of the Target Language field.', Comment = '%';
                }
                field("Source Language"; Rec."Source Language")
                {
                    ToolTip = 'Specifies the value of the Source Language field.', Comment = '%';
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
    actions
    {
        area(Promoted)
        {
            actionref(ImportXlfPromoted; ImportXlfAction) { }
        }
        area(Processing)
        {
            group(Xlf)
            {
                Caption = 'Xlf';
                Image = Import;
                action(ImportXlfAction)
                {
                    Caption = 'Import Xlf';
                    Ellipsis = true;
                    Image = Import;
                    RunObject = report ADD_ImportXlf;
                    ToolTip = 'Import Xlf';
                }
            }
        }
    }
}
