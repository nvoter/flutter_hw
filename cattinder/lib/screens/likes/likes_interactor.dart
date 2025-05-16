import '../../models/liked_cat.dart';
import '../../services/likes_service.dart';

class LikesInteractor {
  final LikesService _likesService;

  LikesInteractor(this._likesService);

  List<LikedCat> getLikedCats() {
    return _likesService.getLikes();
  }

  void removeLike(LikedCat cat) {
    _likesService.removeLike(cat);
  }
}
