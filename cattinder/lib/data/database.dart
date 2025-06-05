import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class LikedCatsTable extends Table {
  TextColumn get id => text()();
  TextColumn get json => text()();
  DateTimeColumn get likedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CachedCatsTable extends Table {
  TextColumn get id => text()();
  TextColumn get json => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [LikedCatsTable, CachedCatsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _open() => LazyDatabase(() async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File(path.join(dir.path, 'cat_tinder.sqlite'));
  return NativeDatabase.createInBackground(file);
});
