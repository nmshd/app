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
  Future<void> giveFeedback(String accountId) => _giveFeedback(this, accountId);
}

Future<void> _giveFeedback(BuildContext context, String accountId) async {
  final router = GoRouter.of(context);
  final betterFeedback = BetterFeedback.of(context);

  // TODO: get all texts from l10n

  final urlLauncher = GetIt.I.get<AbstractUrlLauncher>();
  final canLaunch = await urlLauncher.canLaunchUrl(Uri(scheme: 'mailto', path: 'info@enmeshed.eu'));
  if (!canLaunch) {
    GetIt.I.get<Logger>().e('Cannot launch email client');
    unawaited(router.push('/account/$accountId/feedback/error'));
    return;
  }

  final completer = Completer<(bool, Uri?)>();

  betterFeedback.show((feedback) async {
    final session = GetIt.I.get<EnmeshedRuntime>().getSession(accountId);

    final identityInfo = await session.transportServices.account.getIdentityInfo();
    final address = identityInfo.value.address;

    final file = await session.transportServices.files.uploadOwnFile(
      content: feedback.screenshot.toList(),
      filename: 'feedback_${DateTime.now().toIso8601String()}.png',
      mimetype: 'image/png',
    );

    final appVersion = await PackageInfo.fromPlatform().then((info) => info.version);

    const subject = 'enmeshed App Feedback';
    final feedbackText = feedback.text.trim().isEmpty ? '' : '${feedback.text}\n';
    final body =
        '''
        $feedbackText
        Profil-Adresse: $address
        App Version: $appVersion
        Screenshot (encrypted): ${file.value.reference.url}
        ''';

    final uri = Uri(scheme: 'mailto', path: 'info@enmeshed.eu', query: _encodeQueryParameters({'subject': subject, 'body': body}));

    try {
      final success = await urlLauncher.launchUrl(uri);
      completer.complete((success, uri));
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to send feedback email: $e');
      completer.complete((false, uri));
    }
  });

  final result = await completer.future;
  unawaited(
    router.push(result.$1 ? '/account/$accountId/feedback/success' : '/account/$accountId/feedback/error', extra: result.$1 ? null : result.$2),
  );
}

String? _encodeQueryParameters(Map<String, String> params) =>
    params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
