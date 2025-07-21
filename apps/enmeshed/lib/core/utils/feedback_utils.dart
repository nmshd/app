import 'dart:async';

import 'package:enmeshed_runtime_bridge/enmeshed_runtime_bridge.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:renderers/renderers.dart';

extension FeedbackUtils on BuildContext {
  Future<void> giveFeedback(String accountReference) => _giveFeedback(this, accountReference);
}

Future<void> _giveFeedback(BuildContext context, String accountId) async {
  final router = GoRouter.of(context);
  final betterFeedback = BetterFeedback.of(context);

  // TODO: get all texts from l10n

  final uri = Uri(
    scheme: 'mailto',
    host: 'info@enmeshed.eu',
    queryParameters: {
      'subject': 'enmeshed App Feedback',
    },
  );

  final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();
  final canLaunch = await urlLauncher.launchUrl(uri);
  if (!canLaunch) {
    GetIt.I.get<Logger>().e('Cannot launch email client');
    unawaited(router.push('/account/$accountId/feedback/error'));
    return;
  }

  final completer = Completer<bool>();

  betterFeedback.show((feedback) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    final identityInfo = await session.transportServices.account.getIdentityInfo();
    final address = identityInfo.value.address;

    final file = await session.transportServices.files.uploadOwnFile(
      content: feedback.screenshot,
      filename: 'feedback_${DateTime.now().toIso8601String()}.png',
      mimetype: 'image/png',
    );

    final appVersion = await PackageInfo.fromPlatform().then((info) => info.version);

    uri.queryParameters['body'] =
        '${feedback.text}\n\nProfil-Adresse: $address\nApp Version: $appVersion\nScreenshot (encrypted): ${file.value.reference.truncated}';

    try {
      final success = await urlLauncher.launchUrl(uri);
      completer.complete(success);
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to send feedback email: $e');
      completer.complete(false);
    }
  });

  final success = await completer.future;
  unawaited(router.push(success ? '/account/$accountId/feedback/success' : '/account/$accountId/feedback/error', extra: success ? null : uri));
}
