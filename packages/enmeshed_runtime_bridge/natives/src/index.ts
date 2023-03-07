import { AppRuntime } from "@nmshd/app-runtime";
import { Realm } from "@nmshd/transport";
import { NativeBootstrapper } from "./NativeBootstrapper";

const initAccount = async (runtime: AppRuntime) => {
  const accounts = await runtime.accountServices.getAccounts();
  if (accounts.length > 0) {
    console.log(`found accounts: ${accounts.map((a) => a.id).join(", ")}`);
    await runtime.selectAccount(accounts[0].id, "");
    return;
  }

  console.log("no accounts found, creating new one");
  const randomString = () => {
    return Math.random().toString(36).substring(2, 15);
  };
  const account = await runtime.accountServices.createAccount(
    Realm.Prod,
    randomString()
  );
  await runtime.selectAccount(account.id, "");
  console.log("logged in as: " + account.id);
};

async function main() {
  const bootstrapper = new NativeBootstrapper();
  await bootstrapper.init();
  const runtime = await AppRuntime.createAndStart(bootstrapper);

  window.runtime = runtime;

  await initAccount(runtime);
}

main().then(() => window.flutter_inappwebview.callHandler("runtimeReady"));
