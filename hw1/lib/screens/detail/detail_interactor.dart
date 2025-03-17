import '../../services/url_launcher_service.dart';

class DetailInteractor {
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  Future<void> openUrl(String url) async {
    await _urlLauncherService.launchUrl(url);
  }
}
