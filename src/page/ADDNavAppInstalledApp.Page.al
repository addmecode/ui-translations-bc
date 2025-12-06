page 50103 ADD_NavAppInstalledApp
{
    ApplicationArea = All;
    Caption = 'Nav App Installed App List';
    Editable = false;
    PageType = List;
    SourceTable = "NAV App Installed App";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("App ID"; Rec."App ID")
                {
                    ToolTip = 'Specifies the value of the App ID field.', Comment = '%';
                }
                field("Package ID"; Rec."Package ID")
                {
                    ToolTip = 'Specifies the value of the Package ID field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Publisher; Rec.Publisher)
                {
                    ToolTip = 'Specifies the value of the Publisher field.', Comment = '%';
                }
                field("Version Major"; Rec."Version Major")
                {
                    ToolTip = 'Specifies the value of the Version Major fields.', Comment = '%';
                }
                field("Version Minor"; Rec."Version Minor")
                {
                    ToolTip = 'Specifies the value of the Version Minor fields.', Comment = '%';
                }
                field("Version Build"; Rec."Version Build")
                {
                    ToolTip = 'Specifies the value of the Version Build fields.', Comment = '%';
                }
                field("Version Revision"; Rec."Version Revision")
                {
                    ToolTip = 'Specifies the value of the Version Revision fields.', Comment = '%';
                }
                field("Compatibility Major"; Rec."Compatibility Major")
                {
                    ToolTip = 'Specifies the value of the Compatibility Major fields.', Comment = '%';
                }
                field("Compatibility Minor"; Rec."Compatibility Minor")
                {
                    ToolTip = 'Specifies the value of the Compatibility Minor fields.', Comment = '%';
                }
                field("Compatibility Build"; Rec."Compatibility Build")
                {
                    ToolTip = 'Specifies the value of the Compatibility Build fields.', Comment = '%';
                }
                field("Compatibility Revision"; Rec."Compatibility Revision")
                {
                    ToolTip = 'Specifies the value of the Compatibility Revision fields.', Comment = '%';
                }
                field("Published As"; Rec."Published As")
                {
                    ToolTip = 'Specifies the value of the Published As fields.', Comment = '%';
                }
            }
        }
    }
}
