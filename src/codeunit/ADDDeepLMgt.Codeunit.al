codeunit 50111 "ADD_DeepLMgt"
{
    internal procedure Translate(TextToTranslate: Text; TargetLang: Text): Text
    var
        BodyText: Text;
        Response: HttpResponseMessage;
    begin
        BodyText := this.CreateDeepLBody(TextToTranslate, TargetLang);
        this.PostDeepL(Response, BodyText);
        exit(this.GetTranslatedTextFromDeepLResponse(Response));
    end;

    local procedure CreateDeepLBody(TextToTranslate: Text; TargetLang: Text): Text
    var
        BodyJson: JsonObject;
        TextArray: JsonArray;
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
        Url: Text;
        PostErr: Label 'DeepL error (%1 %2): %3', Comment = '%1 is Response Http Status Code, %2 is Response Reason Phrase, %3 is Response body';
        ApiKeyPrefixTxt: Label 'DeepL-Auth-Key %1', Locked = true;
    begin
        DeepLSetup.Get();
        Url := DeepLSetup."Base Url" + '/translate';

        Content.GetHeaders(ContentHeaders);
        Content.WriteFrom(BodyText);
        ContentHeaders.Remove('Content-Type');
        ContentHeaders.Add('Content-Type', 'application/json');
        Client.Clear();
        Client.DefaultRequestHeaders().Add('Authorization', StrSubstNo(ApiKeyPrefixTxt, DeepLSetup."API Key"));
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');
        Client.Post(Url, Content, Response);

        if not Response.IsSuccessStatusCode() then begin
            Response.Content.ReadAs(BodyText);
            Error(PostErr, Response.HttpStatusCode, Response.ReasonPhrase, BodyText);
        end;
    end;

    local procedure GetTranslatedTextFromDeepLResponse(var Response: HttpResponseMessage): Text
    var
        ResponseJson: JsonObject;
        TranslationsToken: JsonToken;
        TranslToken: JsonToken;
        TranslationsArray: JsonArray;
        TranslationObj: JsonObject;
        TextToken: JsonToken;
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
    begin
        exit(LangTag.Split('-').Get(1));
    end;
}
