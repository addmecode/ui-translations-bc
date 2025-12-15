page 50104 ADDDeepLSetup
{
    ApplicationArea = All;
    Caption = 'DeepL Setup';
    PageType = Card;
    SourceTable = ADD_DeepLSetup;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Base Url"; Rec."Base Url")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Base Url field.', Comment = '%';
                }
                field("API Key"; Rec."API Key")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the API Key field.', Comment = '%';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
