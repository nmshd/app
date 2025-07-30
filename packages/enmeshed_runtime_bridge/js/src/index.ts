import { SimpleLoggerFactory } from "@js-soft/simple-logger";
import { Serializable } from "@js-soft/ts-serval";
import { ApplicationError, Result } from "@js-soft/ts-utils";
import {
  AppConfigOverwrite,
  AppLanguageChangedEvent,
  AppRuntime,
  RemoteNotification,
  RemoteNotificationEvent,
  RemoteNotificationRegistrationEvent
} from "@nmshd/app-runtime";
import * as contentLib from "@nmshd/content";
import { RenderHints, RenderHintsJSON, ValueHints, ValueHintsJSON } from "@nmshd/content";
import { LanguageISO639 } from "@nmshd/core-types";
import { buildInformation } from "@nmshd/runtime";
import { LogLevel } from "typescript-logging";
import { AppLanguageProvider } from "./AppLanguageProvider";
import { DatabaseFactory } from "./DatabaseFactory";
import { FileAccess } from "./FileAccess";
import { NotificationAccess } from "./NotificationAccess";
import { UIBridge } from "./uiBridge";

window.NMSHDContent = contentLib;

window.getHints = function (valueType: string): Result<{ renderHints: RenderHintsJSON; valueHints: ValueHintsJSON }> {
  const valueTypeClass = Serializable.getModule(valueType, 1);
  if (valueTypeClass === undefined) {
    return Result.fail(new ApplicationError("error.app.valueTypeNotFound", "The given value type was not found."));
  }

  const valueHints = valueTypeClass.valueHints as ValueHints | undefined;
  const renderHints = valueTypeClass.renderHints as RenderHints | undefined;

  if (valueHints === undefined || renderHints === undefined) {
    return Result.fail(new ApplicationError("error.app.hintsNotFound", "The given value type has no hints."));
  }

  return Result.ok({
    renderHints: renderHints.toJSON(),
    valueHints: valueHints.toJSON()
  });
};

window.registerUIBridge = function () {
  window.runtime.registerUIBridge(new UIBridge());
};

window.triggerRemoteNotificationRegistrationEvent = function (token: string) {
  window.runtime.eventBus.publish(new RemoteNotificationRegistrationEvent(token));
};

window.triggerRemoteNotificationEvent = function (notification: RemoteNotification) {
  window.runtime.eventBus.publish(new RemoteNotificationEvent(notification));
};

window.runtimeVersion = buildInformation.version;

async function main() {
  const config: AppConfigOverwrite = await window.flutter_inappwebview.callHandler("getRuntimeConfig");

  const loggerFactory = new SimpleLoggerFactory(LogLevel.Info);
  const fileAccess = new FileAccess();
  const notificationAccess = new NotificationAccess(loggerFactory);
  const languageProvider = new AppLanguageProvider();

  if (config.databaseFolder && buildInformation.version.includes("7.0.0-alpha.")) {
    config.databaseFolder = `${config.databaseFolder}/${buildInformation.version}`;
  }

  const runtime = await AppRuntime.create(
    config,
    loggerFactory,
    notificationAccess,
    languageProvider,
    undefined,
    new DatabaseFactory(fileAccess)
  );
  await runtime.start();

  const runtimeBridgeLogger = loggerFactory.getLogger("RuntimeBridge");
  runtime.eventBus.subscribe("**", async (event) => {
    try {
      await window.flutter_inappwebview.callHandler("handleRuntimeEvent", event);
    } catch (error) {
      runtimeBridgeLogger.warn("Error while passing runtime event to app", error);
    }
  });

  window.runtime = runtime;

  window.triggerAppLanguageChangedEvent = function (language: unknown) {
    runtimeBridgeLogger.error(language);
    if (typeof language !== "string" || !Object.keys(LanguageISO639).includes(language)) {
      runtimeBridgeLogger.warn("Invalid language type received for triggerAppLanguageChangedEvent", language);
      return;
    }

    window.runtime.eventBus.publish(new AppLanguageChangedEvent(language as LanguageISO639));
  };
}

main()
  .then(() => window.flutter_inappwebview.callHandler("runtimeReady"))
  .catch((e) => {
    console.log("Runtime init failed", e);
    window.flutter_inappwebview.callHandler("runtimeInitFailed", e.message);
  });
