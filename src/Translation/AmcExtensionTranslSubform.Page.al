page 50102 "AMC Extension Transl Subform"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Subform';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "AMC Extension Transl Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
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
                    Caption = 'Source';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source fields.', Comment = '%';
                }
                field("Developer Note"; Rec.GetDeveloperNotes())
                {
                    Caption = 'Developer Note';
                    ToolTip = 'Specifies the value of the Developer Note fields.', Comment = '%';
                }
                field(Target; Rec.GetTarget())
                {
                    Caption = 'Target';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Target fields.', Comment = '%';
                }
                field("New Target"; NewTarget)
                {
                    Caption = 'New Target';
                    Editable = IsNewTargetEditable;
                    ToolTip = 'Specifies the value of the New Target fields.', Comment = '%';
                    trigger OnValidate()
                    begin
                        Rec.SetNewTarget(NewTarget);
                    end;
                }
                field(Translated; Rec.Translated)
                {
                    ToolTip = 'Specifies the value of the Translated field.', Comment = '%';
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
                Caption = 'Run Object';
                Image = Process;
                ToolTip = 'Run Object';
                trigger OnAction()
                begin
                    Rec.RunObject();
                end;
            }
            action("Show All")
            {
                Caption = 'Show All';
                Image = ClearFilter;
                ToolTip = 'Show All';
                trigger OnAction()
                begin
                    Rec.SetRange(Translated);
                end;
            }
            action("Show Translated")
            {
                Caption = 'Show Translated';
                Image = FilterLines;
                ToolTip = 'Show Translated';
                trigger OnAction()
                begin
                    Rec.SetRange(Translated, true);
                end;
            }
            action("Hide Translated")
            {
                Caption = 'Hide Translated';
                Image = FilterLines;
                ToolTip = 'Hide Translated';
                trigger OnAction()
                begin
                    Rec.SetRange(Translated, false);
                end;
            }
            action("Translate Source Using Api")
            {
                Caption = 'Translate Source Using Api';
                Image = Web;
                ToolTip = 'Translate Source Using Api';
                trigger OnAction()
                var
                    ExtTranslLine: Record "AMC Extension Transl Line";
                    ExtTranslMgt: Codeunit "AMC Extension Transl Mgt";
                begin
                    CurrPage.SetSelectionFilter(ExtTranslLine);
                    ExtTranslMgt.TranslateElemSrcsUsingDeepL(ExtTranslLine);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        NewTarget := Rec.GetNewTarget();
    end;

    var
        IsNewTargetEditable: Boolean;
        NewTarget: Text;

    procedure SetNewTargetEditable(IsEditable: Boolean)
    begin
        IsNewTargetEditable := IsEditable;
    end;
}
