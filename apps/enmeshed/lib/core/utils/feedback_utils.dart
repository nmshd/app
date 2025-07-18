import 'dart:async';
import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:renderers/renderers.dart';

extension FeedbackUtils on BuildContext {
  Future<void> giveFeedback() => _giveFeedback(this);
}

Future<void> _giveFeedback(BuildContext context) async {
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
    unawaited(router.push('/feedback/error'));
    return;
  }

  final completer = Completer<bool>();

  betterFeedback.show((feedback) async {
    final screenshotFilePath = await _writeImageToStorage(feedback.screenshot);

    // TODO: upload screenshot and add the Encrypted URL to the email body

    uri.queryParameters['body'] = '${feedback.text}\n\nScreenshot (encrypted): $screenshotFilePath';

    try {
      final success = await urlLauncher.launchUrl(uri);
      completer.complete(success);
    } catch (e) {
      GetIt.I.get<Logger>().e('Failed to send feedback email: $e');
      completer.complete(false);
    }
  });

  final success = await completer.future;
  unawaited(router.push(success ? '/feedback/success' : '/feedback/error', extra: success ? null : uri));
}

Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
