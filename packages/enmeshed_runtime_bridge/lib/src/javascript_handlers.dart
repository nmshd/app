import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

import 'event_bus.dart';
import 'events/events.dart';
import 'filesystem_adapter.dart';
import 'ui_bridge.dart';

Future<dynamic> handleRuntimeEventCallback(List<dynamic> args, EventBus eventBus, Logger logger) async {
  final payload = args[0];

  final eventTargetAddress = payload['eventTargetAddress'] as String;

  final namespace = payload['namespace'];
  if (namespace is! String) {
    logger.i('Unknown event namespace: ${payload['namespace']}');
    return;
  }

  final data = payload['data'] as Map<String, dynamic>?;
  if (data == null) {
    final event = switch (namespace) {
      'app.datawalletSynchronized' => DatawalletSynchronizedEvent(eventTargetAddress: eventTargetAddress),
      _ => ArbitraryEvent(namespace: namespace, eventTargetAddress: eventTargetAddress, data: {}),
    };

    eventBus.publish(event);

    return;
  }

  final event = switch (namespace) {
    'transport.messageSent' => MessageSentEvent(eventTargetAddress: eventTargetAddress, data: MessageDTO.fromJson(data)),
    'transport.messageReceived' => MessageReceivedEvent(eventTargetAddress: eventTargetAddress, data: MessageDTO.fromJson(data)),
    'transport.relationshipChanged' => RelationshipChangedEvent(eventTargetAddress: eventTargetAddress, data: RelationshipDTO.fromJson(data)),
    'transport.messageWasReadAtChanged' => MessageWasReadAtChangedEvent(eventTargetAddress: eventTargetAddress, data: MessageDTO.fromJson(data)),
    'consumption.attributeCreated' => AttributeCreatedEvent(eventTargetAddress: eventTargetAddress, data: LocalAttributeDTO.fromJson(data)),
    'consumption.outgoingRequestCreated' => OutgoingRequestCreatedEvent(
        eventTargetAddress: eventTargetAddress,
        data: LocalRequestDTO.fromJson(data),
      ),
    'consumption.incomingRequestReceived' => IncomingRequestReceivedEvent(
        eventTargetAddress: eventTargetAddress,
        data: LocalRequestDTO.fromJson(data),
      ),
    'consumption.incomingRequestStatusChanged' => IncomingRequestStatusChangedEvent(
        eventTargetAddress: eventTargetAddress,
        request: LocalRequestDTO.fromJson(data['request']),
        oldStatus: LocalRequestStatus.values.byName(data['oldStatus']),
        newStatus: LocalRequestStatus.values.byName(data['newStatus']),
      ),
    'consumption.outgoingRequestStatusChanged' => OutgoingRequestStatusChangedEvent(
        eventTargetAddress: eventTargetAddress,
        request: LocalRequestDTO.fromJson(data['request']),
        oldStatus: LocalRequestStatus.values.byName(data['oldStatus']),
        newStatus: LocalRequestStatus.values.byName(data['newStatus']),
      ),
    'app.externalEventReceived' => ExternalEventReceivedEvent(
        eventTargetAddress: eventTargetAddress,
        messages: List<MessageDTO>.from((data['messages'] as List<dynamic>).map((e) => MessageDTO.fromJson(e))),
        relationships: List<RelationshipDTO>.from((data['relationships'] as List<dynamic>).map((e) => RelationshipDTO.fromJson(e))),
      ),
    'runtime.accountSelected' => AccountSelectedEvent(
        eventTargetAddress: eventTargetAddress,
        localAccountId: data['localAccountId'] as String,
        address: data['address'] as String,
      ),
    _ => ArbitraryEvent(namespace: namespace, eventTargetAddress: eventTargetAddress, data: data),
  };

  eventBus.publish(event);
}

extension DeviceInfo on InAppWebViewController {
  void addDeviceInfoJavaScriptHandler() => addJavaScriptHandler(handlerName: 'getDeviceInfo', callback: _getDeviceInfo);
}

Future<Map<String, dynamic>> _getDeviceInfo(List<dynamic> args) async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final deviceInfo = await deviceInfoPlugin.androidInfo;

    return {
      'model': deviceInfo.model,
      'platform': 'Android',
      'uuid': deviceInfo.id,
      'manufacturer': deviceInfo.manufacturer,
      'isVirtual': !deviceInfo.isPhysicalDevice,
      'languageCode': Platform.localeName,
      'version': deviceInfo.version.release,
      'pushService': 'fcm',
    };
  }

  if (Platform.isIOS) {
    final deviceInfo = await deviceInfoPlugin.iosInfo;

    return {
      'model': deviceInfo.model,
      'platform': 'IOS',
      'uuid': deviceInfo.identifierForVendor ?? '',
      'manufacturer': 'Apple',
      'isVirtual': !deviceInfo.isPhysicalDevice,
      'languageCode': Platform.localeName,
      'version': deviceInfo.systemVersion,
      'pushService': 'apns',
    };
  }

  throw Exception('Unsupported platform');
}

class JsToUIBridge {
  late final InAppWebViewController _controller;
  set controller(InAppWebViewController controller) => _controller = controller;

  bool _isRegistered = false;
  bool get isRegistered => _isRegistered;

  JsToUIBridge();

  void register(UIBridge uiBridge) {
    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showMessage',
      callback: (args) async {
        final messageJson = args[2] as Map<String, dynamic>;
        final message = switch (messageJson['type']) {
          'MessageDVO' => MessageDVO.fromJson(messageJson),
          'MailDVO' => MailDVO.fromJson(messageJson),
          'RequestMessageDVO' => RequestMessageDVO.fromJson(messageJson),
          _ => throw Exception('Unknown message type: ${messageJson['type']}'),
        };

        await uiBridge.showMessage(LocalAccountDTO.fromJson(args[0]), IdentityDVO.fromJson(args[1]), message);
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showRelationship',
      callback: (args) async {
        await uiBridge.showRelationship(LocalAccountDTO.fromJson(args[0]), IdentityDVO.fromJson(args[1]));
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showFile',
      callback: (args) async {
        await uiBridge.showFile(LocalAccountDTO.fromJson(args[0]), FileDVO.fromJson(args[1]));
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showDeviceOnboarding',
      callback: (args) async {
        await uiBridge.showDeviceOnboarding(DeviceSharedSecret.fromJson(args[0]));
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showRequest',
      callback: (args) async {
        await uiBridge.showRequest(LocalAccountDTO.fromJson(args[0]), LocalRequestDVO.fromJson(args[1]));
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_showError',
      callback: (args) async {
        final error = args[0] as Map<String, dynamic>;

        await uiBridge.showError(
          (
            code: error['code'] as String,
            message: error['message'] as String,
            userfriendlyMessage: error['userfriendlyMessage'] as String?,
            data: error['data'] as Map<String, dynamic>?,
          ),
          args[1] != null ? LocalAccountDTO.fromJson(args[1]) : null,
        );
      },
    );

    _controller.addJavaScriptHandler(
      handlerName: 'uibridge_requestAccountSelection',
      callback: (args) async {
        final dto = await uiBridge.requestAccountSelection(
          List<LocalAccountDTO>.from(args[0].map((e) => LocalAccountDTO.fromJson(e))),
          args.length > 1 ? args[1] : null,
          args.length > 2 ? args[2] : null,
        );

        return dto?.toJson();
      },
    );

    _isRegistered = true;
  }
}

extension Filesystem on InAppWebViewController {
  void addFilesystemJavaScriptHandlers(FilesystemAdapter filesystemAdapter) {
    addJavaScriptHandler(
      handlerName: 'readFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          final fileContent = await filesystemAdapter.readFile(path, storage);
          return {'ok': true, 'content': fileContent};
        } catch (e) {
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    addJavaScriptHandler(
      handlerName: 'readFileAsBinary',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          final fileContent = await filesystemAdapter.readFileAsBinary(path, storage);
          return {'ok': true, 'content': fileContent.toList()};
        } catch (e) {
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    addJavaScriptHandler(
      handlerName: 'writeFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;
        final data = args[2] as String;
        final append = args[3] as bool;

        try {
          await filesystemAdapter.writeFile(path, storage, data, append);
          return {'ok': true};
        } catch (e) {
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    addJavaScriptHandler(
      handlerName: 'deleteFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          await filesystemAdapter.deleteFile(path, storage);
          return {'ok': true};
        } catch (e) {
          return {'ok': false, 'content': e.toString()};
        }
      },
    );

    addJavaScriptHandler(
      handlerName: 'existsFile',
      callback: (args) async {
        final path = args[0] as String;
        final storage = args[1] as String;

        try {
          return await filesystemAdapter.existsFile(path, storage);
        } catch (e) {
          return false;
        }
      },
    );
  }
}

extension LocalNotifications on InAppWebViewController {
  void addLocalNotificationsJavaScriptHandlers() {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    addJavaScriptHandler(
      handlerName: 'notifications_schedule',
      callback: (args) async {
        final title = args[0] as String;
        final body = args[1] as String;
        final id = args[2] as int;

        await flutterLocalNotificationsPlugin.show(id, title, body, null);
      },
    );

    addJavaScriptHandler(
      handlerName: 'notifications_clear',
      callback: (args) async {
        final id = args[0] as int;

        await flutterLocalNotificationsPlugin.cancel(id);
      },
    );

    addJavaScriptHandler(
      handlerName: 'notifications_clearAll',
      callback: (args) async {
        await flutterLocalNotificationsPlugin.cancelAll();
      },
    );

    addJavaScriptHandler(
      handlerName: 'notifications_getAll',
      callback: (args) async {
        final notifications = await flutterLocalNotificationsPlugin.getActiveNotifications();
        return notifications.map((e) => e.id).toList();
      },
    );
  }
}
