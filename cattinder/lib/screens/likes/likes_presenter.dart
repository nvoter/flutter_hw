import 'package:flutter/material.dart';
import '../../models/liked_cat.dart';
import 'likes_interactor.dart';
import 'contracts/likes_view.dart';

class LikesPresenter {
  final LikesView _view;
  final LikesInteractor _interactor;

  final ValueNotifier<List<LikedCat>> likesNotifier = ValueNotifier([]);

  LikesPresenter(this._interactor, this._view);

  Future<void> initialize() async {
    try {
      likesNotifier.value = await _interactor.getLikedCats();
    } catch (e) {
      _view.showError(e.toString());
    }
  }

  Future<void> removeLike(LikedCat cat) async {
    await _interactor.removeLike(cat);
    likesNotifier.value = await _interactor.getLikedCats();
  }

  void navigateToDetail(LikedCat cat) => _view.navigateToDetail(cat.cat);
}
