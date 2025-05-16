import '../models/liked_cat.dart';

class LikesService {
  final List<LikedCat> _likedCats = [];

  void addLike(LikedCat cat) {
    if (!_likedCats.contains(cat)) {
      _likedCats.add(cat);
    }
  }

  void removeLike(LikedCat cat) {
    _likedCats.remove(cat);
  }

  List<LikedCat> getLikes() {
    return List<LikedCat>.from(_likedCats);
  }
}
