import 'package:renderers/renderers.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncher extends AbstractUrlLauncher {
  @override
  Future<bool> canLaunchUrl(Uri url) {
    return url_launcher.canLaunchUrl(url);
  }

  @override
  Future<bool> launchUrl(Uri url) {
    return url_launcher.launchUrl(url);
  }
}
