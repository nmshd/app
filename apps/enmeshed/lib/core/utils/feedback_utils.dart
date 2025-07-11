import 'dart:async';
import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';

extension FeedbackUtils on BuildContext {
  Future<void> giveFeedback() => _giveFeedback(this);
}

Future<void> _giveFeedback(BuildContext context) async {
  final completer = Completer<bool>();

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
      completer.complete(true);
    } on PlatformException catch (_) {
      completer.complete(false);
    }
  });

  final success = await completer.future;

  if (success) {
    // TODO(jkoenig134): Show success dialog
  } else {
    // TODO(jkoenig134): Show error dialog
  }
}

// Future<void> _showFeedbackSuccessDialog(BuildContext context) async {
//   await showDialog<void>(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: Text(context.l10n.drawer_hints_giveFeedback),
//       content: Text(context.l10n.drawer_hints_giveFeedback),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text(context.l10n.drawer_hints_giveFeedback),
//         ),
//       ],
//     ),
//   );
// }

Future<String> _writeImageToStorage(Uint8List feedbackScreenshot) async {
  final output = await getTemporaryDirectory();
  final screenshotFilePath = '${output.path}/feedback.png';
  final screenshotFile = File(screenshotFilePath);
  await screenshotFile.writeAsBytes(feedbackScreenshot);
  return screenshotFilePath;
}
