import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class AbstractUrlLauncher {
  Future<bool> canLaunchUrl(Uri url);

  Future<bool> launchUrl(Uri url);

  Future<void> launchSafe(Uri url) async {
    if (!await canLaunchUrl(url)) {
      GetIt.I.get<Logger>().e('Could not launch $url');
      return;
    }

    try {
      await launchUrl(url);
    } catch (e) {
      GetIt.I.get<Logger>().e(e);
    }
  }
}
