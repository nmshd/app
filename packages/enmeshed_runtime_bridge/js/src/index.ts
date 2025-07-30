import { ILogger } from "@js-soft/logging-abstractions";
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
  const config: AppConfigOverwrite & { databaseBaseFolder: string } =
    await window.flutter_inappwebview.callHandler("getRuntimeConfig");

  const databaseBaseFolder = config.databaseBaseFolder;

  const loggerFactory = new SimpleLoggerFactory(LogLevel.Info);
  const fileAccess = new FileAccess();
  const notificationAccess = new NotificationAccess(loggerFactory);
  const languageProvider = new AppLanguageProvider();
  const runtimeBridgeLogger = loggerFactory.getLogger("RuntimeBridge");

  config.databaseFolder = buildDatabaseFolder(config.databaseBaseFolder, runtimeBridgeLogger);

  const runtime = await AppRuntime.create(
    config,
    loggerFactory,
    notificationAccess,
    languageProvider,
    undefined,
    new DatabaseFactory(fileAccess)
  );
  await runtime.start();

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

function buildDatabaseFolder(baseFolder: string, logger: ILogger): string {
  const semverWithPreidRegex = /^(\d+)\.\d+\.\d+(?:-([a-z]+)(?:\.\d+)+)?$/;
  const semverMatches = semverWithPreidRegex.exec(buildInformation.version);
  if (!semverMatches) {
    logger.warn("Could not parse version for database folder", buildInformation.version);
    return baseFolder;
  }

  const majorVersion = semverMatches[1];
  if (parseInt(majorVersion) < 7) {
    logger.warn(
      `Using legacy database folder structure for versions < 7. Detected major version '${majorVersion}' in version '${buildInformation.version}'.`
    );
    return baseFolder;
  }

  if (semverMatches[2]) return `${baseFolder}/${buildInformation.version}`;

  return `${baseFolder}/afterV7`;
}

main()
  .then(() => window.flutter_inappwebview.callHandler("runtimeReady"))
  .catch((e) => {
    console.log("Runtime init failed", e);
    window.flutter_inappwebview.callHandler("runtimeInitFailed", e.message);
  });
