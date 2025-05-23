import { ApplicationError, Result } from "@js-soft/ts-utils";
import { IUIBridge, LocalAccountDTO } from "@nmshd/app-runtime";
import {
  DeviceOnboardingInfoDTO,
  FileDVO,
  IdentityDVO,
  LocalRequestDVO,
  MailDVO,
  MessageDVO,
  RequestMessageDVO
} from "@nmshd/runtime";

export class UIBridge implements IUIBridge {
  public async showMessage(
    account: LocalAccountDTO,
    relationship: IdentityDVO,
    message: MessageDVO | MailDVO | RequestMessageDVO
  ): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler("uibridge_showMessage", account, relationship, message);
    return Result.ok(undefined);
  }

  public async showRelationship(account: LocalAccountDTO, relationship: IdentityDVO): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler("uibridge_showRelationship", account, relationship);
    return Result.ok(undefined);
  }

  public async showFile(account: LocalAccountDTO, file: FileDVO): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler("uibridge_showFile", account, file);
    return Result.ok(undefined);
  }

  public async showDeviceOnboarding(deviceOnboardingInfo: DeviceOnboardingInfoDTO): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler("uibridge_showDeviceOnboarding", deviceOnboardingInfo);
    return Result.ok(undefined);
  }

  public async showRequest(account: LocalAccountDTO, request: LocalRequestDVO): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler("uibridge_showRequest", account, request);
    return Result.ok(undefined);
  }

  public async showError(error: ApplicationError, account?: LocalAccountDTO | undefined): Promise<Result<void>> {
    await window.flutter_inappwebview.callHandler(
      "uibridge_showError",
      {
        code: error.code,
        message: error.message,
        data: error.data
      },
      account
    );
    return Result.ok(undefined);
  }

  public async requestAccountSelection(
    possibleAccounts: LocalAccountDTO[],
    title?: string | undefined,
    description?: string | undefined
  ): Promise<Result<LocalAccountDTO | undefined>> {
    const result: LocalAccountDTO | null = await window.flutter_inappwebview.callHandler(
      "uibridge_requestAccountSelection",
      possibleAccounts,
      title,
      description
    );

    return Result.ok(result ?? undefined);
  }

  public async enterPassword(
    passwordType: "pw" | "pin",
    pinLength?: number,
    attempt?: number,
    passwordLocationIndicator?: number
  ): Promise<Result<string>> {
    const result: string | null = await window.flutter_inappwebview.callHandler(
      "uibridge_enterPassword",
      passwordType,
      pinLength,
      attempt,
      passwordLocationIndicator
    );

    if (result === null) {
      return Result.fail(new ApplicationError("error.user.cancelled", "The user cancelled the operation."));
    }

    return Result.ok(result);
  }
}
