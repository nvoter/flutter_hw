import '../models/cat.dart';
import '../models/liked_cat.dart';
import '../data/cats_dao.dart';

class LikesRepository {
  final CatsDao _dao;
  LikesRepository(this._dao);

  Stream<List<LikedCat>> watchLikes() => _dao.watchLikes();

  Future<void> addLike(Cat cat) => _dao.addLike(cat);

  Future<void> removeLike(LikedCat cat) => _dao.removeLike(cat.cat.id);
}
