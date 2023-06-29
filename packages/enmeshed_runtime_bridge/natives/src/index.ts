import {
  INativePushNotification,
  RemoteNotificationEvent,
  RemoteNotificationRegistrationEvent
} from "@js-soft/native-abstractions";
import { AppRuntime } from "@nmshd/app-runtime";
import { NativeBootstrapper } from "./NativeBootstrapper";
import { UIBridge } from "./uiBridge";

window.registerUIBridge = function () {
  window.runtime.registerUIBridge(new UIBridge());
};

window.setPushToken = async function (token: string) {
  window.runtime.nativeEnvironment.configAccess.set("pushToken", token);
  window.runtime.nativeEnvironment.eventBus.publish(new RemoteNotificationRegistrationEvent(token));
  window.runtime.nativeEnvironment.configAccess.save();
};

window.triggerRemoteNotificationEvent = async function (notification: INativePushNotification) {
  window.runtime.nativeEnvironment.eventBus.publish(new RemoteNotificationEvent(notification));
};

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
