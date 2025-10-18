page 50102 "ADD_ExtTranslSubform"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = ADD_ElementTranslation;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.', Comment = '%';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.', Comment = '%';
                }
                field("Element Type"; Rec."Element Type")
                {
                    ToolTip = 'Specifies the value of the Element Type field.', Comment = '%';
                }
                field("Element Name"; Rec."Element Name")
                {
                    ToolTip = 'Specifies the value of the Element Name field.', Comment = '%';
                }
                field("Element Source Caption"; Rec."Element Source Caption")
                {
                    ToolTip = 'Specifies the value of the Element Source Caption field.', Comment = '%';
                }
            }
        }
    }
}
