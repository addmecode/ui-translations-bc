page 50100 "ADD_ExtTranslSetupList"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Setups';
    CardPageID = ADD_ExtTranslSetupCard;
    Editable = false;
    PageType = List;
    SourceTable = ADD_ExtTranslSetupHeader;
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
        area(Processing)
        {
            group(Xlf)
            {
                Caption = 'Xlf';
                Image = Import;
                action("Import Xlf")
                {
                    ApplicationArea = All;
                    Caption = 'Import Xlf';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report ADD_ImportXlf;
                }
            }
        }
    }
}
