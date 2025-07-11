import 'dart:io';
import 'dart:typed_data';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

extension FeedbackUtils on BuildContext {
  Future<void> giveFeedback() => _giveFeedback(this);
}

Future<void> _giveFeedback(BuildContext context) async {
  BetterFeedback.of(context).show((feedback) async {
    final screenshotFilePath = await _writeImageToStorage(feedback.screenshot);

    final email = Email(
      body: feedback.text,
      subject: 'enmeshed App Feedback',
      recipients: ['info@enmeshed.eu'],
      attachmentPaths: [screenshotFilePath],
    );

    await FlutterEmailSender.send(email);

    // TODO: success dialog
  });
}

Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
