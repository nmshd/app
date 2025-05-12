# Push Testing

## Android

Use your favorite REST client to send a POST request to `https://fcm.googleapis.com/fcm/send`.

Add the headers `Content-Type: application/json` and `Authorization: key=<server key>`.

The body of the request should be a JSON object with the following structure:

```json
{
  "to": "<FCM Token>",
  "data": {
    "android_channel_id": "ENMESHED",
    "content-available": "1",
    "content": {
      "accRef": "<account reference>",
      "eventName": "<DatawalletModificationsCreated or ExternalEventCreated>",
      "sentAt": "<current time>",
      "payload": {
        "someProperty": "someValue"
      }
    }
  },
  "notification": {
    "tag": 1,
    "title": "Neue Aktualisierungen",
    "body": "In der App sind neue Aktualisierungen verfügbar."
  }
}
```

## iOS

For ios you need to send the following payload to your device:

```json
{
  "notId": 1,
  "content": {
    "accRef": "<account reference>",
    "eventName": "<DatawalletModificationsCreated or ExternalEventCreated>",
    "sentAt": "<current time>",
    "payload": {
      "someProperty": "someValue"
    }
  },
  "aps": {
    "content-available": "1",
    "alert": {
      "title": "Neue Aktualisierungen",
      "body": "In der App sind neue Aktualisierungen verfügbar."
    }
  }
}
```

### Real Device

You can use https://apps.apple.com/de/app/apns-helper/id6443608175 to send test push notifications to your device. The app supports sandbox and production APNS.

### Simulator

Find your running simulator using `xcrun simctl list devices | grep Booted` and copy the device id from the output.

Create a file containing the push notification content (e.g. `push.json`):

Run `xcrun simctl push <device-id from step one OR booted> de.bildungsraum.ablage.experimental push.json`
