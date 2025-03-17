import 'package:flutter/foundation.dart';
import '../../models/cat.dart';
import 'home_interactor.dart';
import 'contracts/home_view.dart';

class HomePresenter with ChangeNotifier implements ValueListenable<Cat?> {
  final HomeInteractor _interactor = HomeInteractor();
  final HomeView _view;

  Cat? _currentCat;
  int _likesCount = 0;
  final ValueNotifier<int> likesCountNotifier = ValueNotifier<int>(0);

  HomePresenter(this._view);

  @override
  Cat? get value => _currentCat;

  Future<void> initialize() async {
    try {
      await _interactor.fetchAllBreeds();
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
    _likesCount++;
    likesCountNotifier.value = _likesCount;
    _view.updateLikesCount(_likesCount);
    notifyListeners();
  }

  void dislikeCat() {
    notifyListeners();
  }

  void navigateToDetail(Cat cat) {
    _view.navigateToDetail(cat);
  }
}
