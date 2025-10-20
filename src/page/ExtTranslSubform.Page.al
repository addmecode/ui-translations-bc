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
                field("Element Source Caption"; Rec.GetElementSourceCaptions())
                {
                    ToolTip = 'Specifies the value of the Element Source Caption fields.', Comment = '%';
                }
                field("Developer Note"; Rec.GetDeveloperNotes())
                {
                    ToolTip = 'Specifies the value of the Developer Note fields.', Comment = 'Where am i';
                }
                field("Trans Unit ID"; Rec."Trans Unit ID")
                {
                    ToolTip = 'Specifies the value of the Trans Unit ID field.', Comment = 'Where am i';
                }
                field("Xliff Note"; Rec.GetXliffNotes())
                {
                    ToolTip = 'Specifies the value of the Xliff Note fields.', Comment = 'Where am i';
                }
            }
        }
    }
}
