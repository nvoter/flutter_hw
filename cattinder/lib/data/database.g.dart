// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LikedCatsTableTable extends LikedCatsTable
    with TableInfo<$LikedCatsTableTable, LikedCatsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedCatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _likedAtMeta = const VerificationMeta(
    'likedAt',
  );
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
    'liked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, json, likedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_cats_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<LikedCatsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('liked_at')) {
      context.handle(
        _likedAtMeta,
        likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_likedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LikedCatsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedCatsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      json:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}json'],
          )!,
      likedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}liked_at'],
          )!,
    );
  }

  @override
  $LikedCatsTableTable createAlias(String alias) {
    return $LikedCatsTableTable(attachedDatabase, alias);
  }
}

class LikedCatsTableData extends DataClass
    implements Insertable<LikedCatsTableData> {
  final String id;
  final String json;
  final DateTime likedAt;
  const LikedCatsTableData({
    required this.id,
    required this.json,
    required this.likedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['json'] = Variable<String>(json);
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  LikedCatsTableCompanion toCompanion(bool nullToAbsent) {
    return LikedCatsTableCompanion(
      id: Value(id),
      json: Value(json),
      likedAt: Value(likedAt),
    );
  }

  factory LikedCatsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedCatsTableData(
      id: serializer.fromJson<String>(json['id']),
      json: serializer.fromJson<String>(json['json']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'json': serializer.toJson<String>(json),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  LikedCatsTableData copyWith({String? id, String? json, DateTime? likedAt}) =>
      LikedCatsTableData(
        id: id ?? this.id,
        json: json ?? this.json,
        likedAt: likedAt ?? this.likedAt,
      );
  LikedCatsTableData copyWithCompanion(LikedCatsTableCompanion data) {
    return LikedCatsTableData(
      id: data.id.present ? data.id.value : this.id,
      json: data.json.present ? data.json.value : this.json,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsTableData(')
          ..write('id: $id, ')
          ..write('json: $json, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, json, likedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedCatsTableData &&
          other.id == this.id &&
          other.json == this.json &&
          other.likedAt == this.likedAt);
}

class LikedCatsTableCompanion extends UpdateCompanion<LikedCatsTableData> {
  final Value<String> id;
  final Value<String> json;
  final Value<DateTime> likedAt;
  final Value<int> rowid;
  const LikedCatsTableCompanion({
    this.id = const Value.absent(),
    this.json = const Value.absent(),
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikedCatsTableCompanion.insert({
    required String id,
    required String json,
    required DateTime likedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       json = Value(json),
       likedAt = Value(likedAt);
  static Insertable<LikedCatsTableData> custom({
    Expression<String>? id,
    Expression<String>? json,
    Expression<DateTime>? likedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (json != null) 'json': json,
      if (likedAt != null) 'liked_at': likedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikedCatsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? json,
    Value<DateTime>? likedAt,
    Value<int>? rowid,
  }) {
    return LikedCatsTableCompanion(
      id: id ?? this.id,
      json: json ?? this.json,
      likedAt: likedAt ?? this.likedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsTableCompanion(')
          ..write('id: $id, ')
          ..write('json: $json, ')
          ..write('likedAt: $likedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedCatsTableTable extends CachedCatsTable
    with TableInfo<$CachedCatsTableTable, CachedCatsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedCatsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, json];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_cats_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedCatsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedCatsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedCatsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      json:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}json'],
          )!,
    );
  }

  @override
  $CachedCatsTableTable createAlias(String alias) {
    return $CachedCatsTableTable(attachedDatabase, alias);
  }
}

class CachedCatsTableData extends DataClass
    implements Insertable<CachedCatsTableData> {
  final String id;
  final String json;
  const CachedCatsTableData({required this.id, required this.json});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['json'] = Variable<String>(json);
    return map;
  }

  CachedCatsTableCompanion toCompanion(bool nullToAbsent) {
    return CachedCatsTableCompanion(id: Value(id), json: Value(json));
  }

  factory CachedCatsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedCatsTableData(
      id: serializer.fromJson<String>(json['id']),
      json: serializer.fromJson<String>(json['json']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'json': serializer.toJson<String>(json),
    };
  }

  CachedCatsTableData copyWith({String? id, String? json}) =>
      CachedCatsTableData(id: id ?? this.id, json: json ?? this.json);
  CachedCatsTableData copyWithCompanion(CachedCatsTableCompanion data) {
    return CachedCatsTableData(
      id: data.id.present ? data.id.value : this.id,
      json: data.json.present ? data.json.value : this.json,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedCatsTableData(')
          ..write('id: $id, ')
          ..write('json: $json')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, json);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedCatsTableData &&
          other.id == this.id &&
          other.json == this.json);
}

class CachedCatsTableCompanion extends UpdateCompanion<CachedCatsTableData> {
  final Value<String> id;
  final Value<String> json;
  final Value<int> rowid;
  const CachedCatsTableCompanion({
    this.id = const Value.absent(),
    this.json = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedCatsTableCompanion.insert({
    required String id,
    required String json,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       json = Value(json);
  static Insertable<CachedCatsTableData> custom({
    Expression<String>? id,
    Expression<String>? json,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (json != null) 'json': json,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedCatsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? json,
    Value<int>? rowid,
  }) {
    return CachedCatsTableCompanion(
      id: id ?? this.id,
      json: json ?? this.json,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedCatsTableCompanion(')
          ..write('id: $id, ')
          ..write('json: $json, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LikedCatsTableTable likedCatsTable = $LikedCatsTableTable(this);
  late final $CachedCatsTableTable cachedCatsTable = $CachedCatsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    likedCatsTable,
    cachedCatsTable,
  ];
}

typedef $$LikedCatsTableTableCreateCompanionBuilder =
    LikedCatsTableCompanion Function({
      required String id,
      required String json,
      required DateTime likedAt,
      Value<int> rowid,
    });
typedef $$LikedCatsTableTableUpdateCompanionBuilder =
    LikedCatsTableCompanion Function({
      Value<String> id,
      Value<String> json,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });

class $$LikedCatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LikedCatsTableTable> {
  $$LikedCatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LikedCatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedCatsTableTable> {
  $$LikedCatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LikedCatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedCatsTableTable> {
  $$LikedCatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);
}

class $$LikedCatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LikedCatsTableTable,
          LikedCatsTableData,
          $$LikedCatsTableTableFilterComposer,
          $$LikedCatsTableTableOrderingComposer,
          $$LikedCatsTableTableAnnotationComposer,
          $$LikedCatsTableTableCreateCompanionBuilder,
          $$LikedCatsTableTableUpdateCompanionBuilder,
          (
            LikedCatsTableData,
            BaseReferences<
              _$AppDatabase,
              $LikedCatsTableTable,
              LikedCatsTableData
            >,
          ),
          LikedCatsTableData,
          PrefetchHooks Function()
        > {
  $$LikedCatsTableTableTableManager(
    _$AppDatabase db,
    $LikedCatsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LikedCatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$LikedCatsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LikedCatsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsTableCompanion(
                id: id,
                json: json,
                likedAt: likedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String json,
                required DateTime likedAt,
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsTableCompanion.insert(
                id: id,
                json: json,
                likedAt: likedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LikedCatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LikedCatsTableTable,
      LikedCatsTableData,
      $$LikedCatsTableTableFilterComposer,
      $$LikedCatsTableTableOrderingComposer,
      $$LikedCatsTableTableAnnotationComposer,
      $$LikedCatsTableTableCreateCompanionBuilder,
      $$LikedCatsTableTableUpdateCompanionBuilder,
      (
        LikedCatsTableData,
        BaseReferences<_$AppDatabase, $LikedCatsTableTable, LikedCatsTableData>,
      ),
      LikedCatsTableData,
      PrefetchHooks Function()
    >;
typedef $$CachedCatsTableTableCreateCompanionBuilder =
    CachedCatsTableCompanion Function({
      required String id,
      required String json,
      Value<int> rowid,
    });
typedef $$CachedCatsTableTableUpdateCompanionBuilder =
    CachedCatsTableCompanion Function({
      Value<String> id,
      Value<String> json,
      Value<int> rowid,
    });

class $$CachedCatsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedCatsTableTable> {
  $$CachedCatsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedCatsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedCatsTableTable> {
  $$CachedCatsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedCatsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedCatsTableTable> {
  $$CachedCatsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);
}

class $$CachedCatsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedCatsTableTable,
          CachedCatsTableData,
          $$CachedCatsTableTableFilterComposer,
          $$CachedCatsTableTableOrderingComposer,
          $$CachedCatsTableTableAnnotationComposer,
          $$CachedCatsTableTableCreateCompanionBuilder,
          $$CachedCatsTableTableUpdateCompanionBuilder,
          (
            CachedCatsTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedCatsTableTable,
              CachedCatsTableData
            >,
          ),
          CachedCatsTableData,
          PrefetchHooks Function()
        > {
  $$CachedCatsTableTableTableManager(
    _$AppDatabase db,
    $CachedCatsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CachedCatsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CachedCatsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CachedCatsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedCatsTableCompanion(id: id, json: json, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String json,
                Value<int> rowid = const Value.absent(),
              }) => CachedCatsTableCompanion.insert(
                id: id,
                json: json,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedCatsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedCatsTableTable,
      CachedCatsTableData,
      $$CachedCatsTableTableFilterComposer,
      $$CachedCatsTableTableOrderingComposer,
      $$CachedCatsTableTableAnnotationComposer,
      $$CachedCatsTableTableCreateCompanionBuilder,
      $$CachedCatsTableTableUpdateCompanionBuilder,
      (
        CachedCatsTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedCatsTableTable,
          CachedCatsTableData
        >,
      ),
      CachedCatsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LikedCatsTableTableTableManager get likedCatsTable =>
      $$LikedCatsTableTableTableManager(_db, _db.likedCatsTable);
  $$CachedCatsTableTableTableManager get cachedCatsTable =>
      $$CachedCatsTableTableTableManager(_db, _db.cachedCatsTable);
}
