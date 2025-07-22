import 'dart:async';
import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

extension FeedbackUtils on BuildContext {
  Future<void> giveFeedback() => _giveFeedback(this);
}

Future<void> _giveFeedback(BuildContext context) async {
  final completer = Completer<Email?>();
  final logger = GetIt.I.get<Logger>();
  final router = GoRouter.of(context);

  BetterFeedback.of(context).show((feedback) async {
    final screenshotFilePath = await _writeImageToStorage(feedback.screenshot);

    final email = Email(
      body: feedback.text,
      subject: 'enmeshed App Feedback',
      recipients: ['info@enmeshed.eu'],
      attachmentPaths: [screenshotFilePath],
    );

    try {
      await FlutterEmailSender.send(email);
      completer.complete();
    } on PlatformException catch (e) {
      completer.complete(email);
      logger.e('Failed to send feedback email: ${e.message}');
    } catch (e) {
      completer.complete(email);
      logger.e('Failed to send feedback email: $e');
    }
  });

  final email = await completer.future;
  unawaited(router.push(email == null ? '/feedback/success' : '/feedback/error', extra: email));
}

Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
