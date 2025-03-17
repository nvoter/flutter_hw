import 'package:url_launcher/url_launcher.dart' as launcher;

class UrlLauncherService {
  Future<void> launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await launcher.canLaunchUrl(uri)) {
      await launcher.launchUrl(uri);
    } else {
      throw Exception('Could not launch $url');
    }
  }
}
