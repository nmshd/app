import { AppRuntime } from "@nmshd/app-runtime";
import { NativeBootstrapper } from "./NativeBootstrapper";
import { UIBridge } from "./uiBridge";

function registerUIBridge() {
  window.runtime.registerUIBridge(new UIBridge());
}

window.registerUIBridge = registerUIBridge;

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
