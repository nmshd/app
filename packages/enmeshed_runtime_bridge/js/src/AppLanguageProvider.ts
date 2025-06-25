import { ApplicationError, Result } from "@js-soft/ts-utils";
import { IAppLanguageProvider } from "@nmshd/app-runtime";
import { LanguageISO639 } from "@nmshd/core-types";

export class AppLanguageProvider implements IAppLanguageProvider {
  public async getAppLanguage(): Promise<Result<LanguageISO639>> {
    const language = await window.flutter_inappwebview.callHandler("getAppLanguage");
    if (typeof language !== "string" || !Object.keys(LanguageISO639).includes(language)) {
      return Result.fail(
        new ApplicationError(
          "error.appRuntimeBridge.invalidLanguageType",
          `Invalid language '${language}' received for getAppLanguage. Expected an ISO639 language.`
        )
      );
    }

    return Result.ok(language as LanguageISO639);
  }
}
