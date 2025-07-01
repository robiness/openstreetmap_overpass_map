// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CheckInsTable extends CheckIns with TableInfo<$CheckInsTable, CheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spotIdMeta = const VerificationMeta('spotId');
  @override
  late final GeneratedColumn<int> spotId = GeneratedColumn<int>(
    'spot_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    spotId,
    updatedAt,
    syncedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('spot_id')) {
      context.handle(
        _spotIdMeta,
        spotId.isAcceptableOrUnknown(data['spot_id']!, _spotIdMeta),
      );
    } else if (isInserting) {
      context.missing(_spotIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckIn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      spotId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spot_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }
}

class CheckIn extends DataClass implements Insertable<CheckIn> {
  /// A unique identifier for the check-in, typically a UUID.
  final String id;

  /// The ID of the user who performed the check-in.
  final String userId;

  /// The ID of the spot that was visited.
  final int spotId;

  /// The timestamp when this record was last modified locally.
  /// This is automatically set on creation.
  final DateTime updatedAt;

  /// The timestamp when this record was last successfully synced with the cloud.
  /// A `NULL` value indicates that this record has local changes that
  /// have not yet been pushed to the server.
  final DateTime? syncedAt;

  /// The timestamp when this record was soft-deleted.
  /// A `NULL` value indicates that this record is not deleted.
  /// When set, the record should be considered deleted but kept for sync purposes.
  final DateTime? deletedAt;
  const CheckIn({
    required this.id,
    required this.userId,
    required this.spotId,
    required this.updatedAt,
    this.syncedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['spot_id'] = Variable<int>(spotId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      id: Value(id),
      userId: Value(userId),
      spotId: Value(spotId),
      updatedAt: Value(updatedAt),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory CheckIn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckIn(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      spotId: serializer.fromJson<int>(json['spotId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  factory CheckIn.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => CheckIn.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'spotId': serializer.toJson<int>(spotId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  CheckIn copyWith({
    String? id,
    String? userId,
    int? spotId,
    DateTime? updatedAt,
    Value<DateTime?> syncedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => CheckIn(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    spotId: spotId ?? this.spotId,
    updatedAt: updatedAt ?? this.updatedAt,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  CheckIn copyWithCompanion(CheckInsCompanion data) {
    return CheckIn(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      spotId: data.spotId.present ? data.spotId.value : this.spotId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckIn(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spotId: $spotId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, spotId, updatedAt, syncedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckIn &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.spotId == this.spotId &&
          other.updatedAt == this.updatedAt &&
          other.syncedAt == this.syncedAt &&
          other.deletedAt == this.deletedAt);
}

class CheckInsCompanion extends UpdateCompanion<CheckIn> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> spotId;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> syncedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const CheckInsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.spotId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckInsCompanion.insert({
    required String id,
    required String userId,
    required int spotId,
    this.updatedAt = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       spotId = Value(spotId);
  static Insertable<CheckIn> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? spotId,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? syncedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (spotId != null) 'spot_id': spotId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckInsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<int>? spotId,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? syncedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CheckInsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      spotId: spotId ?? this.spotId,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (spotId.present) {
      map['spot_id'] = Variable<int>(spotId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spotId: $spotId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AreasTable extends Areas with TableInfo<$AreasTable, Area> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<int> parentId = GeneratedColumn<int>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES areas (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adminLevelMeta = const VerificationMeta(
    'adminLevel',
  );
  @override
  late final GeneratedColumn<int> adminLevel = GeneratedColumn<int>(
    'admin_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coordinatesMeta = const VerificationMeta(
    'coordinates',
  );
  @override
  late final GeneratedColumn<String> coordinates = GeneratedColumn<String>(
    'coordinates',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentId,
    name,
    type,
    adminLevel,
    coordinates,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'areas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Area> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('admin_level')) {
      context.handle(
        _adminLevelMeta,
        adminLevel.isAcceptableOrUnknown(data['admin_level']!, _adminLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_adminLevelMeta);
    }
    if (data.containsKey('coordinates')) {
      context.handle(
        _coordinatesMeta,
        coordinates.isAcceptableOrUnknown(
          data['coordinates']!,
          _coordinatesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coordinatesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Area map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Area(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      adminLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}admin_level'],
      )!,
      coordinates: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coordinates'],
      )!,
    );
  }

  @override
  $AreasTable createAlias(String alias) {
    return $AreasTable(attachedDatabase, alias);
  }
}

class Area extends DataClass implements Insertable<Area> {
  final int id;
  final int? parentId;
  final String name;
  final String type;
  final int adminLevel;

  /// Stored as a JSON string.
  final String coordinates;
  const Area({
    required this.id,
    this.parentId,
    required this.name,
    required this.type,
    required this.adminLevel,
    required this.coordinates,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<int>(parentId);
    }
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['admin_level'] = Variable<int>(adminLevel);
    map['coordinates'] = Variable<String>(coordinates);
    return map;
  }

  AreasCompanion toCompanion(bool nullToAbsent) {
    return AreasCompanion(
      id: Value(id),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      name: Value(name),
      type: Value(type),
      adminLevel: Value(adminLevel),
      coordinates: Value(coordinates),
    );
  }

  factory Area.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Area(
      id: serializer.fromJson<int>(json['id']),
      parentId: serializer.fromJson<int?>(json['parentId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      adminLevel: serializer.fromJson<int>(json['adminLevel']),
      coordinates: serializer.fromJson<String>(json['coordinates']),
    );
  }
  factory Area.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => Area.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'parentId': serializer.toJson<int?>(parentId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'adminLevel': serializer.toJson<int>(adminLevel),
      'coordinates': serializer.toJson<String>(coordinates),
    };
  }

  Area copyWith({
    int? id,
    Value<int?> parentId = const Value.absent(),
    String? name,
    String? type,
    int? adminLevel,
    String? coordinates,
  }) => Area(
    id: id ?? this.id,
    parentId: parentId.present ? parentId.value : this.parentId,
    name: name ?? this.name,
    type: type ?? this.type,
    adminLevel: adminLevel ?? this.adminLevel,
    coordinates: coordinates ?? this.coordinates,
  );
  Area copyWithCompanion(AreasCompanion data) {
    return Area(
      id: data.id.present ? data.id.value : this.id,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      adminLevel: data.adminLevel.present
          ? data.adminLevel.value
          : this.adminLevel,
      coordinates: data.coordinates.present
          ? data.coordinates.value
          : this.coordinates,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Area(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('adminLevel: $adminLevel, ')
          ..write('coordinates: $coordinates')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, parentId, name, type, adminLevel, coordinates);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Area &&
          other.id == this.id &&
          other.parentId == this.parentId &&
          other.name == this.name &&
          other.type == this.type &&
          other.adminLevel == this.adminLevel &&
          other.coordinates == this.coordinates);
}

class AreasCompanion extends UpdateCompanion<Area> {
  final Value<int> id;
  final Value<int?> parentId;
  final Value<String> name;
  final Value<String> type;
  final Value<int> adminLevel;
  final Value<String> coordinates;
  const AreasCompanion({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.adminLevel = const Value.absent(),
    this.coordinates = const Value.absent(),
  });
  AreasCompanion.insert({
    this.id = const Value.absent(),
    this.parentId = const Value.absent(),
    required String name,
    required String type,
    required int adminLevel,
    required String coordinates,
  }) : name = Value(name),
       type = Value(type),
       adminLevel = Value(adminLevel),
       coordinates = Value(coordinates);
  static Insertable<Area> custom({
    Expression<int>? id,
    Expression<int>? parentId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? adminLevel,
    Expression<String>? coordinates,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentId != null) 'parent_id': parentId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (adminLevel != null) 'admin_level': adminLevel,
      if (coordinates != null) 'coordinates': coordinates,
    });
  }

  AreasCompanion copyWith({
    Value<int>? id,
    Value<int?>? parentId,
    Value<String>? name,
    Value<String>? type,
    Value<int>? adminLevel,
    Value<String>? coordinates,
  }) {
    return AreasCompanion(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      type: type ?? this.type,
      adminLevel: adminLevel ?? this.adminLevel,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<int>(parentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (adminLevel.present) {
      map['admin_level'] = Variable<int>(adminLevel.value);
    }
    if (coordinates.present) {
      map['coordinates'] = Variable<String>(coordinates.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AreasCompanion(')
          ..write('id: $id, ')
          ..write('parentId: $parentId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('adminLevel: $adminLevel, ')
          ..write('coordinates: $coordinates')
          ..write(')'))
        .toString();
  }
}

class $UserAreasTable extends UserAreas
    with TableInfo<$UserAreasTable, UserArea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES areas (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSpotsMeta = const VerificationMeta(
    'totalSpots',
  );
  @override
  late final GeneratedColumn<int> totalSpots = GeneratedColumn<int>(
    'total_spots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _visitedSpotsMeta = const VerificationMeta(
    'visitedSpots',
  );
  @override
  late final GeneratedColumn<int> visitedSpots = GeneratedColumn<int>(
    'visited_spots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    areaId,
    userId,
    totalSpots,
    visitedSpots,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_areas';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserArea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('total_spots')) {
      context.handle(
        _totalSpotsMeta,
        totalSpots.isAcceptableOrUnknown(data['total_spots']!, _totalSpotsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalSpotsMeta);
    }
    if (data.containsKey('visited_spots')) {
      context.handle(
        _visitedSpotsMeta,
        visitedSpots.isAcceptableOrUnknown(
          data['visited_spots']!,
          _visitedSpotsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_visitedSpotsMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {areaId, userId};
  @override
  UserArea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserArea(
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      totalSpots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_spots'],
      )!,
      visitedSpots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visited_spots'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $UserAreasTable createAlias(String alias) {
    return $UserAreasTable(attachedDatabase, alias);
  }
}

class UserArea extends DataClass implements Insertable<UserArea> {
  final int areaId;
  final String userId;
  final int totalSpots;
  final int visitedSpots;
  final DateTime? completedAt;
  const UserArea({
    required this.areaId,
    required this.userId,
    required this.totalSpots,
    required this.visitedSpots,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['area_id'] = Variable<int>(areaId);
    map['user_id'] = Variable<String>(userId);
    map['total_spots'] = Variable<int>(totalSpots);
    map['visited_spots'] = Variable<int>(visitedSpots);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  UserAreasCompanion toCompanion(bool nullToAbsent) {
    return UserAreasCompanion(
      areaId: Value(areaId),
      userId: Value(userId),
      totalSpots: Value(totalSpots),
      visitedSpots: Value(visitedSpots),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory UserArea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserArea(
      areaId: serializer.fromJson<int>(json['areaId']),
      userId: serializer.fromJson<String>(json['userId']),
      totalSpots: serializer.fromJson<int>(json['totalSpots']),
      visitedSpots: serializer.fromJson<int>(json['visitedSpots']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  factory UserArea.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => UserArea.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'areaId': serializer.toJson<int>(areaId),
      'userId': serializer.toJson<String>(userId),
      'totalSpots': serializer.toJson<int>(totalSpots),
      'visitedSpots': serializer.toJson<int>(visitedSpots),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  UserArea copyWith({
    int? areaId,
    String? userId,
    int? totalSpots,
    int? visitedSpots,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => UserArea(
    areaId: areaId ?? this.areaId,
    userId: userId ?? this.userId,
    totalSpots: totalSpots ?? this.totalSpots,
    visitedSpots: visitedSpots ?? this.visitedSpots,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  UserArea copyWithCompanion(UserAreasCompanion data) {
    return UserArea(
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
      userId: data.userId.present ? data.userId.value : this.userId,
      totalSpots: data.totalSpots.present
          ? data.totalSpots.value
          : this.totalSpots,
      visitedSpots: data.visitedSpots.present
          ? data.visitedSpots.value
          : this.visitedSpots,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserArea(')
          ..write('areaId: $areaId, ')
          ..write('userId: $userId, ')
          ..write('totalSpots: $totalSpots, ')
          ..write('visitedSpots: $visitedSpots, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(areaId, userId, totalSpots, visitedSpots, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserArea &&
          other.areaId == this.areaId &&
          other.userId == this.userId &&
          other.totalSpots == this.totalSpots &&
          other.visitedSpots == this.visitedSpots &&
          other.completedAt == this.completedAt);
}

class UserAreasCompanion extends UpdateCompanion<UserArea> {
  final Value<int> areaId;
  final Value<String> userId;
  final Value<int> totalSpots;
  final Value<int> visitedSpots;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const UserAreasCompanion({
    this.areaId = const Value.absent(),
    this.userId = const Value.absent(),
    this.totalSpots = const Value.absent(),
    this.visitedSpots = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAreasCompanion.insert({
    required int areaId,
    required String userId,
    required int totalSpots,
    required int visitedSpots,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : areaId = Value(areaId),
       userId = Value(userId),
       totalSpots = Value(totalSpots),
       visitedSpots = Value(visitedSpots);
  static Insertable<UserArea> custom({
    Expression<int>? areaId,
    Expression<String>? userId,
    Expression<int>? totalSpots,
    Expression<int>? visitedSpots,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (areaId != null) 'area_id': areaId,
      if (userId != null) 'user_id': userId,
      if (totalSpots != null) 'total_spots': totalSpots,
      if (visitedSpots != null) 'visited_spots': visitedSpots,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAreasCompanion copyWith({
    Value<int>? areaId,
    Value<String>? userId,
    Value<int>? totalSpots,
    Value<int>? visitedSpots,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return UserAreasCompanion(
      areaId: areaId ?? this.areaId,
      userId: userId ?? this.userId,
      totalSpots: totalSpots ?? this.totalSpots,
      visitedSpots: visitedSpots ?? this.visitedSpots,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (totalSpots.present) {
      map['total_spots'] = Variable<int>(totalSpots.value);
    }
    if (visitedSpots.present) {
      map['visited_spots'] = Variable<int>(visitedSpots.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAreasCompanion(')
          ..write('areaId: $areaId, ')
          ..write('userId: $userId, ')
          ..write('totalSpots: $totalSpots, ')
          ..write('visitedSpots: $visitedSpots, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CitiesTable extends Cities with TableInfo<$CitiesTable, City> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overpassAreaIdMeta = const VerificationMeta(
    'overpassAreaId',
  );
  @override
  late final GeneratedColumn<int> overpassAreaId = GeneratedColumn<int>(
    'overpass_area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hierarchyAdminLevelsMeta =
      const VerificationMeta('hierarchyAdminLevels');
  @override
  late final GeneratedColumn<String> hierarchyAdminLevels =
      GeneratedColumn<String>(
        'hierarchy_admin_levels',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    overpassAreaId,
    hierarchyAdminLevels,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cities';
  @override
  VerificationContext validateIntegrity(
    Insertable<City> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('overpass_area_id')) {
      context.handle(
        _overpassAreaIdMeta,
        overpassAreaId.isAcceptableOrUnknown(
          data['overpass_area_id']!,
          _overpassAreaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overpassAreaIdMeta);
    }
    if (data.containsKey('hierarchy_admin_levels')) {
      context.handle(
        _hierarchyAdminLevelsMeta,
        hierarchyAdminLevels.isAcceptableOrUnknown(
          data['hierarchy_admin_levels']!,
          _hierarchyAdminLevelsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hierarchyAdminLevelsMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  City map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return City(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      overpassAreaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}overpass_area_id'],
      )!,
      hierarchyAdminLevels: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hierarchy_admin_levels'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $CitiesTable createAlias(String alias) {
    return $CitiesTable(attachedDatabase, alias);
  }
}

class City extends DataClass implements Insertable<City> {
  final String id;
  final String name;
  final int overpassAreaId;
  final String hierarchyAdminLevels;
  final bool isActive;
  const City({
    required this.id,
    required this.name,
    required this.overpassAreaId,
    required this.hierarchyAdminLevels,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['overpass_area_id'] = Variable<int>(overpassAreaId);
    map['hierarchy_admin_levels'] = Variable<String>(hierarchyAdminLevels);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CitiesCompanion toCompanion(bool nullToAbsent) {
    return CitiesCompanion(
      id: Value(id),
      name: Value(name),
      overpassAreaId: Value(overpassAreaId),
      hierarchyAdminLevels: Value(hierarchyAdminLevels),
      isActive: Value(isActive),
    );
  }

  factory City.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return City(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      overpassAreaId: serializer.fromJson<int>(json['overpassAreaId']),
      hierarchyAdminLevels: serializer.fromJson<String>(
        json['hierarchyAdminLevels'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  factory City.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => City.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'overpassAreaId': serializer.toJson<int>(overpassAreaId),
      'hierarchyAdminLevels': serializer.toJson<String>(hierarchyAdminLevels),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  City copyWith({
    String? id,
    String? name,
    int? overpassAreaId,
    String? hierarchyAdminLevels,
    bool? isActive,
  }) => City(
    id: id ?? this.id,
    name: name ?? this.name,
    overpassAreaId: overpassAreaId ?? this.overpassAreaId,
    hierarchyAdminLevels: hierarchyAdminLevels ?? this.hierarchyAdminLevels,
    isActive: isActive ?? this.isActive,
  );
  City copyWithCompanion(CitiesCompanion data) {
    return City(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      overpassAreaId: data.overpassAreaId.present
          ? data.overpassAreaId.value
          : this.overpassAreaId,
      hierarchyAdminLevels: data.hierarchyAdminLevels.present
          ? data.hierarchyAdminLevels.value
          : this.hierarchyAdminLevels,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('City(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('overpassAreaId: $overpassAreaId, ')
          ..write('hierarchyAdminLevels: $hierarchyAdminLevels, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, overpassAreaId, hierarchyAdminLevels, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is City &&
          other.id == this.id &&
          other.name == this.name &&
          other.overpassAreaId == this.overpassAreaId &&
          other.hierarchyAdminLevels == this.hierarchyAdminLevels &&
          other.isActive == this.isActive);
}

class CitiesCompanion extends UpdateCompanion<City> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> overpassAreaId;
  final Value<String> hierarchyAdminLevels;
  final Value<bool> isActive;
  final Value<int> rowid;
  const CitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.overpassAreaId = const Value.absent(),
    this.hierarchyAdminLevels = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CitiesCompanion.insert({
    required String id,
    required String name,
    required int overpassAreaId,
    required String hierarchyAdminLevels,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       overpassAreaId = Value(overpassAreaId),
       hierarchyAdminLevels = Value(hierarchyAdminLevels);
  static Insertable<City> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? overpassAreaId,
    Expression<String>? hierarchyAdminLevels,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (overpassAreaId != null) 'overpass_area_id': overpassAreaId,
      if (hierarchyAdminLevels != null)
        'hierarchy_admin_levels': hierarchyAdminLevels,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? overpassAreaId,
    Value<String>? hierarchyAdminLevels,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return CitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      overpassAreaId: overpassAreaId ?? this.overpassAreaId,
      hierarchyAdminLevels: hierarchyAdminLevels ?? this.hierarchyAdminLevels,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (overpassAreaId.present) {
      map['overpass_area_id'] = Variable<int>(overpassAreaId.value);
    }
    if (hierarchyAdminLevels.present) {
      map['hierarchy_admin_levels'] = Variable<String>(
        hierarchyAdminLevels.value,
      );
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('overpassAreaId: $overpassAreaId, ')
          ..write('hierarchyAdminLevels: $hierarchyAdminLevels, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpotsTable extends Spots with TableInfo<$SpotsTable, Spot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentAreaIdMeta = const VerificationMeta(
    'parentAreaId',
  );
  @override
  late final GeneratedColumn<int> parentAreaId = GeneratedColumn<int>(
    'parent_area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES areas (id)',
    ),
  );
  static const VerificationMeta _spotTypeMeta = const VerificationMeta(
    'spotType',
  );
  @override
  late final GeneratedColumn<String> spotType = GeneratedColumn<String>(
    'spot_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _propertiesMeta = const VerificationMeta(
    'properties',
  );
  @override
  late final GeneratedColumn<String> properties = GeneratedColumn<String>(
    'properties',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    lat,
    lon,
    parentAreaId,
    spotType,
    status,
    createdBy,
    properties,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spots';
  @override
  VerificationContext validateIntegrity(
    Insertable<Spot> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('parent_area_id')) {
      context.handle(
        _parentAreaIdMeta,
        parentAreaId.isAcceptableOrUnknown(
          data['parent_area_id']!,
          _parentAreaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parentAreaIdMeta);
    }
    if (data.containsKey('spot_type')) {
      context.handle(
        _spotTypeMeta,
        spotType.isAcceptableOrUnknown(data['spot_type']!, _spotTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_spotTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('properties')) {
      context.handle(
        _propertiesMeta,
        properties.isAcceptableOrUnknown(data['properties']!, _propertiesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spot(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      parentAreaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_area_id'],
      )!,
      spotType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spot_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      properties: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}properties'],
      ),
    );
  }

  @override
  $SpotsTable createAlias(String alias) {
    return $SpotsTable(attachedDatabase, alias);
  }
}

class Spot extends DataClass implements Insertable<Spot> {
  final int id;
  final String name;
  final String category;
  final double lat;
  final double lon;
  final int parentAreaId;
  final String spotType;
  final String status;
  final String? createdBy;
  final String? properties;
  const Spot({
    required this.id,
    required this.name,
    required this.category,
    required this.lat,
    required this.lon,
    required this.parentAreaId,
    required this.spotType,
    required this.status,
    this.createdBy,
    this.properties,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['parent_area_id'] = Variable<int>(parentAreaId);
    map['spot_type'] = Variable<String>(spotType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || properties != null) {
      map['properties'] = Variable<String>(properties);
    }
    return map;
  }

  SpotsCompanion toCompanion(bool nullToAbsent) {
    return SpotsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      lat: Value(lat),
      lon: Value(lon),
      parentAreaId: Value(parentAreaId),
      spotType: Value(spotType),
      status: Value(status),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      properties: properties == null && nullToAbsent
          ? const Value.absent()
          : Value(properties),
    );
  }

  factory Spot.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spot(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      parentAreaId: serializer.fromJson<int>(json['parentAreaId']),
      spotType: serializer.fromJson<String>(json['spotType']),
      status: serializer.fromJson<String>(json['status']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      properties: serializer.fromJson<String?>(json['properties']),
    );
  }
  factory Spot.fromJsonString(
    String encodedJson, {
    ValueSerializer? serializer,
  }) => Spot.fromJson(
    DataClass.parseJson(encodedJson) as Map<String, dynamic>,
    serializer: serializer,
  );
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'parentAreaId': serializer.toJson<int>(parentAreaId),
      'spotType': serializer.toJson<String>(spotType),
      'status': serializer.toJson<String>(status),
      'createdBy': serializer.toJson<String?>(createdBy),
      'properties': serializer.toJson<String?>(properties),
    };
  }

  Spot copyWith({
    int? id,
    String? name,
    String? category,
    double? lat,
    double? lon,
    int? parentAreaId,
    String? spotType,
    String? status,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> properties = const Value.absent(),
  }) => Spot(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    parentAreaId: parentAreaId ?? this.parentAreaId,
    spotType: spotType ?? this.spotType,
    status: status ?? this.status,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    properties: properties.present ? properties.value : this.properties,
  );
  Spot copyWithCompanion(SpotsCompanion data) {
    return Spot(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      parentAreaId: data.parentAreaId.present
          ? data.parentAreaId.value
          : this.parentAreaId,
      spotType: data.spotType.present ? data.spotType.value : this.spotType,
      status: data.status.present ? data.status.value : this.status,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      properties: data.properties.present
          ? data.properties.value
          : this.properties,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spot(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('parentAreaId: $parentAreaId, ')
          ..write('spotType: $spotType, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('properties: $properties')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    lat,
    lon,
    parentAreaId,
    spotType,
    status,
    createdBy,
    properties,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spot &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.parentAreaId == this.parentAreaId &&
          other.spotType == this.spotType &&
          other.status == this.status &&
          other.createdBy == this.createdBy &&
          other.properties == this.properties);
}

class SpotsCompanion extends UpdateCompanion<Spot> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<double> lat;
  final Value<double> lon;
  final Value<int> parentAreaId;
  final Value<String> spotType;
  final Value<String> status;
  final Value<String?> createdBy;
  final Value<String?> properties;
  const SpotsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.parentAreaId = const Value.absent(),
    this.spotType = const Value.absent(),
    this.status = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.properties = const Value.absent(),
  });
  SpotsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required double lat,
    required double lon,
    required int parentAreaId,
    required String spotType,
    required String status,
    this.createdBy = const Value.absent(),
    this.properties = const Value.absent(),
  }) : name = Value(name),
       category = Value(category),
       lat = Value(lat),
       lon = Value(lon),
       parentAreaId = Value(parentAreaId),
       spotType = Value(spotType),
       status = Value(status);
  static Insertable<Spot> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<int>? parentAreaId,
    Expression<String>? spotType,
    Expression<String>? status,
    Expression<String>? createdBy,
    Expression<String>? properties,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (parentAreaId != null) 'parent_area_id': parentAreaId,
      if (spotType != null) 'spot_type': spotType,
      if (status != null) 'status': status,
      if (createdBy != null) 'created_by': createdBy,
      if (properties != null) 'properties': properties,
    });
  }

  SpotsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<double>? lat,
    Value<double>? lon,
    Value<int>? parentAreaId,
    Value<String>? spotType,
    Value<String>? status,
    Value<String?>? createdBy,
    Value<String?>? properties,
  }) {
    return SpotsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      parentAreaId: parentAreaId ?? this.parentAreaId,
      spotType: spotType ?? this.spotType,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      properties: properties ?? this.properties,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (parentAreaId.present) {
      map['parent_area_id'] = Variable<int>(parentAreaId.value);
    }
    if (spotType.present) {
      map['spot_type'] = Variable<String>(spotType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (properties.present) {
      map['properties'] = Variable<String>(properties.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpotsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('parentAreaId: $parentAreaId, ')
          ..write('spotType: $spotType, ')
          ..write('status: $status, ')
          ..write('createdBy: $createdBy, ')
          ..write('properties: $properties')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final $AreasTable areas = $AreasTable(this);
  late final $UserAreasTable userAreas = $UserAreasTable(this);
  late final $CitiesTable cities = $CitiesTable(this);
  late final $SpotsTable spots = $SpotsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    checkIns,
    areas,
    userAreas,
    cities,
    spots,
  ];
}

typedef $$CheckInsTableCreateCompanionBuilder =
    CheckInsCompanion Function({
      required String id,
      required String userId,
      required int spotId,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$CheckInsTableUpdateCompanionBuilder =
    CheckInsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<int> spotId,
      Value<DateTime> updatedAt,
      Value<DateTime?> syncedAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$CheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spotId => $composableBuilder(
    column: $table.spotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spotId => $composableBuilder(
    column: $table.spotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get spotId =>
      $composableBuilder(column: $table.spotId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInsTable,
          CheckIn,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (CheckIn, BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn>),
          CheckIn,
          PrefetchHooks Function()
        > {
  $$CheckInsTableTableManager(_$AppDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> spotId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion(
                id: id,
                userId: userId,
                spotId: spotId,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required int spotId,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion.insert(
                id: id,
                userId: userId,
                spotId: spotId,
                updatedAt: updatedAt,
                syncedAt: syncedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInsTable,
      CheckIn,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (CheckIn, BaseReferences<_$AppDatabase, $CheckInsTable, CheckIn>),
      CheckIn,
      PrefetchHooks Function()
    >;
typedef $$AreasTableCreateCompanionBuilder =
    AreasCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      required String name,
      required String type,
      required int adminLevel,
      required String coordinates,
    });
typedef $$AreasTableUpdateCompanionBuilder =
    AreasCompanion Function({
      Value<int> id,
      Value<int?> parentId,
      Value<String> name,
      Value<String> type,
      Value<int> adminLevel,
      Value<String> coordinates,
    });

final class $$AreasTableReferences
    extends BaseReferences<_$AppDatabase, $AreasTable, Area> {
  $$AreasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AreasTable _parentIdTable(_$AppDatabase db) => db.areas.createAlias(
    $_aliasNameGenerator(db.areas.parentId, db.areas.id),
  );

  $$AreasTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<int>('parent_id');
    if ($_column == null) return null;
    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$UserAreasTable, List<UserArea>>
  _userAreasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAreas,
    aliasName: $_aliasNameGenerator(db.areas.id, db.userAreas.areaId),
  );

  $$UserAreasTableProcessedTableManager get userAreasRefs {
    final manager = $$UserAreasTableTableManager(
      $_db,
      $_db.userAreas,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAreasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SpotsTable, List<Spot>> _spotsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.spots,
    aliasName: $_aliasNameGenerator(db.areas.id, db.spots.parentAreaId),
  );

  $$SpotsTableProcessedTableManager get spotsRefs {
    final manager = $$SpotsTableTableManager(
      $_db,
      $_db.spots,
    ).filter((f) => f.parentAreaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_spotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AreasTableFilterComposer extends Composer<_$AppDatabase, $AreasTable> {
  $$AreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adminLevel => $composableBuilder(
    column: $table.adminLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coordinates => $composableBuilder(
    column: $table.coordinates,
    builder: (column) => ColumnFilters(column),
  );

  $$AreasTableFilterComposer get parentId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> userAreasRefs(
    Expression<bool> Function($$UserAreasTableFilterComposer f) f,
  ) {
    final $$UserAreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAreas,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAreasTableFilterComposer(
            $db: $db,
            $table: $db.userAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> spotsRefs(
    Expression<bool> Function($$SpotsTableFilterComposer f) f,
  ) {
    final $$SpotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spots,
      getReferencedColumn: (t) => t.parentAreaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpotsTableFilterComposer(
            $db: $db,
            $table: $db.spots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreasTableOrderingComposer
    extends Composer<_$AppDatabase, $AreasTable> {
  $$AreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adminLevel => $composableBuilder(
    column: $table.adminLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coordinates => $composableBuilder(
    column: $table.coordinates,
    builder: (column) => ColumnOrderings(column),
  );

  $$AreasTableOrderingComposer get parentId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AreasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AreasTable> {
  $$AreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get adminLevel => $composableBuilder(
    column: $table.adminLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coordinates => $composableBuilder(
    column: $table.coordinates,
    builder: (column) => column,
  );

  $$AreasTableAnnotationComposer get parentId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> userAreasRefs<T extends Object>(
    Expression<T> Function($$UserAreasTableAnnotationComposer a) f,
  ) {
    final $$UserAreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAreas,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAreasTableAnnotationComposer(
            $db: $db,
            $table: $db.userAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> spotsRefs<T extends Object>(
    Expression<T> Function($$SpotsTableAnnotationComposer a) f,
  ) {
    final $$SpotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.spots,
      getReferencedColumn: (t) => t.parentAreaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpotsTableAnnotationComposer(
            $db: $db,
            $table: $db.spots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AreasTable,
          Area,
          $$AreasTableFilterComposer,
          $$AreasTableOrderingComposer,
          $$AreasTableAnnotationComposer,
          $$AreasTableCreateCompanionBuilder,
          $$AreasTableUpdateCompanionBuilder,
          (Area, $$AreasTableReferences),
          Area,
          PrefetchHooks Function({
            bool parentId,
            bool userAreasRefs,
            bool spotsRefs,
          })
        > {
  $$AreasTableTableManager(_$AppDatabase db, $AreasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AreasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AreasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> adminLevel = const Value.absent(),
                Value<String> coordinates = const Value.absent(),
              }) => AreasCompanion(
                id: id,
                parentId: parentId,
                name: name,
                type: type,
                adminLevel: adminLevel,
                coordinates: coordinates,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> parentId = const Value.absent(),
                required String name,
                required String type,
                required int adminLevel,
                required String coordinates,
              }) => AreasCompanion.insert(
                id: id,
                parentId: parentId,
                name: name,
                type: type,
                adminLevel: adminLevel,
                coordinates: coordinates,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AreasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({parentId = false, userAreasRefs = false, spotsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userAreasRefs) db.userAreas,
                    if (spotsRefs) db.spots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.parentId,
                                    referencedTable: $$AreasTableReferences
                                        ._parentIdTable(db),
                                    referencedColumn: $$AreasTableReferences
                                        ._parentIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userAreasRefs)
                        await $_getPrefetchedData<Area, $AreasTable, UserArea>(
                          currentTable: table,
                          referencedTable: $$AreasTableReferences
                              ._userAreasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreasTableReferences(
                                db,
                                table,
                                p0,
                              ).userAreasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (spotsRefs)
                        await $_getPrefetchedData<Area, $AreasTable, Spot>(
                          currentTable: table,
                          referencedTable: $$AreasTableReferences
                              ._spotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreasTableReferences(db, table, p0).spotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.parentAreaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AreasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AreasTable,
      Area,
      $$AreasTableFilterComposer,
      $$AreasTableOrderingComposer,
      $$AreasTableAnnotationComposer,
      $$AreasTableCreateCompanionBuilder,
      $$AreasTableUpdateCompanionBuilder,
      (Area, $$AreasTableReferences),
      Area,
      PrefetchHooks Function({
        bool parentId,
        bool userAreasRefs,
        bool spotsRefs,
      })
    >;
typedef $$UserAreasTableCreateCompanionBuilder =
    UserAreasCompanion Function({
      required int areaId,
      required String userId,
      required int totalSpots,
      required int visitedSpots,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$UserAreasTableUpdateCompanionBuilder =
    UserAreasCompanion Function({
      Value<int> areaId,
      Value<String> userId,
      Value<int> totalSpots,
      Value<int> visitedSpots,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

final class $$UserAreasTableReferences
    extends BaseReferences<_$AppDatabase, $UserAreasTable, UserArea> {
  $$UserAreasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AreasTable _areaIdTable(_$AppDatabase db) => db.areas.createAlias(
    $_aliasNameGenerator(db.userAreas.areaId, db.areas.id),
  );

  $$AreasTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAreasTableFilterComposer
    extends Composer<_$AppDatabase, $UserAreasTable> {
  $$UserAreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSpots => $composableBuilder(
    column: $table.totalSpots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visitedSpots => $composableBuilder(
    column: $table.visitedSpots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AreasTableFilterComposer get areaId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAreasTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAreasTable> {
  $$UserAreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSpots => $composableBuilder(
    column: $table.totalSpots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visitedSpots => $composableBuilder(
    column: $table.visitedSpots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AreasTableOrderingComposer get areaId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAreasTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAreasTable> {
  $$UserAreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get totalSpots => $composableBuilder(
    column: $table.totalSpots,
    builder: (column) => column,
  );

  GeneratedColumn<int> get visitedSpots => $composableBuilder(
    column: $table.visitedSpots,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$AreasTableAnnotationComposer get areaId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAreasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAreasTable,
          UserArea,
          $$UserAreasTableFilterComposer,
          $$UserAreasTableOrderingComposer,
          $$UserAreasTableAnnotationComposer,
          $$UserAreasTableCreateCompanionBuilder,
          $$UserAreasTableUpdateCompanionBuilder,
          (UserArea, $$UserAreasTableReferences),
          UserArea,
          PrefetchHooks Function({bool areaId})
        > {
  $$UserAreasTableTableManager(_$AppDatabase db, $UserAreasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAreasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAreasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> areaId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> totalSpots = const Value.absent(),
                Value<int> visitedSpots = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAreasCompanion(
                areaId: areaId,
                userId: userId,
                totalSpots: totalSpots,
                visitedSpots: visitedSpots,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int areaId,
                required String userId,
                required int totalSpots,
                required int visitedSpots,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAreasCompanion.insert(
                areaId: areaId,
                userId: userId,
                totalSpots: totalSpots,
                visitedSpots: visitedSpots,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserAreasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({areaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (areaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaId,
                                referencedTable: $$UserAreasTableReferences
                                    ._areaIdTable(db),
                                referencedColumn: $$UserAreasTableReferences
                                    ._areaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserAreasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAreasTable,
      UserArea,
      $$UserAreasTableFilterComposer,
      $$UserAreasTableOrderingComposer,
      $$UserAreasTableAnnotationComposer,
      $$UserAreasTableCreateCompanionBuilder,
      $$UserAreasTableUpdateCompanionBuilder,
      (UserArea, $$UserAreasTableReferences),
      UserArea,
      PrefetchHooks Function({bool areaId})
    >;
typedef $$CitiesTableCreateCompanionBuilder =
    CitiesCompanion Function({
      required String id,
      required String name,
      required int overpassAreaId,
      required String hierarchyAdminLevels,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$CitiesTableUpdateCompanionBuilder =
    CitiesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> overpassAreaId,
      Value<String> hierarchyAdminLevels,
      Value<bool> isActive,
      Value<int> rowid,
    });

class $$CitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get overpassAreaId => $composableBuilder(
    column: $table.overpassAreaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hierarchyAdminLevels => $composableBuilder(
    column: $table.hierarchyAdminLevels,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overpassAreaId => $composableBuilder(
    column: $table.overpassAreaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hierarchyAdminLevels => $composableBuilder(
    column: $table.hierarchyAdminLevels,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get overpassAreaId => $composableBuilder(
    column: $table.overpassAreaId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hierarchyAdminLevels => $composableBuilder(
    column: $table.hierarchyAdminLevels,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$CitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CitiesTable,
          City,
          $$CitiesTableFilterComposer,
          $$CitiesTableOrderingComposer,
          $$CitiesTableAnnotationComposer,
          $$CitiesTableCreateCompanionBuilder,
          $$CitiesTableUpdateCompanionBuilder,
          (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
          City,
          PrefetchHooks Function()
        > {
  $$CitiesTableTableManager(_$AppDatabase db, $CitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> overpassAreaId = const Value.absent(),
                Value<String> hierarchyAdminLevels = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CitiesCompanion(
                id: id,
                name: name,
                overpassAreaId: overpassAreaId,
                hierarchyAdminLevels: hierarchyAdminLevels,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int overpassAreaId,
                required String hierarchyAdminLevels,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CitiesCompanion.insert(
                id: id,
                name: name,
                overpassAreaId: overpassAreaId,
                hierarchyAdminLevels: hierarchyAdminLevels,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CitiesTable,
      City,
      $$CitiesTableFilterComposer,
      $$CitiesTableOrderingComposer,
      $$CitiesTableAnnotationComposer,
      $$CitiesTableCreateCompanionBuilder,
      $$CitiesTableUpdateCompanionBuilder,
      (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
      City,
      PrefetchHooks Function()
    >;
typedef $$SpotsTableCreateCompanionBuilder =
    SpotsCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      required double lat,
      required double lon,
      required int parentAreaId,
      required String spotType,
      required String status,
      Value<String?> createdBy,
      Value<String?> properties,
    });
typedef $$SpotsTableUpdateCompanionBuilder =
    SpotsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<double> lat,
      Value<double> lon,
      Value<int> parentAreaId,
      Value<String> spotType,
      Value<String> status,
      Value<String?> createdBy,
      Value<String?> properties,
    });

final class $$SpotsTableReferences
    extends BaseReferences<_$AppDatabase, $SpotsTable, Spot> {
  $$SpotsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AreasTable _parentAreaIdTable(_$AppDatabase db) => db.areas
      .createAlias($_aliasNameGenerator(db.spots.parentAreaId, db.areas.id));

  $$AreasTableProcessedTableManager get parentAreaId {
    final $_column = $_itemColumn<int>('parent_area_id')!;

    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentAreaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SpotsTableFilterComposer extends Composer<_$AppDatabase, $SpotsTable> {
  $$SpotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spotType => $composableBuilder(
    column: $table.spotType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get properties => $composableBuilder(
    column: $table.properties,
    builder: (column) => ColumnFilters(column),
  );

  $$AreasTableFilterComposer get parentAreaId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAreaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpotsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpotsTable> {
  $$SpotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spotType => $composableBuilder(
    column: $table.spotType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get properties => $composableBuilder(
    column: $table.properties,
    builder: (column) => ColumnOrderings(column),
  );

  $$AreasTableOrderingComposer get parentAreaId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAreaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpotsTable> {
  $$SpotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get spotType =>
      $composableBuilder(column: $table.spotType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get properties => $composableBuilder(
    column: $table.properties,
    builder: (column) => column,
  );

  $$AreasTableAnnotationComposer get parentAreaId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentAreaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpotsTable,
          Spot,
          $$SpotsTableFilterComposer,
          $$SpotsTableOrderingComposer,
          $$SpotsTableAnnotationComposer,
          $$SpotsTableCreateCompanionBuilder,
          $$SpotsTableUpdateCompanionBuilder,
          (Spot, $$SpotsTableReferences),
          Spot,
          PrefetchHooks Function({bool parentAreaId})
        > {
  $$SpotsTableTableManager(_$AppDatabase db, $SpotsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<int> parentAreaId = const Value.absent(),
                Value<String> spotType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> properties = const Value.absent(),
              }) => SpotsCompanion(
                id: id,
                name: name,
                category: category,
                lat: lat,
                lon: lon,
                parentAreaId: parentAreaId,
                spotType: spotType,
                status: status,
                createdBy: createdBy,
                properties: properties,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                required double lat,
                required double lon,
                required int parentAreaId,
                required String spotType,
                required String status,
                Value<String?> createdBy = const Value.absent(),
                Value<String?> properties = const Value.absent(),
              }) => SpotsCompanion.insert(
                id: id,
                name: name,
                category: category,
                lat: lat,
                lon: lon,
                parentAreaId: parentAreaId,
                spotType: spotType,
                status: status,
                createdBy: createdBy,
                properties: properties,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SpotsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({parentAreaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentAreaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentAreaId,
                                referencedTable: $$SpotsTableReferences
                                    ._parentAreaIdTable(db),
                                referencedColumn: $$SpotsTableReferences
                                    ._parentAreaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SpotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpotsTable,
      Spot,
      $$SpotsTableFilterComposer,
      $$SpotsTableOrderingComposer,
      $$SpotsTableAnnotationComposer,
      $$SpotsTableCreateCompanionBuilder,
      $$SpotsTableUpdateCompanionBuilder,
      (Spot, $$SpotsTableReferences),
      Spot,
      PrefetchHooks Function({bool parentAreaId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
  $$AreasTableTableManager get areas =>
      $$AreasTableTableManager(_db, _db.areas);
  $$UserAreasTableTableManager get userAreas =>
      $$UserAreasTableTableManager(_db, _db.userAreas);
  $$CitiesTableTableManager get cities =>
      $$CitiesTableTableManager(_db, _db.cities);
  $$SpotsTableTableManager get spots =>
      $$SpotsTableTableManager(_db, _db.spots);
}
