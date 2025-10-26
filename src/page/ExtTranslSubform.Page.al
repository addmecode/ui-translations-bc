page 50102 "ADD_ExtTranslSubform"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Subform';
    Editable = true;
    PageType = ListPart;
    SourceTable = ADD_ExtTranslLine;
    InsertAllowed = false;
    DeleteAllowed = false;

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
                field("Element Name"; Rec."Element Name")
                {
                    ToolTip = 'Specifies the value of the Element Name field.', Comment = '%';
                }
                field("Element Type"; Rec."Element Type")
                {
                    ToolTip = 'Specifies the value of the Element Type field.', Comment = '%';
                }
                field(Source; Rec.GetSource())
                {
                    ToolTip = 'Specifies the value of the Source fields.', Comment = '%';
                    Editable = false;
                }
                field("Developer Note"; Rec.GetDeveloperNotes())
                {
                    ToolTip = 'Specifies the value of the Developer Note fields.', Comment = 'Where am i';
                }
                field(Target; Rec.GetTarget())
                {
                    ToolTip = 'Specifies the value of the Target fields.', Comment = '%';
                    Editable = false;
                }
                field("New Target"; NewTarget)
                {
                    ToolTip = 'Specifies the value of the New Target fields.', Comment = '%';
                    Editable = IsNewTargetEditable;
                    trigger OnValidate()
                    begin
                        Rec.SetNewTarget(NewTarget);
                    end;
                }
                field(Translated; Rec.Translated)
                {
                    ToolTip = 'Specifies the value of the Translated field.', Comment = 'Where am i';
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
            action("Show All")
            {
                ApplicationArea = All;
                Caption = 'Show All';
                Image = ClearFilter;
                trigger OnAction()
                begin
                    Rec.SetRange(Translated);
                end;
            }
            action("Show Translated")
            {
                ApplicationArea = All;
                Caption = 'Show Translated';
                Image = FilterLines;
                trigger OnAction()
                begin
                    Rec.SetRange(Translated, true);
                end;
            }
            action("Hide Translated")
            {
                ApplicationArea = All;
                Caption = 'Hide Translated';
                Image = FilterLines;
                trigger OnAction()
                begin
                    Rec.SetRange(Translated, false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NewTarget := Rec.GetNewTarget();
    end;

    procedure SetNewTargetEditable(IsEditable: Boolean)
    begin
        IsNewTargetEditable := IsEditable;
    end;

    var
        NewTarget: Text;
        IsNewTargetEditable: Boolean;
}
