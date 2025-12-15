table 50103 "ADD_DeepLSetup"
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
                if Rec."Base Url" <> '' then
                    WebRequestHelper.IsHttpUrl(Rec."Base Url");
            end;
        }
        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
            ExtendedDatatype = Masked;
            DataClassification = EndUserIdentifiableInformation;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
