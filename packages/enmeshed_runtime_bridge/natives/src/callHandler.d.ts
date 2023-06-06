import { AppRuntime } from "@nmshd/app-runtime";

export {};
declare global {
  interface Window {
    runtime: AppRuntime;
    flutter_inappwebview: FlutterInAppWebView;
  }
}

interface FlutterInAppWebView {
  callHandler(handlerName: string, ...args: any[]): Promise<any>;
}
