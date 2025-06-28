// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocationData _$LocationDataFromJson(Map<String, dynamic> json) {
  return _LocationData.fromJson(json);
}

/// @nodoc
mixin _$LocationData {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get accuracy => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get isMocked => throw _privateConstructorUsedError;

  /// Serializes this LocationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationDataCopyWith<LocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataCopyWith<$Res> {
  factory $LocationDataCopyWith(
    LocationData value,
    $Res Function(LocationData) then,
  ) = _$LocationDataCopyWithImpl<$Res, LocationData>;
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double accuracy,
    DateTime timestamp,
    bool isMocked,
  });
}

/// @nodoc
class _$LocationDataCopyWithImpl<$Res, $Val extends LocationData>
    implements $LocationDataCopyWith<$Res> {
  _$LocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? isMocked = null,
  }) {
    return _then(
      _value.copyWith(
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            accuracy: null == accuracy
                ? _value.accuracy
                : accuracy // ignore: cast_nullable_to_non_nullable
                      as double,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isMocked: null == isMocked
                ? _value.isMocked
                : isMocked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocationDataImplCopyWith<$Res>
    implements $LocationDataCopyWith<$Res> {
  factory _$$LocationDataImplCopyWith(
    _$LocationDataImpl value,
    $Res Function(_$LocationDataImpl) then,
  ) = __$$LocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double latitude,
    double longitude,
    double accuracy,
    DateTime timestamp,
    bool isMocked,
  });
}

/// @nodoc
class __$$LocationDataImplCopyWithImpl<$Res>
    extends _$LocationDataCopyWithImpl<$Res, _$LocationDataImpl>
    implements _$$LocationDataImplCopyWith<$Res> {
  __$$LocationDataImplCopyWithImpl(
    _$LocationDataImpl _value,
    $Res Function(_$LocationDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
    Object? accuracy = null,
    Object? timestamp = null,
    Object? isMocked = null,
  }) {
    return _then(
      _$LocationDataImpl(
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        accuracy: null == accuracy
            ? _value.accuracy
            : accuracy // ignore: cast_nullable_to_non_nullable
                  as double,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isMocked: null == isMocked
            ? _value.isMocked
            : isMocked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDataImpl implements _LocationData {
  const _$LocationDataImpl({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
    this.isMocked = false,
  });

  factory _$LocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDataImplFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double accuracy;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool isMocked;

  @override
  String toString() {
    return 'LocationData(latitude: $latitude, longitude: $longitude, accuracy: $accuracy, timestamp: $timestamp, isMocked: $isMocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDataImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.accuracy, accuracy) ||
                other.accuracy == accuracy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isMocked, isMocked) ||
                other.isMocked == isMocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    latitude,
    longitude,
    accuracy,
    timestamp,
    isMocked,
  );

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      __$$LocationDataImplCopyWithImpl<_$LocationDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDataImplToJson(this);
  }
}

abstract class _LocationData implements LocationData {
  const factory _LocationData({
    required final double latitude,
    required final double longitude,
    required final double accuracy,
    required final DateTime timestamp,
    final bool isMocked,
  }) = _$LocationDataImpl;

  factory _LocationData.fromJson(Map<String, dynamic> json) =
      _$LocationDataImpl.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get accuracy;
  @override
  DateTime get timestamp;
  @override
  bool get isMocked;

  /// Create a copy of LocationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationDataImplCopyWith<_$LocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
