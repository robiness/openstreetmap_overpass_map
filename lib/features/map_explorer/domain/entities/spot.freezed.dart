// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Spot _$SpotFromJson(Map<String, dynamic> json) {
  return _Spot.fromJson(json);
}

/// @nodoc
mixin _$Spot {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @LatLngConverter()
  LatLng get location => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get createdBy => throw _privateConstructorUsedError;
  Map<String, dynamic> get properties => throw _privateConstructorUsedError;
  String? get parentAreaId => throw _privateConstructorUsedError;

  /// Serializes this Spot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpotCopyWith<Spot> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpotCopyWith<$Res> {
  factory $SpotCopyWith(Spot value, $Res Function(Spot) then) =
      _$SpotCopyWithImpl<$Res, Spot>;
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    @LatLngConverter() LatLng location,
    String? description,
    List<String> tags,
    DateTime createdAt,
    String? createdBy,
    Map<String, dynamic> properties,
    String? parentAreaId,
  });
}

/// @nodoc
class _$SpotCopyWithImpl<$Res, $Val extends Spot>
    implements $SpotCopyWith<$Res> {
  _$SpotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? location = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? createdBy = freezed,
    Object? properties = null,
    Object? parentAreaId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            location: null == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as LatLng,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String?,
            properties: null == properties
                ? _value.properties
                : properties // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            parentAreaId: freezed == parentAreaId
                ? _value.parentAreaId
                : parentAreaId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpotImplCopyWith<$Res> implements $SpotCopyWith<$Res> {
  factory _$$SpotImplCopyWith(
    _$SpotImpl value,
    $Res Function(_$SpotImpl) then,
  ) = __$$SpotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String category,
    @LatLngConverter() LatLng location,
    String? description,
    List<String> tags,
    DateTime createdAt,
    String? createdBy,
    Map<String, dynamic> properties,
    String? parentAreaId,
  });
}

/// @nodoc
class __$$SpotImplCopyWithImpl<$Res>
    extends _$SpotCopyWithImpl<$Res, _$SpotImpl>
    implements _$$SpotImplCopyWith<$Res> {
  __$$SpotImplCopyWithImpl(_$SpotImpl _value, $Res Function(_$SpotImpl) _then)
    : super(_value, _then);

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? location = null,
    Object? description = freezed,
    Object? tags = null,
    Object? createdAt = null,
    Object? createdBy = freezed,
    Object? properties = null,
    Object? parentAreaId = freezed,
  }) {
    return _then(
      _$SpotImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LatLng,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String?,
        properties: null == properties
            ? _value._properties
            : properties // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        parentAreaId: freezed == parentAreaId
            ? _value.parentAreaId
            : parentAreaId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpotImpl implements _Spot {
  const _$SpotImpl({
    required this.id,
    required this.name,
    required this.category,
    @LatLngConverter() required this.location,
    this.description,
    final List<String> tags = const [],
    required this.createdAt,
    this.createdBy,
    final Map<String, dynamic> properties = const {},
    this.parentAreaId,
  }) : _tags = tags,
       _properties = properties;

  factory _$SpotImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpotImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  @LatLngConverter()
  final LatLng location;
  @override
  final String? description;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime createdAt;
  @override
  final String? createdBy;
  final Map<String, dynamic> _properties;
  @override
  @JsonKey()
  Map<String, dynamic> get properties {
    if (_properties is EqualUnmodifiableMapView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_properties);
  }

  @override
  final String? parentAreaId;

  @override
  String toString() {
    return 'Spot(id: $id, name: $name, category: $category, location: $location, description: $description, tags: $tags, createdAt: $createdAt, createdBy: $createdBy, properties: $properties, parentAreaId: $parentAreaId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            const DeepCollectionEquality().equals(
              other._properties,
              _properties,
            ) &&
            (identical(other.parentAreaId, parentAreaId) ||
                other.parentAreaId == parentAreaId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    category,
    location,
    description,
    const DeepCollectionEquality().hash(_tags),
    createdAt,
    createdBy,
    const DeepCollectionEquality().hash(_properties),
    parentAreaId,
  );

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      __$$SpotImplCopyWithImpl<_$SpotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpotImplToJson(this);
  }
}

abstract class _Spot implements Spot {
  const factory _Spot({
    required final String id,
    required final String name,
    required final String category,
    @LatLngConverter() required final LatLng location,
    final String? description,
    final List<String> tags,
    required final DateTime createdAt,
    final String? createdBy,
    final Map<String, dynamic> properties,
    final String? parentAreaId,
  }) = _$SpotImpl;

  factory _Spot.fromJson(Map<String, dynamic> json) = _$SpotImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  @LatLngConverter()
  LatLng get location;
  @override
  String? get description;
  @override
  List<String> get tags;
  @override
  DateTime get createdAt;
  @override
  String? get createdBy;
  @override
  Map<String, dynamic> get properties;
  @override
  String? get parentAreaId;

  /// Create a copy of Spot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotImplCopyWith<_$SpotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSpotData _$UserSpotDataFromJson(Map<String, dynamic> json) {
  return _UserSpotData.fromJson(json);
}

/// @nodoc
mixin _$UserSpotData {
  String get spotId => throw _privateConstructorUsedError;
  int get visitCount => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  bool get isCheckedIn => throw _privateConstructorUsedError;
  DateTime? get lastVisited => throw _privateConstructorUsedError;
  double? get userRating => throw _privateConstructorUsedError; // 1-5 stars
  String? get userNotes => throw _privateConstructorUsedError;

  /// Serializes this UserSpotData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSpotData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSpotDataCopyWith<UserSpotData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSpotDataCopyWith<$Res> {
  factory $UserSpotDataCopyWith(
    UserSpotData value,
    $Res Function(UserSpotData) then,
  ) = _$UserSpotDataCopyWithImpl<$Res, UserSpotData>;
  @useResult
  $Res call({
    String spotId,
    int visitCount,
    bool isFavorite,
    bool isCheckedIn,
    DateTime? lastVisited,
    double? userRating,
    String? userNotes,
  });
}

/// @nodoc
class _$UserSpotDataCopyWithImpl<$Res, $Val extends UserSpotData>
    implements $UserSpotDataCopyWith<$Res> {
  _$UserSpotDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSpotData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spotId = null,
    Object? visitCount = null,
    Object? isFavorite = null,
    Object? isCheckedIn = null,
    Object? lastVisited = freezed,
    Object? userRating = freezed,
    Object? userNotes = freezed,
  }) {
    return _then(
      _value.copyWith(
            spotId: null == spotId
                ? _value.spotId
                : spotId // ignore: cast_nullable_to_non_nullable
                      as String,
            visitCount: null == visitCount
                ? _value.visitCount
                : visitCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCheckedIn: null == isCheckedIn
                ? _value.isCheckedIn
                : isCheckedIn // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastVisited: freezed == lastVisited
                ? _value.lastVisited
                : lastVisited // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            userRating: freezed == userRating
                ? _value.userRating
                : userRating // ignore: cast_nullable_to_non_nullable
                      as double?,
            userNotes: freezed == userNotes
                ? _value.userNotes
                : userNotes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserSpotDataImplCopyWith<$Res>
    implements $UserSpotDataCopyWith<$Res> {
  factory _$$UserSpotDataImplCopyWith(
    _$UserSpotDataImpl value,
    $Res Function(_$UserSpotDataImpl) then,
  ) = __$$UserSpotDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String spotId,
    int visitCount,
    bool isFavorite,
    bool isCheckedIn,
    DateTime? lastVisited,
    double? userRating,
    String? userNotes,
  });
}

/// @nodoc
class __$$UserSpotDataImplCopyWithImpl<$Res>
    extends _$UserSpotDataCopyWithImpl<$Res, _$UserSpotDataImpl>
    implements _$$UserSpotDataImplCopyWith<$Res> {
  __$$UserSpotDataImplCopyWithImpl(
    _$UserSpotDataImpl _value,
    $Res Function(_$UserSpotDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserSpotData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spotId = null,
    Object? visitCount = null,
    Object? isFavorite = null,
    Object? isCheckedIn = null,
    Object? lastVisited = freezed,
    Object? userRating = freezed,
    Object? userNotes = freezed,
  }) {
    return _then(
      _$UserSpotDataImpl(
        spotId: null == spotId
            ? _value.spotId
            : spotId // ignore: cast_nullable_to_non_nullable
                  as String,
        visitCount: null == visitCount
            ? _value.visitCount
            : visitCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCheckedIn: null == isCheckedIn
            ? _value.isCheckedIn
            : isCheckedIn // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastVisited: freezed == lastVisited
            ? _value.lastVisited
            : lastVisited // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        userRating: freezed == userRating
            ? _value.userRating
            : userRating // ignore: cast_nullable_to_non_nullable
                  as double?,
        userNotes: freezed == userNotes
            ? _value.userNotes
            : userNotes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSpotDataImpl implements _UserSpotData {
  const _$UserSpotDataImpl({
    required this.spotId,
    this.visitCount = 0,
    this.isFavorite = false,
    this.isCheckedIn = false,
    this.lastVisited,
    this.userRating,
    this.userNotes,
  });

  factory _$UserSpotDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSpotDataImplFromJson(json);

  @override
  final String spotId;
  @override
  @JsonKey()
  final int visitCount;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @JsonKey()
  final bool isCheckedIn;
  @override
  final DateTime? lastVisited;
  @override
  final double? userRating;
  // 1-5 stars
  @override
  final String? userNotes;

  @override
  String toString() {
    return 'UserSpotData(spotId: $spotId, visitCount: $visitCount, isFavorite: $isFavorite, isCheckedIn: $isCheckedIn, lastVisited: $lastVisited, userRating: $userRating, userNotes: $userNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSpotDataImpl &&
            (identical(other.spotId, spotId) || other.spotId == spotId) &&
            (identical(other.visitCount, visitCount) ||
                other.visitCount == visitCount) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.isCheckedIn, isCheckedIn) ||
                other.isCheckedIn == isCheckedIn) &&
            (identical(other.lastVisited, lastVisited) ||
                other.lastVisited == lastVisited) &&
            (identical(other.userRating, userRating) ||
                other.userRating == userRating) &&
            (identical(other.userNotes, userNotes) ||
                other.userNotes == userNotes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    spotId,
    visitCount,
    isFavorite,
    isCheckedIn,
    lastVisited,
    userRating,
    userNotes,
  );

  /// Create a copy of UserSpotData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSpotDataImplCopyWith<_$UserSpotDataImpl> get copyWith =>
      __$$UserSpotDataImplCopyWithImpl<_$UserSpotDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSpotDataImplToJson(this);
  }
}

abstract class _UserSpotData implements UserSpotData {
  const factory _UserSpotData({
    required final String spotId,
    final int visitCount,
    final bool isFavorite,
    final bool isCheckedIn,
    final DateTime? lastVisited,
    final double? userRating,
    final String? userNotes,
  }) = _$UserSpotDataImpl;

  factory _UserSpotData.fromJson(Map<String, dynamic> json) =
      _$UserSpotDataImpl.fromJson;

  @override
  String get spotId;
  @override
  int get visitCount;
  @override
  bool get isFavorite;
  @override
  bool get isCheckedIn;
  @override
  DateTime? get lastVisited;
  @override
  double? get userRating; // 1-5 stars
  @override
  String? get userNotes;

  /// Create a copy of UserSpotData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSpotDataImplCopyWith<_$UserSpotDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
