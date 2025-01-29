import { Serializable } from "@js-soft/ts-serval";
import { ApplicationError, Result } from "@js-soft/ts-utils";
import {
  AppConfigOverwrite,
  AppReadyEvent,
  AppRuntime,
  RemoteNotification,
  RemoteNotificationEvent,
  RemoteNotificationRegistrationEvent
} from "@nmshd/app-runtime";
import * as contentLib from "@nmshd/content";
import { RenderHints, RenderHintsJSON, ValueHints, ValueHintsJSON } from "@nmshd/content";
import { buildInformation } from "@nmshd/runtime";
import { NativeBootstrapper } from "./NativeBootstrapper";
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

window.setPushToken = async function (token: string) {
  const alreadySetToken = window.runtime.nativeEnvironment.configAccess.get("pushToken");
  if (alreadySetToken.value === token) return;

  window.runtime.nativeEnvironment.configAccess.set("pushToken", token);
  window.runtime.eventBus.publish(new RemoteNotificationRegistrationEvent(token));
  await window.runtime.nativeEnvironment.configAccess.save();
};

window.triggerRemoteNotificationEvent = async function (notification: RemoteNotification) {
  window.runtime.eventBus.publish(new RemoteNotificationEvent(notification));
};

window.triggerAppReadyEvent = async function () {
  window.runtime.eventBus.publish(new AppReadyEvent());
};

window.runtimeVersion = buildInformation.version;

async function main() {
  const config: AppConfigOverwrite = await window.flutter_inappwebview.callHandler("getRuntimeConfig");

  const bootstrapper = new NativeBootstrapper();
  await bootstrapper.init();
  const runtime = await AppRuntime.createAndStart(bootstrapper, config);

  const runtimeBridgeLogger = bootstrapper.loggerFactory.getLogger("RuntimeBridge");

  runtime.eventBus.subscribe("**", async (event) => {
    try {
      await window.flutter_inappwebview.callHandler("handleRuntimeEvent", event);
    } catch (error) {
      runtimeBridgeLogger.warn("Error while passing runtime event to app", error);
    }
  });

  window.runtime = runtime;
}

main().then(() => window.flutter_inappwebview.callHandler("runtimeReady"));
