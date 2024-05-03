import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:enmeshed_types/enmeshed_types.dart';
import 'package:flutter/material.dart';

import '/core/utils/extensions.dart';

Future<List<MessageDTO>> getUnreadMessages({required Session session, required BuildContext context}) async {
  final address = (await session.transportServices.account.getIdentityInfo()).value.address;

  if (!context.mounted) return [];

  final messagesResult = await session.transportServices.messages.getMessages(
    query: {
      if (!context.showTechnicalMessages) 'content.@type': QueryValue.string(r'~^(Request|Mail)$'),
      'createdBy': QueryValue.string('!$address'),
      'wasReadAt': QueryValue.string('!'),
    },
  );

  return messagesResult.value;
}
