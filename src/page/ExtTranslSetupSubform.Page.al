page 50102 "ADD_ExtTranslSetupSubform"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Setup Subform';
    Editable = false;
    PageType = ListPart;
    SourceTable = ADD_ExtTranslSetupLine;

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
    actions
    {
        area(Processing)
        {
            group("Run")
            {
                Caption = 'Run';
                Image = Process;
                action("Run Object")
                {
                    ApplicationArea = All;
                    Caption = 'Run Object';
                    Image = Process;
                    trigger OnAction()
                    var
                        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                    begin
                        ExtTranslMgt.RunObject(Rec);
                    end;
                }
            }
        }
    }
}
