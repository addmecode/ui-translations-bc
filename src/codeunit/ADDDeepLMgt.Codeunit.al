codeunit 50101 "ADD_DeepLMgt"
{
    internal procedure Translate(TextToTranslate: Text; TargetLang: Text): Text
    var
        Response: HttpResponseMessage;
        BodyText: Text;
    begin
        BodyText := this.CreateDeepLBody(TextToTranslate, TargetLang);
        this.PostDeepL(Response, BodyText);
        exit(this.GetTranslatedTextFromDeepLResponse(Response));
    end;

    local procedure CreateDeepLBody(TextToTranslate: Text; TargetLang: Text): Text
    var
        TextArray: JsonArray;
        BodyJson: JsonObject;
        BodyText: Text;
    begin
        TextArray.Add(TextToTranslate);
        BodyJson.Add('text', TextArray);
        BodyJson.Add('target_lang', TargetLang);
        BodyJson.WriteTo(BodyText);
        exit(BodyText);
    end;

    local procedure PostDeepL(var Response: HttpResponseMessage; BodyText: Text)
    var
        DeepLSetup: Record ADD_DeepLSetup;
        Client: HttpClient;
        Content: HttpContent;
        ContentHeaders: HttpHeaders;
        ApiKeyPrefixTxt: Label 'DeepL-Auth-Key %1', Locked = true;
        DeepLSetupNotFoundErr: Label 'DeepL Setup is not configured. Open the DeepL Setup page and enter the API key and base URL.';
        PostErr: Label 'DeepL error (%1 %2): %3', Comment = '%1 is Response Http Status Code, %2 is Response Reason Phrase, %3 is Response body';
        Url: Text;
    begin
        if not DeepLSetup.Get() then
            Error(DeepLSetupNotFoundErr);
        Url := DeepLSetup."Base Url" + '/translate';

        Content.GetHeaders(ContentHeaders);
        Content.WriteFrom(BodyText);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        Client.Clear();
        Client.DefaultRequestHeaders().Add('Authorization', SecretStrSubstNo(ApiKeyPrefixTxt, DeepLSetup.GetApiKey()));
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        Client.Post(Url, Content, Response);

        if not Response.IsSuccessStatusCode() then begin
            Response.Content.ReadAs(BodyText);
            Error(PostErr, Response.HttpStatusCode, Response.ReasonPhrase, BodyText);
        end;
    end;

    local procedure GetTranslatedTextFromDeepLResponse(var Response: HttpResponseMessage): Text
    var
        TranslationsArray: JsonArray;
        ResponseJson: JsonObject;
        TranslationObj: JsonObject;
        TextToken: JsonToken;
        TranslationsToken: JsonToken;
        TranslToken: JsonToken;
        BodyText: Text;
    begin
        Response.Content.ReadAs(BodyText);
        ResponseJson.ReadFrom(BodyText);
        ResponseJson.Get('translations', TranslationsToken);
        TranslationsArray := TranslationsToken.AsArray();
        TranslationsArray.Get(0, TranslToken);
        TranslationObj := TranslToken.AsObject();
        TranslationObj.Get('text', TextToken);
        exit(TextToken.AsValue().AsText());
    end;

    internal procedure GetDeepLLangFromLangTag(LangTag: Text[80]): Text
    var
        WindLang: Record "Windows Language";
        Lang: Codeunit Language;
        LanguageTagNotFoundErr: Label 'Language tag %1 is not defined in Windows Languages.', Comment = '%1 is the language tag';
    begin
        WindLang.SetRange("Language Tag", LangTag);
        WindLang.SetLoadFields("Language ID");
        if not WindLang.FindFirst() then
            Error(LanguageTagNotFoundErr, LangTag);
        exit(Lang.GetTwoLetterISOLanguageName(WindLang."Language ID"));
    end;
}
