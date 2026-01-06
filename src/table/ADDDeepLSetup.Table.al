table 50102 "ADD_DeepLSetup"
{
    Caption = 'DeepL Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "Base Url"; Text[250])
        {
            Caption = 'Base Url';
            ExtendedDatatype = URL;

            trigger OnValidate()
            var
                WebRequestHelper: Codeunit "Web Request Helper";
            begin
                if Rec."Base Url" <> '' then begin
                    Rec."Base Url" := CopyStr(Rec."Base Url".TrimEnd('/'), 1, MaxStrLen(Rec."Base Url"));
                    WebRequestHelper.IsHttpUrl(Rec."Base Url");
                end;
            end;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    internal procedure SetApiKey(NewApiKey: SecretText)
    var
        OverwriteApiKeyQst: Label 'The Api key is already set. Do you want to overwrite it?';
    begin
        if this.IsApiKeySet() and GuiAllowed() then
            if not Confirm(OverwriteApiKeyQst) then
                exit;

        if EncryptionEnabled() then
            IsolatedStorage.SetEncrypted(this.GetStorageKey(), NewApiKey, DataScope::Module)
        else
            IsolatedStorage.Set(this.GetStorageKey(), NewApiKey, DataScope::Module);
    end;

    internal procedure GetApiKey(): SecretText
    var
        ApiKey: SecretText;
    begin
        IsolatedStorage.Get(this.GetStorageKey(), DataScope::Module, ApiKey);
        exit(ApiKey);
    end;

    internal procedure IsApiKeySet(): Boolean
    begin
        exit(IsolatedStorage.Contains(this.GetStorageKey(), DataScope::Module));
    end;

    local procedure GetStorageKey(): Text
    begin
        exit('fcff6d29-3b98-4a92-9562-b80bab0d5d8d');
    end;
}
