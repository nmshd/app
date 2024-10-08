import { Result } from "@js-soft/ts-utils";
import { AppRuntime, RemoteNotification } from "@nmshd/app-runtime";
import { RenderHintsJSON, ValueHintsJSON } from "@nmshd/content";

export {};
declare global {
  interface Window {
    runtime: AppRuntime;
    flutter_inappwebview: FlutterInAppWebView;
    registerUIBridge: () => void;
    setPushToken: (token: string) => Promise<void>;
    triggerRemoteNotificationEvent: (notification: RemoteNotification) => Promise<void>;
    triggerAppReadyEvent: () => Promise<void>;
    runtimeVersion: string;
    NMSHDContent: typeof import("@nmshd/content");
    getHints: (valueType: string) => Result<{ renderHints: RenderHintsJSON; valueHints: ValueHintsJSON }>;
  }
}

interface FlutterInAppWebView {
  callHandler(handlerName: string, ...args: any[]): Promise<any>;
}
