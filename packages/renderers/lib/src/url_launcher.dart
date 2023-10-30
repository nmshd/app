abstract class AbstractUrlLauncher {
  Future<bool> canLaunchUrl(Uri url);

  Future<bool> launchUrl(Uri url);
}
