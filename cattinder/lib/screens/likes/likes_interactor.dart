import '../../models/liked_cat.dart';
import '../../services/likes_repository.dart';

class LikesInteractor {
  final LikesRepository _repo;
  LikesInteractor(this._repo);

  Future<List<LikedCat>> getLikedCats() async => _repo.watchLikes().first;
  Future<void> removeLike(LikedCat cat) => _repo.removeLike(cat);
}
