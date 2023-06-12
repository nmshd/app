import { AppRuntime } from "@nmshd/app-runtime";
import { NativeBootstrapper } from "./NativeBootstrapper";

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
