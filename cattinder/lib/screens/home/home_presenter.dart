import 'package:flutter/foundation.dart';
import '../../models/cat.dart';
import 'home_interactor.dart';
import 'contracts/home_view.dart';

class HomePresenter with ChangeNotifier implements ValueListenable<Cat?> {
  final HomeInteractor _interactor;
  final HomeView _view;

  Cat? _currentCat;
  final ValueNotifier<int> likesCountNotifier = ValueNotifier<int>(0);

  HomePresenter(this._interactor, this._view);

  @override
  Cat? get value => _currentCat;

  void _updateLikesCount() {
    likesCountNotifier.value = _interactor.getLikesCount();
  }

  Future<void> initialize() async {
    try {
      await _interactor.fetchAllBreeds();
      _updateLikesCount();
    } catch (e) {
      _view.showError('Failed to initialize: $e');
    }
    await loadNextCat();
  }

  Future<void> loadNextCat() async {
    try {
      _currentCat = await _interactor.getNextCat();
      notifyListeners();
    } catch (e) {
      _view.showError('Failed to load next cat: $e');
    }
  }

  void likeCat() {
    _interactor.addLike(_currentCat!);
    int likesCount = _interactor.getLikesCount();
    likesCountNotifier.value = likesCount;
    _view.updateLikesCount(likesCount);
    notifyListeners();
  }

  void dislikeCat() {
    notifyListeners();
  }

  void navigateToDetail(Cat cat) {
    _view.navigateToDetail(cat);
  }
}
