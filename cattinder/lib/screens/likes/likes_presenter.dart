import 'package:flutter/material.dart';
import '../../models/liked_cat.dart';
import '../likes/likes_interactor.dart';
import 'contracts/likes_view.dart';

class LikesPresenter {
  final LikesView _view;
  final ValueNotifier<List<LikedCat>> likesNotifier = ValueNotifier([]);
  final LikesInteractor _interactor;

  LikesPresenter(this._interactor, this._view);

  void initialize() {
    try {
      final cats = _interactor.getLikedCats();
      likesNotifier.value = cats;
    } catch (e) {
      _view.showError('Failed to load liked cats');
    }
  }

  void removeLike(LikedCat cat) {
    _interactor.removeLike(cat);
    likesNotifier.value = _interactor.getLikedCats();
  }

  void navigateToDetail(LikedCat cat) {
    _view.navigateToDetail(cat.cat);
  }
}
