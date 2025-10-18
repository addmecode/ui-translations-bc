page 50101 "ADD_ExtensionTranslationCard"
{
    ApplicationArea = All;
    Caption = 'Extension Translation Card';
    PageType = Card;
    SourceTable = ADD_ExtensionTranslation;

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
            }
            part(TranslationElements; ADD_ExtTranslSubform)
            {
                ApplicationArea = All;
                Enabled = true;
                SubPageLink = "Extension ID" = field("Extension ID"),
                              "Extension Version" = field("Extension Version");
                UpdatePropagation = SubPart;
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
                    trigger OnAction()
                    var
                        ExtTranslMgt: Codeunit ADD_ExtensionTranslationMgt;
                    begin
                        ExtTranslMgt.ImportXlf(Rec);
                    end;
                }
            }
        }
    }
}
