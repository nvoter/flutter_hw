import '../../services/url_launcher_service.dart';

class DetailInteractor {
  final UrlLauncherService _urlLauncherService;

  DetailInteractor(this._urlLauncherService);

  Future<void> openUrl(String url) async {
    await _urlLauncherService.launchUrl(url);
  }
}
