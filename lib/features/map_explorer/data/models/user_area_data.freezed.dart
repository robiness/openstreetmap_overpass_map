// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_area_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserAreaData _$UserAreaDataFromJson(Map<String, dynamic> json) {
  return _UserAreaData.fromJson(json);
}

/// @nodoc
mixin _$UserAreaData {
  String get areaId => throw _privateConstructorUsedError;
  int get visitCount => throw _privateConstructorUsedError;
  DateTime? get lastVisited => throw _privateConstructorUsedError;
  int get totalSpots => throw _privateConstructorUsedError;
  int get visitedSpots => throw _privateConstructorUsedError;
  DateTime? get firstSpotVisit => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this UserAreaData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAreaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAreaDataCopyWith<UserAreaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAreaDataCopyWith<$Res> {
  factory $UserAreaDataCopyWith(
    UserAreaData value,
    $Res Function(UserAreaData) then,
  ) = _$UserAreaDataCopyWithImpl<$Res, UserAreaData>;
  @useResult
  $Res call({
    String areaId,
    int visitCount,
    DateTime? lastVisited,
    int totalSpots,
    int visitedSpots,
    DateTime? firstSpotVisit,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$UserAreaDataCopyWithImpl<$Res, $Val extends UserAreaData>
    implements $UserAreaDataCopyWith<$Res> {
  _$UserAreaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAreaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaId = null,
    Object? visitCount = null,
    Object? lastVisited = freezed,
    Object? totalSpots = null,
    Object? visitedSpots = null,
    Object? firstSpotVisit = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            areaId: null == areaId
                ? _value.areaId
                : areaId // ignore: cast_nullable_to_non_nullable
                      as String,
            visitCount: null == visitCount
                ? _value.visitCount
                : visitCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastVisited: freezed == lastVisited
                ? _value.lastVisited
                : lastVisited // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            totalSpots: null == totalSpots
                ? _value.totalSpots
                : totalSpots // ignore: cast_nullable_to_non_nullable
                      as int,
            visitedSpots: null == visitedSpots
                ? _value.visitedSpots
                : visitedSpots // ignore: cast_nullable_to_non_nullable
                      as int,
            firstSpotVisit: freezed == firstSpotVisit
                ? _value.firstSpotVisit
                : firstSpotVisit // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAreaDataImplCopyWith<$Res>
    implements $UserAreaDataCopyWith<$Res> {
  factory _$$UserAreaDataImplCopyWith(
    _$UserAreaDataImpl value,
    $Res Function(_$UserAreaDataImpl) then,
  ) = __$$UserAreaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String areaId,
    int visitCount,
    DateTime? lastVisited,
    int totalSpots,
    int visitedSpots,
    DateTime? firstSpotVisit,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$UserAreaDataImplCopyWithImpl<$Res>
    extends _$UserAreaDataCopyWithImpl<$Res, _$UserAreaDataImpl>
    implements _$$UserAreaDataImplCopyWith<$Res> {
  __$$UserAreaDataImplCopyWithImpl(
    _$UserAreaDataImpl _value,
    $Res Function(_$UserAreaDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAreaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaId = null,
    Object? visitCount = null,
    Object? lastVisited = freezed,
    Object? totalSpots = null,
    Object? visitedSpots = null,
    Object? firstSpotVisit = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$UserAreaDataImpl(
        areaId: null == areaId
            ? _value.areaId
            : areaId // ignore: cast_nullable_to_non_nullable
                  as String,
        visitCount: null == visitCount
            ? _value.visitCount
            : visitCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastVisited: freezed == lastVisited
            ? _value.lastVisited
            : lastVisited // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        totalSpots: null == totalSpots
            ? _value.totalSpots
            : totalSpots // ignore: cast_nullable_to_non_nullable
                  as int,
        visitedSpots: null == visitedSpots
            ? _value.visitedSpots
            : visitedSpots // ignore: cast_nullable_to_non_nullable
                  as int,
        firstSpotVisit: freezed == firstSpotVisit
            ? _value.firstSpotVisit
            : firstSpotVisit // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAreaDataImpl implements _UserAreaData {
  const _$UserAreaDataImpl({
    required this.areaId,
    this.visitCount = 0,
    this.lastVisited,
    required this.totalSpots,
    required this.visitedSpots,
    this.firstSpotVisit,
    this.completedAt,
  });

  factory _$UserAreaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAreaDataImplFromJson(json);

  @override
  final String areaId;
  @override
  @JsonKey()
  final int visitCount;
  @override
  final DateTime? lastVisited;
  @override
  final int totalSpots;
  @override
  final int visitedSpots;
  @override
  final DateTime? firstSpotVisit;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'UserAreaData(areaId: $areaId, visitCount: $visitCount, lastVisited: $lastVisited, totalSpots: $totalSpots, visitedSpots: $visitedSpots, firstSpotVisit: $firstSpotVisit, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAreaDataImpl &&
            (identical(other.areaId, areaId) || other.areaId == areaId) &&
            (identical(other.visitCount, visitCount) ||
                other.visitCount == visitCount) &&
            (identical(other.lastVisited, lastVisited) ||
                other.lastVisited == lastVisited) &&
            (identical(other.totalSpots, totalSpots) ||
                other.totalSpots == totalSpots) &&
            (identical(other.visitedSpots, visitedSpots) ||
                other.visitedSpots == visitedSpots) &&
            (identical(other.firstSpotVisit, firstSpotVisit) ||
                other.firstSpotVisit == firstSpotVisit) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    areaId,
    visitCount,
    lastVisited,
    totalSpots,
    visitedSpots,
    firstSpotVisit,
    completedAt,
  );

  /// Create a copy of UserAreaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAreaDataImplCopyWith<_$UserAreaDataImpl> get copyWith =>
      __$$UserAreaDataImplCopyWithImpl<_$UserAreaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAreaDataImplToJson(this);
  }
}

abstract class _UserAreaData implements UserAreaData {
  const factory _UserAreaData({
    required final String areaId,
    final int visitCount,
    final DateTime? lastVisited,
    required final int totalSpots,
    required final int visitedSpots,
    final DateTime? firstSpotVisit,
    final DateTime? completedAt,
  }) = _$UserAreaDataImpl;

  factory _UserAreaData.fromJson(Map<String, dynamic> json) =
      _$UserAreaDataImpl.fromJson;

  @override
  String get areaId;
  @override
  int get visitCount;
  @override
  DateTime? get lastVisited;
  @override
  int get totalSpots;
  @override
  int get visitedSpots;
  @override
  DateTime? get firstSpotVisit;
  @override
  DateTime? get completedAt;

  /// Create a copy of UserAreaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAreaDataImplCopyWith<_$UserAreaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
