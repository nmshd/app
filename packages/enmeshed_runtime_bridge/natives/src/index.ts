import {
  AppReadyEvent,
  INativePushNotification,
  RemoteNotificationEvent,
  RemoteNotificationRegistrationEvent
} from "@js-soft/native-abstractions";
import { AppRuntime } from "@nmshd/app-runtime";
import { buildInformation } from "@nmshd/runtime";
import { NativeBootstrapper } from "./NativeBootstrapper";
import { UIBridge } from "./uiBridge";

import * as contentLib from "@nmshd/content";

window.NMSHDContent = contentLib;

window.registerUIBridge = function () {
  window.runtime.registerUIBridge(new UIBridge());
};

window.setPushToken = async function (token: string) {
  const alreadySetToken = window.runtime.nativeEnvironment.configAccess.get("pushToken");
  if (alreadySetToken.value === token) return;

  window.runtime.nativeEnvironment.configAccess.set("pushToken", token);
  window.runtime.nativeEnvironment.eventBus.publish(new RemoteNotificationRegistrationEvent(token));
  await window.runtime.nativeEnvironment.configAccess.save();
};

window.triggerRemoteNotificationEvent = async function (notification: INativePushNotification) {
  window.runtime.nativeEnvironment.eventBus.publish(new RemoteNotificationEvent(notification));
};

window.triggerAppReadyEvent = async function () {
  window.runtime.nativeEnvironment.eventBus.publish(new AppReadyEvent());
};

window.runtimeVersion = buildInformation.version;

async function main() {
  const bootstrapper = new NativeBootstrapper();
  await bootstrapper.init();
  const runtime = await AppRuntime.createAndStart(bootstrapper);

  runtime.eventBus.subscribe("**", async (event) => {
    await window.flutter_inappwebview.callHandler("handleRuntimeEvent", event);
  });

  window.runtime = runtime;
}

main().then(() => window.flutter_inappwebview.callHandler("runtimeReady"));
