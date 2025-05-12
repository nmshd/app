# Deep Link Testing

## Android Devices

To test on Android devices or emulators, use Android Debug Bridge (ADB) to simulate opening the app with a custom URL scheme:

```bash
adb shell am start -a android.intent.action.VIEW -d "nmshd://tr#{reference}"
adb shell am start -a android.intent.action.VIEW -d "enmeshed://tr#{reference}"
adb shell am start -a android.intent.action.VIEW -d "https://pilot.enmeshed.eu/r/{id}#{reference}"
```

## iOS Simulator

For testing on the iOS simulator, use the `simctl` command-line tool:

```bash
xcrun simctl openurl booted "nmshd://tr#{reference}"
xcrun simctl openurl booted "enmeshed://tr#{reference}"
xcrun simctl openurl booted "https://pilot.enmeshed.eu/r/{id}#{reference}"
```
