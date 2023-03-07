// window.flutter_inappwebview.callHandler('handlerFoo', 'fromJS')
//       .then(function(result) {
//         // print to the console the data coming
//         // from the Flutter side.
//         console.log(JSON.stringify(result));
//         window.flutter_inappwebview
//           .callHandler('handlerFooWithArgs', 1, true, ['bar', 5], {foo: 'baz'}, result);
//     });

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
