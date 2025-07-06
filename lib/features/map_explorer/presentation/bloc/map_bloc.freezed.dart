// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MapEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapEventCopyWith<$Res> {
  factory $MapEventCopyWith(MapEvent value, $Res Function(MapEvent) then) =
      _$MapEventCopyWithImpl<$Res, MapEvent>;
}

/// @nodoc
class _$MapEventCopyWithImpl<$Res, $Val extends MapEvent>
    implements $MapEventCopyWith<$Res> {
  _$MapEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchDataRequestedImplCopyWith<$Res> {
  factory _$$FetchDataRequestedImplCopyWith(
    _$FetchDataRequestedImpl value,
    $Res Function(_$FetchDataRequestedImpl) then,
  ) = __$$FetchDataRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String cityName, int adminLevel, String? userId});
}

/// @nodoc
class __$$FetchDataRequestedImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$FetchDataRequestedImpl>
    implements _$$FetchDataRequestedImplCopyWith<$Res> {
  __$$FetchDataRequestedImplCopyWithImpl(
    _$FetchDataRequestedImpl _value,
    $Res Function(_$FetchDataRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? adminLevel = null,
    Object? userId = freezed,
  }) {
    return _then(
      _$FetchDataRequestedImpl(
        cityName: null == cityName
            ? _value.cityName
            : cityName // ignore: cast_nullable_to_non_nullable
                  as String,
        adminLevel: null == adminLevel
            ? _value.adminLevel
            : adminLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FetchDataRequestedImpl
    with DiagnosticableTreeMixin
    implements _FetchDataRequested {
  const _$FetchDataRequestedImpl({
    required this.cityName,
    required this.adminLevel,
    this.userId,
  });

  @override
  final String cityName;
  @override
  final int adminLevel;
  @override
  final String? userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.fetchDataRequested(cityName: $cityName, adminLevel: $adminLevel, userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.fetchDataRequested'))
      ..add(DiagnosticsProperty('cityName', cityName))
      ..add(DiagnosticsProperty('adminLevel', adminLevel))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchDataRequestedImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.adminLevel, adminLevel) ||
                other.adminLevel == adminLevel) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName, adminLevel, userId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchDataRequestedImplCopyWith<_$FetchDataRequestedImpl> get copyWith =>
      __$$FetchDataRequestedImplCopyWithImpl<_$FetchDataRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) {
    return fetchDataRequested(cityName, adminLevel, userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) {
    return fetchDataRequested?.call(cityName, adminLevel, userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (fetchDataRequested != null) {
      return fetchDataRequested(cityName, adminLevel, userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) {
    return fetchDataRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) {
    return fetchDataRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (fetchDataRequested != null) {
      return fetchDataRequested(this);
    }
    return orElse();
  }
}

abstract class _FetchDataRequested implements MapEvent {
  const factory _FetchDataRequested({
    required final String cityName,
    required final int adminLevel,
    final String? userId,
  }) = _$FetchDataRequestedImpl;

  String get cityName;
  int get adminLevel;
  String? get userId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchDataRequestedImplCopyWith<_$FetchDataRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MapViewChangedImplCopyWith<$Res> {
  factory _$$MapViewChangedImplCopyWith(
    _$MapViewChangedImpl value,
    $Res Function(_$MapViewChangedImpl) then,
  ) = __$$MapViewChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LatLngBounds bounds});
}

/// @nodoc
class __$$MapViewChangedImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$MapViewChangedImpl>
    implements _$$MapViewChangedImplCopyWith<$Res> {
  __$$MapViewChangedImplCopyWithImpl(
    _$MapViewChangedImpl _value,
    $Res Function(_$MapViewChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? bounds = null}) {
    return _then(
      _$MapViewChangedImpl(
        bounds: null == bounds
            ? _value.bounds
            : bounds // ignore: cast_nullable_to_non_nullable
                  as LatLngBounds,
      ),
    );
  }
}

/// @nodoc

class _$MapViewChangedImpl
    with DiagnosticableTreeMixin
    implements _MapViewChanged {
  const _$MapViewChangedImpl({required this.bounds});

  @override
  final LatLngBounds bounds;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.mapViewChanged(bounds: $bounds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.mapViewChanged'))
      ..add(DiagnosticsProperty('bounds', bounds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapViewChangedImpl &&
            (identical(other.bounds, bounds) || other.bounds == bounds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bounds);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapViewChangedImplCopyWith<_$MapViewChangedImpl> get copyWith =>
      __$$MapViewChangedImplCopyWithImpl<_$MapViewChangedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) {
    return mapViewChanged(bounds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) {
    return mapViewChanged?.call(bounds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (mapViewChanged != null) {
      return mapViewChanged(bounds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) {
    return mapViewChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) {
    return mapViewChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (mapViewChanged != null) {
      return mapViewChanged(this);
    }
    return orElse();
  }
}

abstract class _MapViewChanged implements MapEvent {
  const factory _MapViewChanged({required final LatLngBounds bounds}) =
      _$MapViewChangedImpl;

  LatLngBounds get bounds;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapViewChangedImplCopyWith<_$MapViewChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaSelectedImplCopyWith<$Res> {
  factory _$$AreaSelectedImplCopyWith(
    _$AreaSelectedImpl value,
    $Res Function(_$AreaSelectedImpl) then,
  ) = __$$AreaSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GeographicArea? area});
}

/// @nodoc
class __$$AreaSelectedImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$AreaSelectedImpl>
    implements _$$AreaSelectedImplCopyWith<$Res> {
  __$$AreaSelectedImplCopyWithImpl(
    _$AreaSelectedImpl _value,
    $Res Function(_$AreaSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? area = freezed}) {
    return _then(
      _$AreaSelectedImpl(
        area: freezed == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as GeographicArea?,
      ),
    );
  }
}

/// @nodoc

class _$AreaSelectedImpl with DiagnosticableTreeMixin implements _AreaSelected {
  const _$AreaSelectedImpl({this.area});

  @override
  final GeographicArea? area;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.areaSelected(area: $area)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.areaSelected'))
      ..add(DiagnosticsProperty('area', area));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaSelectedImpl &&
            (identical(other.area, area) || other.area == area));
  }

  @override
  int get hashCode => Object.hash(runtimeType, area);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaSelectedImplCopyWith<_$AreaSelectedImpl> get copyWith =>
      __$$AreaSelectedImplCopyWithImpl<_$AreaSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) {
    return areaSelected(area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) {
    return areaSelected?.call(area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (areaSelected != null) {
      return areaSelected(area);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) {
    return areaSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) {
    return areaSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (areaSelected != null) {
      return areaSelected(this);
    }
    return orElse();
  }
}

abstract class _AreaSelected implements MapEvent {
  const factory _AreaSelected({final GeographicArea? area}) =
      _$AreaSelectedImpl;

  GeographicArea? get area;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AreaSelectedImplCopyWith<_$AreaSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpotSelectedImplCopyWith<$Res> {
  factory _$$SpotSelectedImplCopyWith(
    _$SpotSelectedImpl value,
    $Res Function(_$SpotSelectedImpl) then,
  ) = __$$SpotSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Spot? spot});

  $SpotCopyWith<$Res>? get spot;
}

/// @nodoc
class __$$SpotSelectedImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$SpotSelectedImpl>
    implements _$$SpotSelectedImplCopyWith<$Res> {
  __$$SpotSelectedImplCopyWithImpl(
    _$SpotSelectedImpl _value,
    $Res Function(_$SpotSelectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spot = freezed}) {
    return _then(
      _$SpotSelectedImpl(
        spot: freezed == spot
            ? _value.spot
            : spot // ignore: cast_nullable_to_non_nullable
                  as Spot?,
      ),
    );
  }

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotCopyWith<$Res>? get spot {
    if (_value.spot == null) {
      return null;
    }

    return $SpotCopyWith<$Res>(_value.spot!, (value) {
      return _then(_value.copyWith(spot: value));
    });
  }
}

/// @nodoc

class _$SpotSelectedImpl with DiagnosticableTreeMixin implements _SpotSelected {
  const _$SpotSelectedImpl({this.spot});

  @override
  final Spot? spot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.spotSelected(spot: $spot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.spotSelected'))
      ..add(DiagnosticsProperty('spot', spot));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpotSelectedImpl &&
            (identical(other.spot, spot) || other.spot == spot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spot);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpotSelectedImplCopyWith<_$SpotSelectedImpl> get copyWith =>
      __$$SpotSelectedImplCopyWithImpl<_$SpotSelectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) {
    return spotSelected(spot);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) {
    return spotSelected?.call(spot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (spotSelected != null) {
      return spotSelected(spot);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) {
    return spotSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) {
    return spotSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (spotSelected != null) {
      return spotSelected(this);
    }
    return orElse();
  }
}

abstract class _SpotSelected implements MapEvent {
  const factory _SpotSelected({final Spot? spot}) = _$SpotSelectedImpl;

  Spot? get spot;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpotSelectedImplCopyWith<_$SpotSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshAreaDataRequestedImplCopyWith<$Res> {
  factory _$$RefreshAreaDataRequestedImplCopyWith(
    _$RefreshAreaDataRequestedImpl value,
    $Res Function(_$RefreshAreaDataRequestedImpl) then,
  ) = __$$RefreshAreaDataRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$RefreshAreaDataRequestedImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$RefreshAreaDataRequestedImpl>
    implements _$$RefreshAreaDataRequestedImplCopyWith<$Res> {
  __$$RefreshAreaDataRequestedImplCopyWithImpl(
    _$RefreshAreaDataRequestedImpl _value,
    $Res Function(_$RefreshAreaDataRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$RefreshAreaDataRequestedImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RefreshAreaDataRequestedImpl
    with DiagnosticableTreeMixin
    implements _RefreshAreaDataRequested {
  const _$RefreshAreaDataRequestedImpl({required this.userId});

  @override
  final String userId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.refreshAreaDataRequested(userId: $userId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.refreshAreaDataRequested'))
      ..add(DiagnosticsProperty('userId', userId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshAreaDataRequestedImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshAreaDataRequestedImplCopyWith<_$RefreshAreaDataRequestedImpl>
  get copyWith =>
      __$$RefreshAreaDataRequestedImplCopyWithImpl<
        _$RefreshAreaDataRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel, String? userId)
    fetchDataRequested,
    required TResult Function(LatLngBounds bounds) mapViewChanged,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(String userId) refreshAreaDataRequested,
  }) {
    return refreshAreaDataRequested(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult? Function(LatLngBounds bounds)? mapViewChanged,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(String userId)? refreshAreaDataRequested,
  }) {
    return refreshAreaDataRequested?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel, String? userId)?
    fetchDataRequested,
    TResult Function(LatLngBounds bounds)? mapViewChanged,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(String userId)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (refreshAreaDataRequested != null) {
      return refreshAreaDataRequested(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_MapViewChanged value) mapViewChanged,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_RefreshAreaDataRequested value)
    refreshAreaDataRequested,
  }) {
    return refreshAreaDataRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_MapViewChanged value)? mapViewChanged,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_RefreshAreaDataRequested value)?
    refreshAreaDataRequested,
  }) {
    return refreshAreaDataRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_MapViewChanged value)? mapViewChanged,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_RefreshAreaDataRequested value)? refreshAreaDataRequested,
    required TResult orElse(),
  }) {
    if (refreshAreaDataRequested != null) {
      return refreshAreaDataRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshAreaDataRequested implements MapEvent {
  const factory _RefreshAreaDataRequested({required final String userId}) =
      _$RefreshAreaDataRequestedImpl;

  String get userId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshAreaDataRequestedImplCopyWith<_$RefreshAreaDataRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MapState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapStateCopyWith<$Res> {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) then) =
      _$MapStateCopyWithImpl<$Res, MapState>;
}

/// @nodoc
class _$MapStateCopyWithImpl<$Res, $Val extends MapState>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MapState.initial'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements MapState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadInProgressImplCopyWith<$Res> {
  factory _$$LoadInProgressImplCopyWith(
    _$LoadInProgressImpl value,
    $Res Function(_$LoadInProgressImpl) then,
  ) = __$$LoadInProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadInProgressImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$LoadInProgressImpl>
    implements _$$LoadInProgressImplCopyWith<$Res> {
  __$$LoadInProgressImplCopyWithImpl(
    _$LoadInProgressImpl _value,
    $Res Function(_$LoadInProgressImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadInProgressImpl
    with DiagnosticableTreeMixin
    implements _LoadInProgress {
  const _$LoadInProgressImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState.loadInProgress()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'MapState.loadInProgress'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadInProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) {
    return loadInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadInProgress implements MapState {
  const factory _LoadInProgress() = _$LoadInProgressImpl;
}

/// @nodoc
abstract class _$$LoadSuccessImplCopyWith<$Res> {
  factory _$$LoadSuccessImplCopyWith(
    _$LoadSuccessImpl value,
    $Res Function(_$LoadSuccessImpl) then,
  ) = __$$LoadSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    BoundaryData boundaryData,
    List<Spot> spots,
    Map<String, UserAreaData> userVisitData,
    Map<String, UserSpotData> userSpotVisitData,
    GeographicArea? selectedArea,
    Spot? selectedSpot,
  });

  $SpotCopyWith<$Res>? get selectedSpot;
}

/// @nodoc
class __$$LoadSuccessImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$LoadSuccessImpl>
    implements _$$LoadSuccessImplCopyWith<$Res> {
  __$$LoadSuccessImplCopyWithImpl(
    _$LoadSuccessImpl _value,
    $Res Function(_$LoadSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boundaryData = null,
    Object? spots = null,
    Object? userVisitData = null,
    Object? userSpotVisitData = null,
    Object? selectedArea = freezed,
    Object? selectedSpot = freezed,
  }) {
    return _then(
      _$LoadSuccessImpl(
        boundaryData: null == boundaryData
            ? _value.boundaryData
            : boundaryData // ignore: cast_nullable_to_non_nullable
                  as BoundaryData,
        spots: null == spots
            ? _value._spots
            : spots // ignore: cast_nullable_to_non_nullable
                  as List<Spot>,
        userVisitData: null == userVisitData
            ? _value._userVisitData
            : userVisitData // ignore: cast_nullable_to_non_nullable
                  as Map<String, UserAreaData>,
        userSpotVisitData: null == userSpotVisitData
            ? _value._userSpotVisitData
            : userSpotVisitData // ignore: cast_nullable_to_non_nullable
                  as Map<String, UserSpotData>,
        selectedArea: freezed == selectedArea
            ? _value.selectedArea
            : selectedArea // ignore: cast_nullable_to_non_nullable
                  as GeographicArea?,
        selectedSpot: freezed == selectedSpot
            ? _value.selectedSpot
            : selectedSpot // ignore: cast_nullable_to_non_nullable
                  as Spot?,
      ),
    );
  }

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpotCopyWith<$Res>? get selectedSpot {
    if (_value.selectedSpot == null) {
      return null;
    }

    return $SpotCopyWith<$Res>(_value.selectedSpot!, (value) {
      return _then(_value.copyWith(selectedSpot: value));
    });
  }
}

/// @nodoc

class _$LoadSuccessImpl with DiagnosticableTreeMixin implements _LoadSuccess {
  const _$LoadSuccessImpl({
    required this.boundaryData,
    required final List<Spot> spots,
    required final Map<String, UserAreaData> userVisitData,
    required final Map<String, UserSpotData> userSpotVisitData,
    this.selectedArea,
    this.selectedSpot,
  }) : _spots = spots,
       _userVisitData = userVisitData,
       _userSpotVisitData = userSpotVisitData;

  @override
  final BoundaryData boundaryData;
  final List<Spot> _spots;
  @override
  List<Spot> get spots {
    if (_spots is EqualUnmodifiableListView) return _spots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spots);
  }

  final Map<String, UserAreaData> _userVisitData;
  @override
  Map<String, UserAreaData> get userVisitData {
    if (_userVisitData is EqualUnmodifiableMapView) return _userVisitData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userVisitData);
  }

  final Map<String, UserSpotData> _userSpotVisitData;
  @override
  Map<String, UserSpotData> get userSpotVisitData {
    if (_userSpotVisitData is EqualUnmodifiableMapView)
      return _userSpotVisitData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userSpotVisitData);
  }

  @override
  final GeographicArea? selectedArea;
  @override
  final Spot? selectedSpot;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState.loadSuccess(boundaryData: $boundaryData, spots: $spots, userVisitData: $userVisitData, userSpotVisitData: $userSpotVisitData, selectedArea: $selectedArea, selectedSpot: $selectedSpot)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapState.loadSuccess'))
      ..add(DiagnosticsProperty('boundaryData', boundaryData))
      ..add(DiagnosticsProperty('spots', spots))
      ..add(DiagnosticsProperty('userVisitData', userVisitData))
      ..add(DiagnosticsProperty('userSpotVisitData', userSpotVisitData))
      ..add(DiagnosticsProperty('selectedArea', selectedArea))
      ..add(DiagnosticsProperty('selectedSpot', selectedSpot));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            (identical(other.boundaryData, boundaryData) ||
                other.boundaryData == boundaryData) &&
            const DeepCollectionEquality().equals(other._spots, _spots) &&
            const DeepCollectionEquality().equals(
              other._userVisitData,
              _userVisitData,
            ) &&
            const DeepCollectionEquality().equals(
              other._userSpotVisitData,
              _userSpotVisitData,
            ) &&
            (identical(other.selectedArea, selectedArea) ||
                other.selectedArea == selectedArea) &&
            (identical(other.selectedSpot, selectedSpot) ||
                other.selectedSpot == selectedSpot));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    boundaryData,
    const DeepCollectionEquality().hash(_spots),
    const DeepCollectionEquality().hash(_userVisitData),
    const DeepCollectionEquality().hash(_userSpotVisitData),
    selectedArea,
    selectedSpot,
  );

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      __$$LoadSuccessImplCopyWithImpl<_$LoadSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) {
    return loadSuccess(
      boundaryData,
      spots,
      userVisitData,
      userSpotVisitData,
      selectedArea,
      selectedSpot,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) {
    return loadSuccess?.call(
      boundaryData,
      spots,
      userVisitData,
      userSpotVisitData,
      selectedArea,
      selectedSpot,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(
        boundaryData,
        spots,
        userVisitData,
        userSpotVisitData,
        selectedArea,
        selectedSpot,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoadSuccess implements MapState {
  const factory _LoadSuccess({
    required final BoundaryData boundaryData,
    required final List<Spot> spots,
    required final Map<String, UserAreaData> userVisitData,
    required final Map<String, UserSpotData> userSpotVisitData,
    final GeographicArea? selectedArea,
    final Spot? selectedSpot,
  }) = _$LoadSuccessImpl;

  BoundaryData get boundaryData;
  List<Spot> get spots;
  Map<String, UserAreaData> get userVisitData;
  Map<String, UserSpotData> get userSpotVisitData;
  GeographicArea? get selectedArea;
  Spot? get selectedSpot;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadSuccessImplCopyWith<_$LoadSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadFailureImplCopyWith<$Res> {
  factory _$$LoadFailureImplCopyWith(
    _$LoadFailureImpl value,
    $Res Function(_$LoadFailureImpl) then,
  ) = __$$LoadFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$LoadFailureImplCopyWithImpl<$Res>
    extends _$MapStateCopyWithImpl<$Res, _$LoadFailureImpl>
    implements _$$LoadFailureImplCopyWith<$Res> {
  __$$LoadFailureImplCopyWithImpl(
    _$LoadFailureImpl _value,
    $Res Function(_$LoadFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? error = null}) {
    return _then(
      _$LoadFailureImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoadFailureImpl with DiagnosticableTreeMixin implements _LoadFailure {
  const _$LoadFailureImpl({required this.error});

  @override
  final String error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState.loadFailure(error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapState.loadFailure'))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      __$$LoadFailureImplCopyWithImpl<_$LoadFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loadInProgress,
    required TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) {
    return loadFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loadInProgress,
    TResult? Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) {
    return loadFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loadInProgress,
    TResult Function(
      BoundaryData boundaryData,
      List<Spot> spots,
      Map<String, UserAreaData> userVisitData,
      Map<String, UserSpotData> userSpotVisitData,
      GeographicArea? selectedArea,
      Spot? selectedSpot,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_LoadInProgress value)? loadInProgress,
    TResult? Function(_LoadSuccess value)? loadSuccess,
    TResult? Function(_LoadFailure value)? loadFailure,
  }) {
    return loadFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class _LoadFailure implements MapState {
  const factory _LoadFailure({required final String error}) = _$LoadFailureImpl;

  String get error;

  /// Create a copy of MapState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadFailureImplCopyWith<_$LoadFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
