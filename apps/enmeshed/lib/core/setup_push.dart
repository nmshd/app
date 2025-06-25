import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:push/push.dart';

Future<void> setupPush(EnmeshedRuntime runtime) async {
  if (Platform.isWindows) return;

  final logger = GetIt.I.get<Logger>();

  Push.instance.addOnNewToken((token) async {
    logger.d('New push token received: $token');
    await runtime.triggerRemoteNotificationRegistrationEvent(token);
  });

  // Handle notification launching app from terminated state
  await Push.instance.notificationTapWhichLaunchedAppFromTerminated.then((data) {
    if (data == null) {
      logger.i('App was not launched by tapping a notification');
    } else {
      logger.i('Notification tap launched app from terminated state:\nRemoteMessage: $data \n');
    }
  });

  Push.instance.addOnNotificationTap((data) {
    logger.i('Notification was tapped:\nData: $data');

    final content = extractContentFromMessageData(data);
    if (content == null) return;
    runtime.triggerRemoteNotificationEvent(content: content);
  });

  Push.instance.addOnMessage((message) {
    message.debugLog('foreground');
    triggerRemoteNotificationEvent(runtime, message);
  });

  Push.instance.addOnBackgroundMessage((message) {
    message.debugLog('background');
    triggerRemoteNotificationEvent(runtime, message);
  });
}

Future<void> triggerRemoteNotificationEvent(EnmeshedRuntime runtime, RemoteMessage message) async {
  final content = extractContentFromMessageData(message.data);
  if (content == null) return;

  await runtime.triggerRemoteNotificationEvent(content: content);
}

Map<String, dynamic>? extractContentFromMessageData(Map<String?, Object?>? data) {
  if (data == null) return null;

  final content = data['content'];

  if (Platform.isAndroid) {
    if (content is String) return Map<String, dynamic>.from(jsonDecode(content) as Map<dynamic, dynamic>);
    if (content is Map) return Map<String, dynamic>.from(data['content']! as Map);
    return null;
  } else if (Platform.isIOS) {
    if (content is! Map) return null;

    return Map<String, dynamic>.from(data['content']! as Map);
  }

  GetIt.I.get<Logger>().e('Received a remote message from a not supported platform.');
  return null;
}

extension RemoteMessageExtension on RemoteMessage {
  void debugLog(String type) {
    if (!kDebugMode) return;

    GetIt.I.get<Logger>().d(generateDebungLog(type));
  }

  String generateDebungLog(String type) {
    var log = 'RemoteMessage received while app is in $type:';

    if (notification?.title != null) log += '\n  title: ${notification!.title}';
    if (notification?.body != null) log += '\n  body: ${notification!.body}';

    return log += '\ndata: $data';
  }
}
