import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../models/cat.dart';
import 'home_interactor.dart';
import 'contracts/home_view.dart';

class HomePresenter with ChangeNotifier implements ValueListenable<Cat?> {
  final HomeInteractor _interactor;
  final HomeView _view;

  Cat? _currentCat;
  final ValueNotifier<int> likesCountNotifier = ValueNotifier(0);
  late final StreamSubscription<int> _likesSub;

  HomePresenter(this._interactor, this._view) {
    _likesSub = _interactor.watchLikesCount().listen((cnt) {
      likesCountNotifier.value = cnt;
      _view.updateLikesCount(cnt);
    });
  }

  @override
  Cat? get value => _currentCat;

  Future<void> initialize() async {
    try {
      await _interactor.fetchAllBreeds();
    } catch (e) {
      _view.showError('Init error: $e');
    }
    await loadNextCat();
  }

  Future<void> loadNextCat() async {
    try {
      _currentCat = await _interactor.getNextCat();
      notifyListeners();
    } catch (e) {
      _view.showError('Failed to load cat: $e');
    }
  }

  void likeCat() async {
    if (_currentCat == null || _currentCat!.id == 'no_cache') return;
    await _interactor.addLike(_currentCat!);
  }

  void dislikeCat() => notifyListeners();

  void navigateToDetail(Cat cat) => _view.navigateToDetail(cat);

  @override
  void dispose() {
    _likesSub.cancel();
    super.dispose();
  }
}
