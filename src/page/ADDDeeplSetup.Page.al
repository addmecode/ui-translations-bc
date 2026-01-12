page 50104 ADDDeepLSetup
{
    ApplicationArea = All;
    Caption = 'DeepL Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = ADD_DeepLSetup;
    UsageCategory = Administration;

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
                field("API Key"; this.ApiKey)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'API Key';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the API Key.', Comment = '%';

                    trigger OnValidate()
                    begin
                        Rec.SetApiKey(this.ApiKey);
                    end;
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
        if Rec.IsApiKeySet() then
            this.ApiKey := '****';
    end;

    var
        [NonDebuggable]
        ApiKey: Text;
}
