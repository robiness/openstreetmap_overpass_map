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

UserSpotData _$UserSpotDataFromJson(Map<String, dynamic> json) {
  return _UserSpotData.fromJson(json);
}

/// @nodoc
mixin _$UserSpotData {
  int get spotId => throw _privateConstructorUsedError;
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
    int spotId,
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
                      as int,
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
    int spotId,
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
                  as int,
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
  final int spotId;
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
    required final int spotId,
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
  int get spotId;
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
