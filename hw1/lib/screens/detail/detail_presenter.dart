import 'package:flutter/foundation.dart';
import 'contracts/detail_view.dart';
import 'detail_interactor.dart';

class DetailPresenter with ChangeNotifier {
  final DetailInteractor _interactor = DetailInteractor();
  final DetailView _view;

  DetailPresenter(this._view);

  Future<void> openWikipedia(String url) async {
    try {
      await _interactor.openUrl(url);
    } catch (e) {
      _view.showError('Failed to open Wikipedia: $e');
    }
  }
}
