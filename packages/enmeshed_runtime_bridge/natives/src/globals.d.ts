import { INativePushNotification } from "@js-soft/native-abstractions";
import { AppRuntime } from "@nmshd/app-runtime";

export {};
declare global {
  interface Window {
    runtime: AppRuntime;
    flutter_inappwebview: FlutterInAppWebView;
    registerUIBridge: () => void;
    setPushToken: (token: string) => Promise<void>;
    triggerRemoteNotificationEvent: (notification: INativePushNotification) => Promise<void>;
    triggerAppReadyEvent: () => Promise<void>;
  }
}

interface FlutterInAppWebView {
  callHandler(handlerName: string, ...args: any[]): Promise<any>;
}
