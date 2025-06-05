import 'dart:convert';
import '../../models/cat.dart';
import '../../models/liked_cat.dart';
import 'package:drift/drift.dart' show OrderingTerm, Value;
import 'database.dart';

class CatsDao {
  final AppDatabase _db;
  CatsDao(this._db);

  Stream<List<LikedCat>> watchLikes() => (_db.select(_db.likedCatsTable)
    ..orderBy([(t) => OrderingTerm.desc(t.likedAt)])).watch().map(
    (rows) =>
        rows
            .map(
              (r) => LikedCat(
                cat: Cat.fromJson(jsonDecode(r.json)),
                likeDate: r.likedAt,
              ),
            )
            .toList(),
  );

  Future<void> addLike(Cat cat) async {
    await _db
        .into(_db.likedCatsTable)
        .insertOnConflictUpdate(
          LikedCatsTableCompanion(
            id: Value(cat.id),
            json: Value(jsonEncode(cat.toJson())),
            likedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<void> removeLike(String id) =>
      (_db.delete(_db.likedCatsTable)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> cacheCat(Cat cat) async {
    await _db
        .into(_db.cachedCatsTable)
        .insertOnConflictUpdate(
          CachedCatsTableCompanion(
            id: Value(cat.id),
            json: Value(jsonEncode(cat.toJson())),
          ),
        );
  }

  Future<List<Cat>> getCachedCats() async {
    final rows = await _db.select(_db.cachedCatsTable).get();
    return rows.map((r) => Cat.fromJson(jsonDecode(r.json))).toList();
  }
}
