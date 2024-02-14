import { INativePushNotification } from "@js-soft/native-abstractions";
import { Result } from "@js-soft/ts-utils";
import { AppRuntime } from "@nmshd/app-runtime";
import { RenderHintsJSON, ValueHintsJSON } from "@nmshd/content";

export {};
declare global {
  interface Window {
    runtime: AppRuntime;
    flutter_inappwebview: FlutterInAppWebView;
    registerUIBridge: () => void;
    setPushToken: (token: string) => Promise<void>;
    triggerRemoteNotificationEvent: (notification: INativePushNotification) => Promise<void>;
    triggerAppReadyEvent: () => Promise<void>;
    runtimeVersion: string;
    NMSHDContent: typeof import("@nmshd/content");
    getHints: (valueType: string) => Result<{ renderHints: RenderHintsJSON; valueHints: ValueHintsJSON }>;
  }
}

interface FlutterInAppWebView {
  callHandler(handlerName: string, ...args: any[]): Promise<any>;
}
