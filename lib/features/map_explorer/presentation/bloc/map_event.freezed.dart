// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_event.dart';

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
    required TResult Function(GeographicArea area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchDataRequested value) fetchDataRequested,
    required TResult Function(_AreaSelected value) areaSelected,
    required TResult Function(_IncrementAreaVisit value) incrementAreaVisit,
    required TResult Function(_DecrementAreaVisit value) decrementAreaVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchDataRequested value)? fetchDataRequested,
    TResult? Function(_AreaSelected value)? areaSelected,
    TResult? Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult? Function(_DecrementAreaVisit value)? decrementAreaVisit,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchDataRequested value)? fetchDataRequested,
    TResult Function(_AreaSelected value)? areaSelected,
    TResult Function(_IncrementAreaVisit value)? incrementAreaVisit,
    TResult Function(_DecrementAreaVisit value)? decrementAreaVisit,
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

class _$FetchDataRequestedImpl implements _FetchDataRequested {
  const _$FetchDataRequestedImpl({
    required this.cityName,
    required this.adminLevel,
  });

  @override
  final String cityName;
  @override
  final int adminLevel;

  @override
  String toString() {
    return 'MapEvent.fetchDataRequested(cityName: $cityName, adminLevel: $adminLevel)';
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
    required TResult Function(GeographicArea area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
  }) {
    return fetchDataRequested(cityName, adminLevel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
  }) {
    return fetchDataRequested?.call(cityName, adminLevel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
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
  $Res call({GeographicArea area});
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
  $Res call({Object? area = null}) {
    return _then(
      _$AreaSelectedImpl(
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as GeographicArea,
      ),
    );
  }
}

/// @nodoc

class _$AreaSelectedImpl implements _AreaSelected {
  const _$AreaSelectedImpl({required this.area});

  @override
  final GeographicArea area;

  @override
  String toString() {
    return 'MapEvent.areaSelected(area: $area)';
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
    required TResult Function(GeographicArea area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
  }) {
    return areaSelected(area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
  }) {
    return areaSelected?.call(area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
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
    required TResult orElse(),
  }) {
    if (areaSelected != null) {
      return areaSelected(this);
    }
    return orElse();
  }
}

abstract class _AreaSelected implements MapEvent {
  const factory _AreaSelected({required final GeographicArea area}) =
      _$AreaSelectedImpl;

  GeographicArea get area;

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

class _$IncrementAreaVisitImpl implements _IncrementAreaVisit {
  const _$IncrementAreaVisitImpl({required this.areaId});

  @override
  final int areaId;

  @override
  String toString() {
    return 'MapEvent.incrementAreaVisit(areaId: $areaId)';
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
    required TResult Function(GeographicArea area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
  }) {
    return incrementAreaVisit(areaId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
  }) {
    return incrementAreaVisit?.call(areaId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
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

class _$DecrementAreaVisitImpl implements _DecrementAreaVisit {
  const _$DecrementAreaVisitImpl({required this.areaId});

  @override
  final int areaId;

  @override
  String toString() {
    return 'MapEvent.decrementAreaVisit(areaId: $areaId)';
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
    required TResult Function(GeographicArea area) areaSelected,
    required TResult Function(int areaId) incrementAreaVisit,
    required TResult Function(int areaId) decrementAreaVisit,
  }) {
    return decrementAreaVisit(areaId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult? Function(GeographicArea area)? areaSelected,
    TResult? Function(int areaId)? incrementAreaVisit,
    TResult? Function(int areaId)? decrementAreaVisit,
  }) {
    return decrementAreaVisit?.call(areaId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String cityName, int adminLevel)? fetchDataRequested,
    TResult Function(GeographicArea area)? areaSelected,
    TResult Function(int areaId)? incrementAreaVisit,
    TResult Function(int areaId)? decrementAreaVisit,
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
