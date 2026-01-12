page 50100 "AMC Extension Transl List"
{
    ApplicationArea = All;
    Caption = 'Extension Translations';
    CardPageId = "AMC Extension Transl Card";
    Editable = false;
    PageType = List;
    SourceTable = "AMC Extension Transl Header";
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
                    RunObject = report "AMC Import Xlf";
                    ToolTip = 'Import Xlf';
                }
            }
        }
    }
}
