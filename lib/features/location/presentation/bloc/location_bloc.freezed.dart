// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LocationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestPermission,
    required TResult Function() getCurrentLocation,
    required TResult Function(LocationData? location) setDebugLocation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requestPermission,
    TResult? Function()? getCurrentLocation,
    TResult? Function(LocationData? location)? setDebugLocation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestPermission,
    TResult Function()? getCurrentLocation,
    TResult Function(LocationData? location)? setDebugLocation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermission value) requestPermission,
    required TResult Function(_GetCurrentLocation value) getCurrentLocation,
    required TResult Function(_SetDebugLocation value) setDebugLocation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermission value)? requestPermission,
    TResult? Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult? Function(_SetDebugLocation value)? setDebugLocation,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermission value)? requestPermission,
    TResult Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult Function(_SetDebugLocation value)? setDebugLocation,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationEventCopyWith<$Res> {
  factory $LocationEventCopyWith(
    LocationEvent value,
    $Res Function(LocationEvent) then,
  ) = _$LocationEventCopyWithImpl<$Res, LocationEvent>;
}

/// @nodoc
class _$LocationEventCopyWithImpl<$Res, $Val extends LocationEvent>
    implements $LocationEventCopyWith<$Res> {
  _$LocationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RequestPermissionImplCopyWith<$Res> {
  factory _$$RequestPermissionImplCopyWith(
    _$RequestPermissionImpl value,
    $Res Function(_$RequestPermissionImpl) then,
  ) = __$$RequestPermissionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestPermissionImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$RequestPermissionImpl>
    implements _$$RequestPermissionImplCopyWith<$Res> {
  __$$RequestPermissionImplCopyWithImpl(
    _$RequestPermissionImpl _value,
    $Res Function(_$RequestPermissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestPermissionImpl
    with DiagnosticableTreeMixin
    implements _RequestPermission {
  const _$RequestPermissionImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationEvent.requestPermission()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationEvent.requestPermission'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RequestPermissionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestPermission,
    required TResult Function() getCurrentLocation,
    required TResult Function(LocationData? location) setDebugLocation,
  }) {
    return requestPermission();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requestPermission,
    TResult? Function()? getCurrentLocation,
    TResult? Function(LocationData? location)? setDebugLocation,
  }) {
    return requestPermission?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestPermission,
    TResult Function()? getCurrentLocation,
    TResult Function(LocationData? location)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (requestPermission != null) {
      return requestPermission();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermission value) requestPermission,
    required TResult Function(_GetCurrentLocation value) getCurrentLocation,
    required TResult Function(_SetDebugLocation value) setDebugLocation,
  }) {
    return requestPermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermission value)? requestPermission,
    TResult? Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult? Function(_SetDebugLocation value)? setDebugLocation,
  }) {
    return requestPermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermission value)? requestPermission,
    TResult Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult Function(_SetDebugLocation value)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (requestPermission != null) {
      return requestPermission(this);
    }
    return orElse();
  }
}

abstract class _RequestPermission implements LocationEvent {
  const factory _RequestPermission() = _$RequestPermissionImpl;
}

/// @nodoc
abstract class _$$GetCurrentLocationImplCopyWith<$Res> {
  factory _$$GetCurrentLocationImplCopyWith(
    _$GetCurrentLocationImpl value,
    $Res Function(_$GetCurrentLocationImpl) then,
  ) = __$$GetCurrentLocationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GetCurrentLocationImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$GetCurrentLocationImpl>
    implements _$$GetCurrentLocationImplCopyWith<$Res> {
  __$$GetCurrentLocationImplCopyWithImpl(
    _$GetCurrentLocationImpl _value,
    $Res Function(_$GetCurrentLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GetCurrentLocationImpl
    with DiagnosticableTreeMixin
    implements _GetCurrentLocation {
  const _$GetCurrentLocationImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationEvent.getCurrentLocation()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationEvent.getCurrentLocation'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GetCurrentLocationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestPermission,
    required TResult Function() getCurrentLocation,
    required TResult Function(LocationData? location) setDebugLocation,
  }) {
    return getCurrentLocation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requestPermission,
    TResult? Function()? getCurrentLocation,
    TResult? Function(LocationData? location)? setDebugLocation,
  }) {
    return getCurrentLocation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestPermission,
    TResult Function()? getCurrentLocation,
    TResult Function(LocationData? location)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (getCurrentLocation != null) {
      return getCurrentLocation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermission value) requestPermission,
    required TResult Function(_GetCurrentLocation value) getCurrentLocation,
    required TResult Function(_SetDebugLocation value) setDebugLocation,
  }) {
    return getCurrentLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermission value)? requestPermission,
    TResult? Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult? Function(_SetDebugLocation value)? setDebugLocation,
  }) {
    return getCurrentLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermission value)? requestPermission,
    TResult Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult Function(_SetDebugLocation value)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (getCurrentLocation != null) {
      return getCurrentLocation(this);
    }
    return orElse();
  }
}

abstract class _GetCurrentLocation implements LocationEvent {
  const factory _GetCurrentLocation() = _$GetCurrentLocationImpl;
}

/// @nodoc
abstract class _$$SetDebugLocationImplCopyWith<$Res> {
  factory _$$SetDebugLocationImplCopyWith(
    _$SetDebugLocationImpl value,
    $Res Function(_$SetDebugLocationImpl) then,
  ) = __$$SetDebugLocationImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocationData? location});

  $LocationDataCopyWith<$Res>? get location;
}

/// @nodoc
class __$$SetDebugLocationImplCopyWithImpl<$Res>
    extends _$LocationEventCopyWithImpl<$Res, _$SetDebugLocationImpl>
    implements _$$SetDebugLocationImplCopyWith<$Res> {
  __$$SetDebugLocationImplCopyWithImpl(
    _$SetDebugLocationImpl _value,
    $Res Function(_$SetDebugLocationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = freezed}) {
    return _then(
      _$SetDebugLocationImpl(
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LocationData?,
      ),
    );
  }

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationDataCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc

class _$SetDebugLocationImpl
    with DiagnosticableTreeMixin
    implements _SetDebugLocation {
  const _$SetDebugLocationImpl({this.location});

  @override
  final LocationData? location;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationEvent.setDebugLocation(location: $location)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationEvent.setDebugLocation'))
      ..add(DiagnosticsProperty('location', location));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetDebugLocationImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetDebugLocationImplCopyWith<_$SetDebugLocationImpl> get copyWith =>
      __$$SetDebugLocationImplCopyWithImpl<_$SetDebugLocationImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestPermission,
    required TResult Function() getCurrentLocation,
    required TResult Function(LocationData? location) setDebugLocation,
  }) {
    return setDebugLocation(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? requestPermission,
    TResult? Function()? getCurrentLocation,
    TResult? Function(LocationData? location)? setDebugLocation,
  }) {
    return setDebugLocation?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestPermission,
    TResult Function()? getCurrentLocation,
    TResult Function(LocationData? location)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (setDebugLocation != null) {
      return setDebugLocation(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermission value) requestPermission,
    required TResult Function(_GetCurrentLocation value) getCurrentLocation,
    required TResult Function(_SetDebugLocation value) setDebugLocation,
  }) {
    return setDebugLocation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermission value)? requestPermission,
    TResult? Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult? Function(_SetDebugLocation value)? setDebugLocation,
  }) {
    return setDebugLocation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermission value)? requestPermission,
    TResult Function(_GetCurrentLocation value)? getCurrentLocation,
    TResult Function(_SetDebugLocation value)? setDebugLocation,
    required TResult orElse(),
  }) {
    if (setDebugLocation != null) {
      return setDebugLocation(this);
    }
    return orElse();
  }
}

abstract class _SetDebugLocation implements LocationEvent {
  const factory _SetDebugLocation({final LocationData? location}) =
      _$SetDebugLocationImpl;

  LocationData? get location;

  /// Create a copy of LocationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetDebugLocationImplCopyWith<_$SetDebugLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LocationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
    LocationState value,
    $Res Function(LocationState) then,
  ) = _$LocationStateCopyWithImpl<$Res, LocationState>;
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationState
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
    extends _$LocationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl with DiagnosticableTreeMixin implements _Initial {
  const _$InitialImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'LocationState.initial'));
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
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LocationState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl with DiagnosticableTreeMixin implements _Loading {
  const _$LoadingImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'LocationState.loading'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LocationState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$PermissionGrantedImplCopyWith<$Res> {
  factory _$$PermissionGrantedImplCopyWith(
    _$PermissionGrantedImpl value,
    $Res Function(_$PermissionGrantedImpl) then,
  ) = __$$PermissionGrantedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionGrantedImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$PermissionGrantedImpl>
    implements _$$PermissionGrantedImplCopyWith<$Res> {
  __$$PermissionGrantedImplCopyWithImpl(
    _$PermissionGrantedImpl _value,
    $Res Function(_$PermissionGrantedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionGrantedImpl
    with DiagnosticableTreeMixin
    implements _PermissionGranted {
  const _$PermissionGrantedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.permissionGranted()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationState.permissionGranted'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermissionGrantedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return permissionGranted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return permissionGranted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (permissionGranted != null) {
      return permissionGranted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return permissionGranted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return permissionGranted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (permissionGranted != null) {
      return permissionGranted(this);
    }
    return orElse();
  }
}

abstract class _PermissionGranted implements LocationState {
  const factory _PermissionGranted() = _$PermissionGrantedImpl;
}

/// @nodoc
abstract class _$$PermissionDeniedImplCopyWith<$Res> {
  factory _$$PermissionDeniedImplCopyWith(
    _$PermissionDeniedImpl value,
    $Res Function(_$PermissionDeniedImpl) then,
  ) = __$$PermissionDeniedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermissionDeniedImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$PermissionDeniedImpl>
    implements _$$PermissionDeniedImplCopyWith<$Res> {
  __$$PermissionDeniedImplCopyWithImpl(
    _$PermissionDeniedImpl _value,
    $Res Function(_$PermissionDeniedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermissionDeniedImpl
    with DiagnosticableTreeMixin
    implements _PermissionDenied {
  const _$PermissionDeniedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.permissionDenied()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationState.permissionDenied'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermissionDeniedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return permissionDenied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return permissionDenied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return permissionDenied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return permissionDenied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (permissionDenied != null) {
      return permissionDenied(this);
    }
    return orElse();
  }
}

abstract class _PermissionDenied implements LocationState {
  const factory _PermissionDenied() = _$PermissionDeniedImpl;
}

/// @nodoc
abstract class _$$LocationReceivedImplCopyWith<$Res> {
  factory _$$LocationReceivedImplCopyWith(
    _$LocationReceivedImpl value,
    $Res Function(_$LocationReceivedImpl) then,
  ) = __$$LocationReceivedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LocationData location});

  $LocationDataCopyWith<$Res> get location;
}

/// @nodoc
class __$$LocationReceivedImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationReceivedImpl>
    implements _$$LocationReceivedImplCopyWith<$Res> {
  __$$LocationReceivedImplCopyWithImpl(
    _$LocationReceivedImpl _value,
    $Res Function(_$LocationReceivedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? location = null}) {
    return _then(
      _$LocationReceivedImpl(
        location: null == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as LocationData,
      ),
    );
  }

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDataCopyWith<$Res> get location {
    return $LocationDataCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc

class _$LocationReceivedImpl
    with DiagnosticableTreeMixin
    implements _LocationReceived {
  const _$LocationReceivedImpl({required this.location});

  @override
  final LocationData location;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.locationReceived(location: $location)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationState.locationReceived'))
      ..add(DiagnosticsProperty('location', location));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationReceivedImpl &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationReceivedImplCopyWith<_$LocationReceivedImpl> get copyWith =>
      __$$LocationReceivedImplCopyWithImpl<_$LocationReceivedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return locationReceived(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return locationReceived?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (locationReceived != null) {
      return locationReceived(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return locationReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return locationReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (locationReceived != null) {
      return locationReceived(this);
    }
    return orElse();
  }
}

abstract class _LocationReceived implements LocationState {
  const factory _LocationReceived({required final LocationData location}) =
      _$LocationReceivedImpl;

  LocationData get location;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationReceivedImplCopyWith<_$LocationReceivedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl with DiagnosticableTreeMixin implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LocationState.error(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LocationState.error'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() permissionGranted,
    required TResult Function() permissionDenied,
    required TResult Function(LocationData location) locationReceived,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? permissionGranted,
    TResult? Function()? permissionDenied,
    TResult? Function(LocationData location)? locationReceived,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? permissionGranted,
    TResult Function()? permissionDenied,
    TResult Function(LocationData location)? locationReceived,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_PermissionGranted value) permissionGranted,
    required TResult Function(_PermissionDenied value) permissionDenied,
    required TResult Function(_LocationReceived value) locationReceived,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_PermissionGranted value)? permissionGranted,
    TResult? Function(_PermissionDenied value)? permissionDenied,
    TResult? Function(_LocationReceived value)? locationReceived,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_PermissionGranted value)? permissionGranted,
    TResult Function(_PermissionDenied value)? permissionDenied,
    TResult Function(_LocationReceived value)? locationReceived,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements LocationState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of LocationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
