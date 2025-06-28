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
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
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
  $Res call({String cityName, int adminLevel});
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
  $Res call({Object? cityName = null, Object? adminLevel = null}) {
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
  });

  @override
  final String cityName;
  @override
  final int adminLevel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.fetchDataRequested(cityName: $cityName, adminLevel: $adminLevel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.fetchDataRequested'))
      ..add(DiagnosticsProperty('cityName', cityName))
      ..add(DiagnosticsProperty('adminLevel', adminLevel));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchDataRequestedImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.adminLevel, adminLevel) ||
                other.adminLevel == adminLevel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName, adminLevel);

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
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return fetchDataRequested(cityName, adminLevel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return fetchDataRequested?.call(cityName, adminLevel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (fetchDataRequested != null) {
      return fetchDataRequested(cityName, adminLevel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return fetchDataRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return fetchDataRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
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
  }) = _$FetchDataRequestedImpl;

  String get cityName;
  int get adminLevel;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchDataRequestedImplCopyWith<_$FetchDataRequestedImpl> get copyWith =>
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
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return areaSelected(area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return areaSelected?.call(area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
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
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return areaSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return areaSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
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
abstract class _$$IncrementAreaVisitImplCopyWith<$Res> {
  factory _$$IncrementAreaVisitImplCopyWith(
    _$IncrementAreaVisitImpl value,
    $Res Function(_$IncrementAreaVisitImpl) then,
  ) = __$$IncrementAreaVisitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int areaId});
}

/// @nodoc
class __$$IncrementAreaVisitImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$IncrementAreaVisitImpl>
    implements _$$IncrementAreaVisitImplCopyWith<$Res> {
  __$$IncrementAreaVisitImplCopyWithImpl(
    _$IncrementAreaVisitImpl _value,
    $Res Function(_$IncrementAreaVisitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? areaId = null}) {
    return _then(
      _$IncrementAreaVisitImpl(
        areaId: null == areaId
            ? _value.areaId
            : areaId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$IncrementAreaVisitImpl
    with DiagnosticableTreeMixin
    implements _IncrementAreaVisit {
  const _$IncrementAreaVisitImpl({required this.areaId});

  @override
  final int areaId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.incrementAreaVisit(areaId: $areaId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.incrementAreaVisit'))
      ..add(DiagnosticsProperty('areaId', areaId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncrementAreaVisitImpl &&
            (identical(other.areaId, areaId) || other.areaId == areaId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, areaId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncrementAreaVisitImplCopyWith<_$IncrementAreaVisitImpl> get copyWith =>
      __$$IncrementAreaVisitImplCopyWithImpl<_$IncrementAreaVisitImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return incrementAreaVisit(areaId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return incrementAreaVisit?.call(areaId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (incrementAreaVisit != null) {
      return incrementAreaVisit(areaId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return incrementAreaVisit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return incrementAreaVisit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (incrementAreaVisit != null) {
      return incrementAreaVisit(this);
    }
    return orElse();
  }
}

abstract class _IncrementAreaVisit implements MapEvent {
  const factory _IncrementAreaVisit({required final int areaId}) =
      _$IncrementAreaVisitImpl;

  int get areaId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncrementAreaVisitImplCopyWith<_$IncrementAreaVisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DecrementAreaVisitImplCopyWith<$Res> {
  factory _$$DecrementAreaVisitImplCopyWith(
    _$DecrementAreaVisitImpl value,
    $Res Function(_$DecrementAreaVisitImpl) then,
  ) = __$$DecrementAreaVisitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int areaId});
}

/// @nodoc
class __$$DecrementAreaVisitImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$DecrementAreaVisitImpl>
    implements _$$DecrementAreaVisitImplCopyWith<$Res> {
  __$$DecrementAreaVisitImplCopyWithImpl(
    _$DecrementAreaVisitImpl _value,
    $Res Function(_$DecrementAreaVisitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? areaId = null}) {
    return _then(
      _$DecrementAreaVisitImpl(
        areaId: null == areaId
            ? _value.areaId
            : areaId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DecrementAreaVisitImpl
    with DiagnosticableTreeMixin
    implements _DecrementAreaVisit {
  const _$DecrementAreaVisitImpl({required this.areaId});

  @override
  final int areaId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.decrementAreaVisit(areaId: $areaId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.decrementAreaVisit'))
      ..add(DiagnosticsProperty('areaId', areaId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecrementAreaVisitImpl &&
            (identical(other.areaId, areaId) || other.areaId == areaId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, areaId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecrementAreaVisitImplCopyWith<_$DecrementAreaVisitImpl> get copyWith =>
      __$$DecrementAreaVisitImplCopyWithImpl<_$DecrementAreaVisitImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return decrementAreaVisit(areaId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return decrementAreaVisit?.call(areaId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (decrementAreaVisit != null) {
      return decrementAreaVisit(areaId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return decrementAreaVisit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return decrementAreaVisit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (decrementAreaVisit != null) {
      return decrementAreaVisit(this);
    }
    return orElse();
  }
}

abstract class _DecrementAreaVisit implements MapEvent {
  const factory _DecrementAreaVisit({required final int areaId}) =
      _$DecrementAreaVisitImpl;

  int get areaId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecrementAreaVisitImplCopyWith<_$DecrementAreaVisitImpl> get copyWith =>
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
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return spotSelected(spot);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return spotSelected?.call(spot);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
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
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return spotSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return spotSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
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
abstract class _$$IncrementSpotVisitImplCopyWith<$Res> {
  factory _$$IncrementSpotVisitImplCopyWith(
    _$IncrementSpotVisitImpl value,
    $Res Function(_$IncrementSpotVisitImpl) then,
  ) = __$$IncrementSpotVisitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int spotId});
}

/// @nodoc
class __$$IncrementSpotVisitImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$IncrementSpotVisitImpl>
    implements _$$IncrementSpotVisitImplCopyWith<$Res> {
  __$$IncrementSpotVisitImplCopyWithImpl(
    _$IncrementSpotVisitImpl _value,
    $Res Function(_$IncrementSpotVisitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spotId = null}) {
    return _then(
      _$IncrementSpotVisitImpl(
        spotId: null == spotId
            ? _value.spotId
            : spotId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$IncrementSpotVisitImpl
    with DiagnosticableTreeMixin
    implements _IncrementSpotVisit {
  const _$IncrementSpotVisitImpl({required this.spotId});

  @override
  final int spotId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.incrementSpotVisit(spotId: $spotId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.incrementSpotVisit'))
      ..add(DiagnosticsProperty('spotId', spotId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncrementSpotVisitImpl &&
            (identical(other.spotId, spotId) || other.spotId == spotId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncrementSpotVisitImplCopyWith<_$IncrementSpotVisitImpl> get copyWith =>
      __$$IncrementSpotVisitImplCopyWithImpl<_$IncrementSpotVisitImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return incrementSpotVisit(spotId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return incrementSpotVisit?.call(spotId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (incrementSpotVisit != null) {
      return incrementSpotVisit(spotId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return incrementSpotVisit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return incrementSpotVisit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (incrementSpotVisit != null) {
      return incrementSpotVisit(this);
    }
    return orElse();
  }
}

abstract class _IncrementSpotVisit implements MapEvent {
  const factory _IncrementSpotVisit({required final int spotId}) =
      _$IncrementSpotVisitImpl;

  int get spotId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncrementSpotVisitImplCopyWith<_$IncrementSpotVisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DecrementSpotVisitImplCopyWith<$Res> {
  factory _$$DecrementSpotVisitImplCopyWith(
    _$DecrementSpotVisitImpl value,
    $Res Function(_$DecrementSpotVisitImpl) then,
  ) = __$$DecrementSpotVisitImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int spotId});
}

/// @nodoc
class __$$DecrementSpotVisitImplCopyWithImpl<$Res>
    extends _$MapEventCopyWithImpl<$Res, _$DecrementSpotVisitImpl>
    implements _$$DecrementSpotVisitImplCopyWith<$Res> {
  __$$DecrementSpotVisitImplCopyWithImpl(
    _$DecrementSpotVisitImpl _value,
    $Res Function(_$DecrementSpotVisitImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? spotId = null}) {
    return _then(
      _$DecrementSpotVisitImpl(
        spotId: null == spotId
            ? _value.spotId
            : spotId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DecrementSpotVisitImpl
    with DiagnosticableTreeMixin
    implements _DecrementSpotVisit {
  const _$DecrementSpotVisitImpl({required this.spotId});

  @override
  final int spotId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapEvent.decrementSpotVisit(spotId: $spotId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapEvent.decrementSpotVisit'))
      ..add(DiagnosticsProperty('spotId', spotId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecrementSpotVisitImpl &&
            (identical(other.spotId, spotId) || other.spotId == spotId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, spotId);

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecrementSpotVisitImplCopyWith<_$DecrementSpotVisitImpl> get copyWith =>
      __$$DecrementSpotVisitImplCopyWithImpl<_$DecrementSpotVisitImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String cityName, int adminLevel)
    fetchDataRequested,
    required TResult Function(GeographicArea? area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
    required TResult Function(Spot? spot) spotSelected,
    required TResult Function(int spotId) incrementSpotVisit,
    required TResult Function(int spotId) decrementSpotVisit,
  }) {
    return decrementSpotVisit(spotId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea? area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
    TResult? Function(Spot? spot)? spotSelected,
    TResult? Function(int spotId)? incrementSpotVisit,
    TResult? Function(int spotId)? decrementSpotVisit,
  }) {
    return decrementSpotVisit?.call(spotId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea? area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    TResult Function(Spot? spot)? spotSelected,
    TResult Function(int spotId)? incrementSpotVisit,
    TResult Function(int spotId)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (decrementSpotVisit != null) {
      return decrementSpotVisit(spotId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
    required TResult Function(_SpotSelected value) spotSelected,
    required TResult Function(_IncrementSpotVisit value) incrementSpotVisit,
    required TResult Function(_DecrementSpotVisit value) decrementSpotVisit,
  }) {
    return decrementSpotVisit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult? Function(_SpotSelected value)? spotSelected,
    TResult? Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult? Function(_DecrementSpotVisit value)? decrementSpotVisit,
  }) {
    return decrementSpotVisit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
    TResult Function(_SpotSelected value)? spotSelected,
    TResult Function(_IncrementSpotVisit value)? incrementSpotVisit,
    TResult Function(_DecrementSpotVisit value)? decrementSpotVisit,
    required TResult orElse(),
  }) {
    if (decrementSpotVisit != null) {
      return decrementSpotVisit(this);
    }
    return orElse();
  }
}

abstract class _DecrementSpotVisit implements MapEvent {
  const factory _DecrementSpotVisit({required final int spotId}) =
      _$DecrementSpotVisitImpl;

  int get spotId;

  /// Create a copy of MapEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecrementSpotVisitImplCopyWith<_$DecrementSpotVisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
    GeographicArea? selectedArea,
    Spot? selectedSpot,
    Map<int, UserAreaData> userVisitData,
    Map<int, UserSpotData> userSpotVisitData,
  });
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
    Object? selectedArea = freezed,
    Object? selectedSpot = freezed,
    Object? userVisitData = null,
    Object? userSpotVisitData = null,
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
        selectedArea: freezed == selectedArea
            ? _value.selectedArea
            : selectedArea // ignore: cast_nullable_to_non_nullable
                  as GeographicArea?,
        selectedSpot: freezed == selectedSpot
            ? _value.selectedSpot
            : selectedSpot // ignore: cast_nullable_to_non_nullable
                  as Spot?,
        userVisitData: null == userVisitData
            ? _value._userVisitData
            : userVisitData // ignore: cast_nullable_to_non_nullable
                  as Map<int, UserAreaData>,
        userSpotVisitData: null == userSpotVisitData
            ? _value._userSpotVisitData
            : userSpotVisitData // ignore: cast_nullable_to_non_nullable
                  as Map<int, UserSpotData>,
      ),
    );
  }
}

/// @nodoc

class _$LoadSuccessImpl with DiagnosticableTreeMixin implements _LoadSuccess {
  const _$LoadSuccessImpl({
    required this.boundaryData,
    required final List<Spot> spots,
    this.selectedArea,
    this.selectedSpot,
    required final Map<int, UserAreaData> userVisitData,
    required final Map<int, UserSpotData> userSpotVisitData,
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

  @override
  final GeographicArea? selectedArea;
  @override
  final Spot? selectedSpot;
  final Map<int, UserAreaData> _userVisitData;
  @override
  Map<int, UserAreaData> get userVisitData {
    if (_userVisitData is EqualUnmodifiableMapView) return _userVisitData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userVisitData);
  }

  final Map<int, UserSpotData> _userSpotVisitData;
  @override
  Map<int, UserSpotData> get userSpotVisitData {
    if (_userSpotVisitData is EqualUnmodifiableMapView)
      return _userSpotVisitData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userSpotVisitData);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MapState.loadSuccess(boundaryData: $boundaryData, spots: $spots, selectedArea: $selectedArea, selectedSpot: $selectedSpot, userVisitData: $userVisitData, userSpotVisitData: $userSpotVisitData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MapState.loadSuccess'))
      ..add(DiagnosticsProperty('boundaryData', boundaryData))
      ..add(DiagnosticsProperty('spots', spots))
      ..add(DiagnosticsProperty('selectedArea', selectedArea))
      ..add(DiagnosticsProperty('selectedSpot', selectedSpot))
      ..add(DiagnosticsProperty('userVisitData', userVisitData))
      ..add(DiagnosticsProperty('userSpotVisitData', userSpotVisitData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadSuccessImpl &&
            (identical(other.boundaryData, boundaryData) ||
                other.boundaryData == boundaryData) &&
            const DeepCollectionEquality().equals(other._spots, _spots) &&
            (identical(other.selectedArea, selectedArea) ||
                other.selectedArea == selectedArea) &&
            (identical(other.selectedSpot, selectedSpot) ||
                other.selectedSpot == selectedSpot) &&
            const DeepCollectionEquality().equals(
              other._userVisitData,
              _userVisitData,
            ) &&
            const DeepCollectionEquality().equals(
              other._userSpotVisitData,
              _userSpotVisitData,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    boundaryData,
    const DeepCollectionEquality().hash(_spots),
    selectedArea,
    selectedSpot,
    const DeepCollectionEquality().hash(_userVisitData),
    const DeepCollectionEquality().hash(_userSpotVisitData),
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
    )
    loadSuccess,
    required TResult Function(String error) loadFailure,
  }) {
    return loadSuccess(
      boundaryData,
      spots,
      selectedArea,
      selectedSpot,
      userVisitData,
      userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
    )?
    loadSuccess,
    TResult? Function(String error)? loadFailure,
  }) {
    return loadSuccess?.call(
      boundaryData,
      spots,
      selectedArea,
      selectedSpot,
      userVisitData,
      userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
    )?
    loadSuccess,
    TResult Function(String error)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(
        boundaryData,
        spots,
        selectedArea,
        selectedSpot,
        userVisitData,
        userSpotVisitData,
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
    final GeographicArea? selectedArea,
    final Spot? selectedSpot,
    required final Map<int, UserAreaData> userVisitData,
    required final Map<int, UserSpotData> userSpotVisitData,
  }) = _$LoadSuccessImpl;

  BoundaryData get boundaryData;
  List<Spot> get spots;
  GeographicArea? get selectedArea;
  Spot? get selectedSpot;
  Map<int, UserAreaData> get userVisitData;
  Map<int, UserSpotData> get userSpotVisitData;

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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
      GeographicArea? selectedArea,
      Spot? selectedSpot,
      Map<int, UserAreaData> userVisitData,
      Map<int, UserSpotData> userSpotVisitData,
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
