import { join } from "path"
import config from "./wdio.shared.local.appium.conf"

// ============
// Specs
// ============
config.specs = [join(process.cwd(), "e2e-test/tests/specs/flutter.spec.ts")]

// ============
// Capabilities
// ============
// For all capabilities please check
// http://appium.io/docs/en/writing-running-appium/caps/#general-capabilities
config.capabilities = [
  {
    // The defaults you need to have in your config
    platformName: "Android",
    maxInstances: 1,
    // For W3C the appium capabilities need to have an extension prefix
    // http://appium.io/docs/en/writing-running-appium/caps/
    // This is `appium:` for all Appium Capabilities which can be found here
    "appium:deviceName": "nexus",
    "appium:autoGrantPermissions": true, //> cam + mic
    "appium:automationName": "Flutter",
    // The path to the app
    "appium:app": join(process.cwd(), "../packages/enmeshed_runtime_bridge/example/build/app/outputs/apk/debug/app-debug.apk")
    //> keep FTR for now
    // "appium:platformVersion": "13",
    // "appium:noReset": false,
    // "appium:fullReset": true,
    // "appium:appWaitActivity": "com.example.runtime_bridge_example.MainActivity",
    // "appium:newCommandTimeout": 240
  }
]

exports.config = config
